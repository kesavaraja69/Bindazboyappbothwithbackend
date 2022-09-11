import 'dart:convert';
import 'package:bindazboy/app/routes/api.routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ForgotPasswordAPI {
  final client = http.Client();
  final _logger = Logger();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Acess-Control-Allow-Origin": "*",
  };

  Future forgotPassword({
    required BuildContext context,
    required String useremail,
  }) async {
    final String subUrl = "/forgotpassword/user";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.post(
      uri,
      body: jsonEncode({
        "useremail": useremail,
      }),
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, statuscode);
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

  Future otpVerification({
    required BuildContext context,
    required String otpcode,
    required dynamic useremail,
  }) async {
    final String subUrl = "/forgotpassword/rest-password/$useremail";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.post(
      uri,
      body: jsonEncode({
        "otpcode": otpcode,
      }),
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, statuscode);
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

  Future updatePassword({
    required BuildContext context,
    required String updateforgotPassword,
    required dynamic useremail,
  }) async {
    final String subUrl = "/forgotpassword/update-password/$useremail";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.put(
      uri,
      body: jsonEncode({
        "updateforgotPassword": updateforgotPassword,
      }),
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, statuscode);
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
}
