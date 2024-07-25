class AddCategoryResponse {
  String? message;
  bool? status;

  AddCategoryResponse({
    this.message,
    this.status,
  });

  factory AddCategoryResponse.fromJson(Map<String, dynamic> json) {
    return AddCategoryResponse(
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
