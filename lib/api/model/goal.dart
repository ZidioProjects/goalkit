class Goal {
  final String categoryName;
  final String dateAdded;

  Goal({required this.categoryName, required this.dateAdded});

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      categoryName: json['category_name'],
      dateAdded: json['date_added'],
    );
  }
}
