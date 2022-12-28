import 'dart:convert';

import 'package:bindazboy/app/routes/api.routes.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:http/http.dart' as http;

class ContactusApi {
  final client = http.Client();

  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Access-Controll-Allow-Origin": "*",
  };
  Future addContactus(
      {useremail, usname, usmessage, iscontactus, context}) async {
    const subURL = "/contactusandreport/addcontactusandreport";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subURL);

    final http.Response response = await client.post(
      uri,
      headers: headers,
      body: jsonEncode({
        "useremail": useremail,
        "usname": usname,
        "usmessage": usmessage,
        "iscontactus": iscontactus,
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
