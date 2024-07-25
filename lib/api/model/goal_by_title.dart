import 'package:intl/intl.dart';

class GoalByTitle {
  final String id;
  final String tag;
  final String affirmation;
  final String taskTitle;
  final String category;
  final DateTime dateAdded;

  GoalByTitle({
    required this.id,
    required this.tag,
    required this.affirmation,
    required this.taskTitle,
    required this.category,
    required this.dateAdded,
  });

  factory GoalByTitle.fromJson(Map<String, dynamic> json) {
    return GoalByTitle(
      id: json['id'],
      tag: json['tag'],
      affirmation: json['affirmation'],
      taskTitle: json['task_title'],
      category: json['category'],
      //dateAdded: json['date_added'],
      dateAdded: DateTime.fromMillisecondsSinceEpoch(int.parse(json['date_added']) * 1000),
    );
  }

  String get formattedDateAdded {
    return DateFormat('dd-MM-yyyy').format(dateAdded);
  }
}