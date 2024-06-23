import 'package:flutter/material.dart';
import 'package:goalkit/api/responses/login_response.dart';
import 'package:goalkit/resources/helpers/connectivity.dart';
import 'package:goalkit/resources/navigation/bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginProvider with ChangeNotifier {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  LoginResponse? loginResponse;

  String _firstName = "";
  String get firstName => _firstName;

  String _lastName = "";
  String get lastName => _lastName;

  String _userName = "";
  String get userName => _userName;

  String _email = "";
  String get email => _email;

  String _loginEmail = "";
  String get loginEmail => _loginEmail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = "";
  String get message => _message;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool _isSigningIn = false;

  LoginProvider() {
    _isSigningIn = false;
    _checkLoginState();
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool value) {
    _isSigningIn = value;
    notifyListeners();
  }

  Future<void> _checkLoginState() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userName = user.displayName ?? '';
      _firstName = user.email ?? '';
      _lastName = user.email ?? '';
      _email = user.email ?? '';
      _loginEmail = user.email ?? '';
      notifyListeners();
    }
  }

  Future<void> _saveLoginState({String? userName, String? firstName, String? lastName, String? email, String? loginEmail}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    if (userName != null) {
      await prefs.setString('userName', userName);
    }
    if (firstName != null) {
      await prefs.setString('firstName', firstName);
    }
    if (lastName != null) {
      await prefs.setString('lastName', lastName);
    }
    if (email != null) {
      await prefs.setString('email', email);
    }
    if (loginEmail != null) {
      await prefs.setString('loginEmail', loginEmail);
    }
  }

  Future<void> _clearLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userName');
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('email');
    await prefs.remove('loginEmail');
  }

  Future<bool> loginUser({required String email, required String password}) async {
    bool isUserLoggedIn = false;
    _isLoading = true;
    notifyListeners();

    // Check internet connectivity
    final connected = await connectionChecker();
    if (!connected) {
      _message = "Internet connection is not available";
      _isLoading = false;
      notifyListeners();
      return isUserLoggedIn;
    }

    // Make API call
    try {
      final response = await http.post(
        Uri.parse('https://api.visualict.co/api/login.php'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = jsonDecode(response.body);
      loginResponse = LoginResponse.fromJson(responseData);
      if (response.statusCode == 200 && loginResponse?.status == true) {
        _isLoading = false;
        final responseData = jsonDecode(response.body);
        loginResponse = LoginResponse.fromJson(responseData);
        _firstName = loginResponse?.firstname ?? 'User';
        _lastName = loginResponse?.lastname ?? 'User';
        _loginEmail = loginResponse?.email ?? 'useremail@gmail.com';
        await _saveLoginState(firstName: _firstName);
        await _saveLoginState(firstName: _lastName);
        await _saveLoginState(firstName: _loginEmail);
        isUserLoggedIn = true;
        notifyListeners();
      } else {
        _message = "An error occurred. Please try again";
        throw Exception('Failed to login');
      }
    } catch (error) {
      _isLoading = false;
      _message = "An error occurred. Please try again";
      notifyListeners();
    }
    return isUserLoggedIn;
  }

  Future<void> googleLogin(BuildContext context) async {
    isSigningIn = true;
    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? user = await googleSignIn.signIn();

      if (user == null) {
        // User canceled the sign-in
        isSigningIn = false;
        return;
      }

      // Obtain the Google authentication details
      final GoogleSignInAuthentication googleAuth = await user.authentication;

      // Create a new credential using the obtained tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the new credential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Fetch user name from Google account
      _userName = userCredential.user?.displayName ?? 'User';
      _email = userCredential.user?.email ?? 'useremail@gmail.com';
      await _saveLoginState(userName: _userName);
      await _saveLoginState(email: _email);
      notifyListeners();

      // Navigate to the HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Nav()),
      );
    } catch (error) {
      // Handle errors appropriately
      print('Login failed: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text("An error occurred. Please try again"),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      isSigningIn = false;
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    _firstName = '';
    _userName = '';
    _lastName = '';
    _email = '';
    _loginEmail = '';
    loginFormKey.currentState?.dispose();
    await _clearLoginState();
    notifyListeners();
  }
}
