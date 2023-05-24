import 'dart:convert';

import 'package:bindazboy/app/routes/api.routes.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devtools show log;

class ZoomMeetApi {
  final client = http.Client();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Acess-Control-Allow-Origin": "*",
  };

  Future registerZoom({
    required BuildContext context,
    required String username,
    required String useremail,
    required dynamic zoomid,
  }) async {
    final String subUrl = "/zoomall/Adduserzoom";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.post(
      uri,
      body: jsonEncode({
        "zoomMeetUser": username,
        "zoomMeetUserEmail": useremail,
        "zoomId": zoomid
      }),
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    // _logger.i(body, statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Somthing went wrong"),
        ),
      );
      devtools.log("auth api data not found");
    }
  }

  Future checkzoomUser({
    required BuildContext context,
    required dynamic useremail,
  }) async {
    final subURL = "/zoomall/checkuserzoom/$useremail";
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

  Future fetchzoomDetail({
    required BuildContext context,
  }) async {
    final subURL = "/zoomall/getzoomdetail";
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

  Future updatezoomSlot(
      {required BuildContext context,
      required dynamic zoomid,
      required nofSlots}) async {
    final subURL = "/zoomall/updatezoomslot/$zoomid";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subURL);

    final http.Response response = await client.put(
      uri,
      headers: headers,
      body: jsonEncode({
        "zoom_Available_Slots": nofSlots,
      }),
    );

    final statuscode = response.statusCode;
    final body = response.body;

    if (statuscode == 200) {
      return body;
    } else {
      ShowsnackBarUtiltiy.showSnackbar(
          message: "Something Went Wrong in serverside", context: context);
    }
  }
}
