class GoalByCategory {
  final String id;
  final String taskTitle;
  final String category;
  final String dateAdded;

  GoalByCategory({
    required this.id,
    required this.taskTitle,
    required this.category,
    required this.dateAdded,
  });

  factory GoalByCategory.fromJson(Map<String, dynamic> json) {
    return GoalByCategory(
      id: json['id'],
      taskTitle: json['task_title'],
      category: json['category'],
      dateAdded: json['date_added'],
    );
  }
}