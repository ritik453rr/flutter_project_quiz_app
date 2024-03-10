class UserModel {
  late String name;
  late String email;
  late String mobile;
  late String password;

  UserModel(
      {required this.name,
      required this.email,
      required this.mobile,
      required this.password});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        email: map['email'],
        mobile: map['mobile'],
        password: map['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": password,
    };
  }
}
