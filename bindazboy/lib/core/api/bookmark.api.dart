import 'dart:convert';
import 'package:bindazboy/app/routes/api.routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class BookmarkAPI {
  final client = http.Client();
  final _logger = Logger();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Acess-Control-Allow-Origin": "*",
  };

  Future addBookmark({
    required BuildContext context,
    required String useremail,
    required int blog_id,
  }) async {
    final String subUrl = "/bookmark/add";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.post(
      uri,
      body: jsonEncode({"useremail": useremail, "blog_id": blog_id}),
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    //  _logger.i(body, statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Somthing went wrong")));
    }
  }

  Future fetchBookmarksByUser({
    required BuildContext context,
    required String useremail,
  }) async {
    final String subUrl = "/bookmark/user/$useremail";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.get(uri, headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;

    if (statuscode == 200) {
      // _logger.i(body, statuscode);
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Somthing went wrong")));
    }
  }

  Future deleteBookmark({
    required BuildContext context,
    required dynamic bookmark_id,
  }) async {
    final String subUrl = "/bookmark/delete/$bookmark_id";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.delete(uri, headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;
    //  _logger.i(body, statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Somthing went wrong")));
    }
  }

  Future checkIfBookmarkExists({
    required BuildContext context,
    required String useremail,
    required dynamic blog_id,
  }) async {
    final String subUrl = "/bookmark/checkIfExists";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.post(
      uri,
      headers: headers,
      body: jsonEncode({"useremail": useremail, "blog_id": blog_id}),
    );

    final statuscode = response.statusCode;
    final body = response.body;
    // _logger.i(body, statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Somthing went wrong")));
    }
  }
}
