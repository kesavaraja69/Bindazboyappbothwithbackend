import 'dart:convert';

import 'package:bindazboyadminapp/app/routes/api.routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AuthenticationApi {
  final client = http.Client();
  final _logger = Logger();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Acess-Control-Allow-Origin": "*"
  };

  Future signup(
      {required String admin_email,
      required String admin_password,
      required BuildContext context}) async {
    final String subUrl = "/admin/auth/signup";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);
    final http.Response response = await client.post(uri,
        body: jsonEncode(
            {"admin_email": admin_email, "admin_password": admin_password}),
        headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Somthing went wrong"),
        ),
      );
    }
  }

  Future login(
      {required String admin_email,
      required String admin_password,
      required BuildContext context}) async {
    final String subUrl = "/admin/auth/login";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);
    final http.Response response = await client.post(uri,
        body: jsonEncode(
            {"admin_email": admin_email, "admin_password": admin_password}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Acess-Control-Allow-Origin": "*",
          "Authorization": 'dragonft69\$',
        });

    final statuscode = response.statusCode;
    final body = response.body;
    if (statuscode == 200) {
      _logger.i(body);
      return body;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Somthing went wrong"),
        ),
      );
    }
  }
}
