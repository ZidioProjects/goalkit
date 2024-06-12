import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:goalkit/resources/helpers/connectivity.dart';

class ForgotPasswordProvider extends ChangeNotifier {

  //Confirm password for changePassword
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = "";
  String get message => _message;

  Future<bool> forgotPassword(
      {required String email}) async {
    bool isUserPasswordReset = false;
    final connected = await connectionChecker();
    if (connected) {
      _isLoading = true;
      notifyListeners();

      try {
        final response = await http.post(
          Uri.parse('https://api.visualict.co/api/recover-password.php'),
          body: jsonEncode({'email': email}),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          _isLoading = false;
          _message = "Congratulations, password has been reset for this user and the recovered password sent to the associated mail";
          isUserPasswordReset = true;
          notifyListeners();
        } else {
          _message = "An error occurred. Please try again";
          throw Exception('Failed to login');
        }
        notifyListeners();
      } catch (e) {
        _message = "Please try again";
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _message = "Internet connection is not available";
      _isLoading = false;
      notifyListeners();
    }
    return isUserPasswordReset;
  }
}
