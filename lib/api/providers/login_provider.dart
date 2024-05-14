import 'package:flutter/material.dart';
import 'package:goalkit/api/responses/login_response.dart';
import 'package:goalkit/resources/helpers/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginProvider with ChangeNotifier {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  LoginResponse? loginResponse;

  final String _firstName = "";
  String get firstName => _firstName;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = "";
  String get message => _message;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> loginUser(
      {required String email, required String password}) async {
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

    //Make API call
    try {
      final response = await http.post(
        Uri.parse('https://api.visualict.co/api/login.php'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _isLoading = false;
        print('main response: $response');
        final responseData = jsonDecode(response.body);
        print('LoginResponse: $responseData');
        loginResponse = LoginResponse.fromJson(responseData);
        isUserLoggedIn = true;
        notifyListeners();
      } else {
        _message = "An error occurred. Please try again";
        throw Exception('Failed to login');
      }
    } catch (error) {
      print('Login Error: $error');
      _isLoading = false;
      _message = "An error occurred. Please try again";
      notifyListeners();
    }
    return isUserLoggedIn;
  }
}
