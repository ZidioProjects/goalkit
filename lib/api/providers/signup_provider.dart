import 'package:flutter/material.dart';
import 'package:goalkit/resources/helpers/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpProvider with ChangeNotifier {
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = "";
  String get message => _message;

  Future<bool> signupUser(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    bool isAccountCreated = false;
    _isLoading = true;
    notifyListeners();

    // Check internet connectivity
    final connected = await connectionChecker();
    if (!connected) {
      _message = "Internet connection is not available";
      _isLoading = false;
      notifyListeners();
      return isAccountCreated;
    }

    //Make API call
    try {
      final response = await http.post(
        Uri.parse('https://api.visualict.co/api/signup.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          "firstname": firstName,
          "lastname": lastName,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('SignUpResponse: $responseData');
        isAccountCreated = true;
        //final res = SignUpResponse.fromJson(json.decode(responseData));
        notifyListeners();
      } else {
        _message = "An error occurred. Please try again";
        throw Exception('Failed to SignUp');
      }
    } catch (error) {
      print('SignUp Error: $error');
      _message = "An error occurred. Please try again";
      _isLoading = false;
      notifyListeners();
    }
    return isAccountCreated;
  }
}
