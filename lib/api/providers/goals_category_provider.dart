import 'package:flutter/material.dart';
import 'package:goalkit/api/model/goal.dart';
import 'package:goalkit/api/model/goal_by_category.dart';
import 'package:goalkit/api/model/goal_by_title.dart';
import 'package:goalkit/resources/helpers/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoalsAndCategoryProvider with ChangeNotifier {
  final categoryController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = "";
  String get message => _message;

  List<Goal> _goals = [];
  List<Goal> get goals => _goals;

  List<GoalByCategory> _goalsByCategory = [];
  List<GoalByCategory> get goalsByCategory => _goalsByCategory;

  List<GoalByTitle> _goalsByTitle = [];
  List<GoalByTitle> get goalsByTitle => _goalsByTitle;

  Future<bool> addGoal({
      required category,
      required taskTitle,
      required email,
      String? affirmation,
      String? tag,
      String? actionPlan,
      String? actionPlanFrequency,
      String? document
    }) async {
    bool connected = await connectionChecker();
    bool isGoalCreated = false;


    if (connected) {
      _isLoading = true;
      notifyListeners();
      try {
        final response = await http.post(
          Uri.parse('https://api.visualict.co/api/addGoal.php'),
          body: jsonEncode({
            'category': category,
            'task_title': taskTitle,
            'email': email,
            'affirmation': affirmation,
            'tag': tag,
            'action_plan': actionPlan,
            'action_plan_frequency': actionPlanFrequency,
            'document': document,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          _isLoading = false;
          isGoalCreated = true;
          print("Response: ${response.body}");
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
   return isGoalCreated;
  }

  Future<bool> addGoalCategory({
    required categoryName,
  }) async {
    bool connected = await connectionChecker();
    bool isCategoryCreated = false;

    if (connected) {
      _isLoading = true;
      notifyListeners();
      try {
        final response = await http.post(
          Uri.parse('https://api.visualict.co/api/addGoalCategory.php'),
          body: jsonEncode({
            'category_name': categoryName
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          print("Response: ${response.body}");
          isCategoryCreated = true;
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
    }
    return isCategoryCreated;
  }

  Future<void> fetchCategories() async {
    bool connected = await connectionChecker();

    if(connected){
      _isLoading = true;
      notifyListeners();

      try {
        final response = await http.get(
          Uri.parse('https://api.visualict.co/api/getCategories'),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          _isLoading = false;
          final List<dynamic> data = json.decode(response.body);
          _goals = data.map((json) => Goal.fromJson(json)).toList();
          _message = '';
        } else {
          _message = 'Failed to load goals';
        }
      } catch (error) {
        _message = 'An error occurred: $error';
      }
      _isLoading = false;
      notifyListeners();
     }
    }

  Future<void> fetchGoalsByCategory(
      String categoryName
      ) async {
    bool connected = await connectionChecker();

    if(connected){
      _isLoading = true;
      notifyListeners();

      try {
        final response = await http.post(
          Uri.parse('https://api.visualict.co/api/getGoalByCategory'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'category_name': categoryName}),
        );

        if (response.statusCode == 200) {
          print('Response ${response.body}');
          final List<dynamic> responseData = json.decode(response.body);
          print('ResponseData $responseData');
          _goalsByCategory = responseData.map((data) => GoalByCategory.fromJson(data)).toList();
          notifyListeners();
        } else {
          throw Exception('Failed to fetch goals by category');
        }
      } catch (error) {
        _message = 'An error occurred: $error';
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<GoalByTitle>> fetchGoalDetails(String title) async {
    final response = await http.post(
      Uri.parse('https://api.visualict.co/api/getGoalByTitle'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title}),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => GoalByTitle.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load goal details');
    }
  }

}
