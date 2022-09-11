import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  AuthResponse(
    this.user,
    this.authentication,
    this.message,
    this.code,
  );

  String user;
  String authentication;
  String message;
  int code;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        json['user'],
        json["authentication"],
        json["message"],
        json["code"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "authentication": authentication,
        "message": message,
        "code": code,
      };
}
