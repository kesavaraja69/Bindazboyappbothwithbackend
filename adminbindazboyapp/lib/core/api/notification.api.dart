import 'dart:convert';

import 'package:adminbindazboyapp/app/routes/api.routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationApi {
  final client = http.Client();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Acess-Control-Allow-Origin": "*",
  };

  Future sendnotification({
    required String title,
    required String body,
    required BuildContext context,
  }) async {
    final String suburl = "/notification/firebase/sendnotification";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + suburl);

    final http.Response response = await client.post(
      uri,
      body: jsonEncode({"title": title, "body": body}),
      headers: headers,
    );

    final statuscode = response.statusCode;
    final resbody = response.body;
    if (statuscode == 200) {
      return resbody;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }
}
