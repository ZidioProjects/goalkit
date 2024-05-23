import 'package:flutter/material.dart';
import 'package:goalkit/api/responses/login_response.dart';
import 'package:goalkit/resources/helpers/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoalsCategoryProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = "";
  String get message => _message;

  //post name of category
  Future<void> postCategoryName({required categoryName}) async {

    bool connected = await connectionChecker();

    if (connected) {
      _isLoading = true;
      notifyListeners();
      try {
        final response = await http.post(
          Uri.parse('https://api.visualict.co/api/addTaskCategory.php'),
          body: jsonEncode({'category_name': categoryName}),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          _isLoading = false;
          notifyListeners();
        } else {
          _message = "An error occurred. Please try again";
          throw Exception('Failed to login');
        }
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
  }



}
