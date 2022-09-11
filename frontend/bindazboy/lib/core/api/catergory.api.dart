import 'package:bindazboy/app/routes/api.routes.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class CatergorysAPI {
  final client = http.Client();
  final _logger = Logger();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Acess-Control-Allow-Origin": "*",
  };

  Future fetchCatergoryBlogs(
      {required BuildContext context, required dynamic category}) async {
    final String subUrl = "/blogs/categorys/$category";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.get(
      uri,
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, statuscode);
    if (statuscode == 200) {
      _logger.i(body, statuscode);
      return body;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Somthing went wrong"),
        ),
      );
    }
  }

  Future fetchCatergory({required BuildContext context}) async {
    final String subUrl = "/catergory/categorys";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.get(
      uri,
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

  Future loadingCatergoryBlogsDetail({
    required BuildContext context,
    required dynamic detailid,
  }) async {
    final String subUrl = "/blogs/detail/$detailid";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.get(
      uri,
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      Navigator.of(context).pushNamed(AppRoutes.ServerRoute);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Somthing went wrong"),
        ),
      );
    }
  }
}
