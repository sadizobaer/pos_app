// To parse this JSON data, do
//
//     final loginDataModel = loginDataModelFromJson(jsonString);

import 'dart:convert';

LoginDataModel loginDataModelFromJson(String str) => LoginDataModel.fromJson(json.decode(str));

String loginDataModelToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginDataModel {
  LoginDataModel({
    required this.message,
    required this.user,
  });

  String message;
  User user;

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.role,
    required this.permissions,
  });

  int id;
  String name;
  String email;
  dynamic avatar;
  String role;
  List<String> permissions;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    role: json["role"],
    permissions: List<String>.from(json["permissions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": avatar,
    "role": role,
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
  };
}
