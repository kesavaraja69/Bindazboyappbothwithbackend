import 'dart:convert';

import 'package:bindazboyadminapp/app/routes/api.routes.dart';
import 'package:bindazboyadminapp/credentials/authuration.credentials.dart';
import 'package:bindazboyadminapp/meta/widgets/snackbarutitly.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devtools show log;

class ZoomMeetApi {
  final client = http.Client();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Acess-Control-Allow-Origin": "*",
    "Authorization": Authuration.Authuraition
  };

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

  Future registerZoom(
      {required BuildContext context,
      required dynamic zoomMtPwd,
      required dynamic zoomMtID,
      required dynamic zoomMtTitle,
      required dynamic zoomAvaibleSlot,
      required dynamic zoomTotalSlot,
      required dynamic zoomMtUrl,
      required dynamic zoomdateandtime,
      dynamic zoomUpCompingDate}) async {
    final String subUrl = "/zoomall/Addzoom";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.post(
      uri,
      body: jsonEncode({
        "zoomMeetId": zoomMtID,
        "zoomMeetPassword": zoomMtPwd,
        "zoom_Available_Slots": zoomAvaibleSlot,
        "zoom_Total_Slots": zoomTotalSlot,
        "zoommeetURL": zoomMtUrl,
        "zoomMeetTopic": zoomMtTitle,
        "zoommeetdateandtime": zoomdateandtime,
        "zoommeetupcomingdate": zoomUpCompingDate
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

  Future updateregisterZoom(
      {required BuildContext context,
      required zoomid,
      required dynamic zoomMtPwd,
      required dynamic zoomMtID,
      required dynamic zoomMtTitle,
      required dynamic zoomAvaibleSlot,
      required dynamic zoomTotalSlot,
      required dynamic zoomMtUrl,
      required dynamic zoomdateandtime,
      dynamic zoomUpCompingDate}) async {
    final String subUrl = "/zoomall/updatezoom/$zoomid";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.put(
      uri,
      body: jsonEncode({
        "zoomMeetId": zoomMtID,
        "zoomMeetPassword": zoomMtPwd,
        "zoom_Available_Slots": zoomAvaibleSlot,
        "zoom_Total_Slots": zoomTotalSlot,
        "zoommeetURL": zoomMtUrl,
        "zoomMeetTopic": zoomMtTitle,
        "zoommeetdateandtime": zoomdateandtime,
        "zoommeetupcomingdate": zoomUpCompingDate
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

  Future updateZoomavailable({
    required BuildContext context,
    required zoomid,
    required dynamic zoomAvaibleSlot,
  }) async {
    final String subUrl = "/zoomall/updatezoomslot/$zoomid";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.put(
      uri,
      body: jsonEncode({
        "zoom_Available_Slots": zoomAvaibleSlot,
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

  Future updateZoomdate({
    required BuildContext context,
    required zoomid,
    dynamic zoomUpCompingDate,
  }) async {
    final String subUrl = "/zoomall/updatezoomdate/$zoomid";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.put(
      uri,
      body: jsonEncode({"zoommeetupcomingdate": zoomUpCompingDate}),
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

  Future updateZoomIseanble({
    required BuildContext context,
    required zoomid,
    dynamic zoomMeetIsEnable,
  }) async {
    final String subUrl = "/zoomall/updatezoomsisenable/$zoomid";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.put(
      uri,
      body: jsonEncode({"zoomMeetIsEnable": zoomMeetIsEnable}),
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

  Future removeAllUsers({
    required BuildContext context,
  }) async {
    final String subUrl = "/zoomall/removeAllUser";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.delete(
      uri,
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
}
