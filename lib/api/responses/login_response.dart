class LoginResponse {
  String? id;
  String? lastname;
  String? firstname;
  String? email;
  String? password;
  String? phone;
  String? gender;
  String? createdOn;
  String? apiKey;
  bool? loggedIn;
  bool? status;

  LoginResponse({
    this.id,
    this.lastname,
    this.firstname,
    this.email,
    this.password,
    this.phone,
    this.gender,
    this.createdOn,
    this.apiKey,
    this.loggedIn,
    this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      lastname: json['lastname'],
      firstname: json['firstname'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      gender: json['gender'],
      createdOn: json['createdOn'],
      apiKey: json['apiKey'],
      loggedIn: json['loggedIn'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastname': lastname,
      'firstname': firstname,
      'email': email,
      'password': password,
      'phone': phone,
      'gender': gender,
      'createdOn': createdOn,
      'apiKey': apiKey,
      'loggedIn': loggedIn,
      'status': status,
    };
  }
}
