import 'dart:convert';

Adminlogin adminloginFromJson(String str) =>
    Adminlogin.fromJson(json.decode(str));

String adminloginToJson(Adminlogin data) => json.encode(data.toJson());

class Adminlogin {
  Adminlogin(
    this.user,
    this.authentication,
    this.message,
    this.code,
  );

  String user;
  String authentication;
  String message;
  int code;

  factory Adminlogin.fromJson(Map<String, dynamic> json) => Adminlogin(
        json["user"],
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
