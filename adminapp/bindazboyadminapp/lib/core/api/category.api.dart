import 'dart:convert';

import 'package:bindazboyadminapp/app/routes/api.routes.dart';
import 'package:bindazboyadminapp/credentials/authuration.credentials.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class CategoryApi {
  final client = http.Client();
  final _logger = Logger();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Acess-Control-Allow-Origin": "*",
    "Authorization": Authuration.Authuraition
  };

  Future fetchCategorys({required BuildContext context}) async {
    final String subUrl = "/catergory/categorys";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.get(uri, headers: headers);

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

  Future addCategory(
      {required BuildContext context, required dynamic catergory}) async {
    final String subUrl = "/catergory/add";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.post(uri,
        headers: headers, body: jsonEncode({"catergory_title": catergory}));

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
}
