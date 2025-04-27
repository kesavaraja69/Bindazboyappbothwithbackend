import 'dart:convert';
import 'package:bindazboy/app/routes/api.routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AuthenticationAPI {
  final client = http.Client();
  final _logger = Logger();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Acess-Control-Allow-Origin": "*",
  };

  Future createNewAccount({
    required BuildContext context,
    required String username,
    required String useremail,
    required String userpassword,
  }) async {
    final String subUrl = "/user/create-new-account";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.post(
      uri,
      body: jsonEncode({
        "username": username,
        "useremail": useremail,
        "userpassword": userpassword,
      }),
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Somthing went wrong")));
    }
  }

  Future login({
    required BuildContext context,
    required String useremail,
    required String userpassword,
  }) async {
    final String subUrl = "/user/login";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.post(
      uri,
      body: jsonEncode({"useremail": useremail, "userpassword": userpassword}),
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Somthing went wrong")));
    }
  }
}
