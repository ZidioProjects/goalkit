import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:goalkit/resources/helpers/connectivity.dart';

class ChangeUserPasswordProvider extends ChangeNotifier {
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = "";
  String get message => _message;

  Future<bool> changeUserPassword(
      {required String email,
      required String oldPassword,
      required String newPassword}) async {
    bool isUserPasswordChanged = false;
    final connected = await connectionChecker();
    if (connected) {
      _isLoading = true;
      notifyListeners();

      try {
        final response = await http.post(
          Uri.parse('https://api.visualict.co/api/change-password.php'),
          body: jsonEncode(
              {'email': email, 'c_password': oldPassword, 'password': newPassword}),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          _isLoading = false;
          _message = "Password changed successfully";
          isUserPasswordChanged = true;
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
    return isUserPasswordChanged;
  }
}
