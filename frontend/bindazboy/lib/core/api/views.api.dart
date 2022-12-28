import 'dart:convert';

import 'package:bindazboy/app/routes/api.routes.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ViewsApi {
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Controll-Allow-Origin": "*",
  };

  //! post only
  Future featchpostViews(
      {required BuildContext context, required dynamic blog_id}) async {
    final _logger = Logger();
    final subURL = "/views/fetchpost/$blog_id";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subURL);

    final http.Response response = await client.get(uri, headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;
    if (statuscode == 200) {
      _logger.i("add view api is $body");
      return body;
    } else {
      ShowsnackBarUtiltiy.showSnackbar(
          message: "Something Went Wrong in serverside", context: context);
    }
  }

  Future checkpostViews(
      {required BuildContext context,
      required dynamic blog_id,
      required dynamic useremail}) async {
    final subURL = "/views/checkviewpost/$useremail/$blog_id";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subURL);

    final http.Response response = await client.get(uri, headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;

    if (statuscode == 200) {
      return body;
    } else {
      ShowsnackBarUtiltiy.showSnackbar(
          message: "Something Went Wrong in serverside", context: context);
    }
  }

  Future addpostViews(
      {required BuildContext context,
      required dynamic useremail,
      required dynamic post_id}) async {
    const subURL = "/views/addviewpost";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subURL);

    final http.Response response = await client.post(uri,
        body: jsonEncode({"useremail": useremail, "blog_id": post_id}),
        headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;
    //_logger.i("add view api is $body");
    if (statuscode == 200) {
      return body;
    } else {
      ShowsnackBarUtiltiy.showSnackbar(
          message: "Something Went Wrong in serverside", context: context);
    }
  }
}
