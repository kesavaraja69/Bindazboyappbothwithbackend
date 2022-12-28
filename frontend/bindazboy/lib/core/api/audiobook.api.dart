import 'package:bindazboy/app/routes/api.routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AudiobookApi {
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Acess-Control-Allow-Origin": "*",
  };

  Future fetchAudioBooksall({
    required BuildContext context,
  }) async {
    final String subUrl = "/audiobook/fetchallaudiobook";

    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.get(uri, headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
        ),
      );
    }
  }

  Future fetchAudioBookdetail(
      {required BuildContext context, required dynamic audioid}) async {
    final String subUrl = "/audiobook/fetchaudiobookithchapter/$audioid";

    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.get(uri, headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
        ),
      );
    }
  }
}
