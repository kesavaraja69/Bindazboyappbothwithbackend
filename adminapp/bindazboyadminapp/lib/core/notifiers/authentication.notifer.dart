import 'dart:convert';
import 'package:bindazboyadminapp/app/routes/app.routes.dart';
import 'package:bindazboyadminapp/core/api/authentication.api.dart';
import 'package:bindazboyadminapp/core/notifiers/cache.notifier.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationApi authenticationApi = new AuthenticationApi();
  final _logger = Logger();
  Future signup(
      {required String admin_email,
      required String admin_password,
      required BuildContext context}) async {
    try {
      var _userData = await authenticationApi.signup(
          admin_email: admin_email,
          admin_password: admin_password,
          context: context);
      final Map<String, dynamic> parsedData = await jsonDecode(_userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];
      final authdata = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Register Sucessfully"),
            ),
          );
          await Provider.of<CacheNotifer>(context, listen: false)
              .writeCache(key: "jwtdata", value: authdata)
              .whenComplete(() => Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.HomeRoute, (route) => false));

          break;
        case 406:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;
        case 405:
          _logger.i(customMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;
        case 403:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;
      }
    } catch (error) {
      _logger.i(error);
    }
  }

  Future login(
      {required String admin_email,
      required String admin_password,
      required BuildContext context}) async {
    try {
      var _userData = await authenticationApi.login(
          admin_email: admin_email,
          admin_password: admin_password,
          context: context);

      final Map<String, dynamic> parsedData = await jsonDecode(_userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];
      final authdata = parsedData["message"];
      final user = parsedData["user"];

      print("data is $authdata");

      switch (customStatusCode) {
        case 201:
          _logger.i(user);
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("$user Logged in"),
          ));

          await Provider.of<CacheNotifer>(context, listen: false)
              .writeCache(key: "jwtdata", value: authdata)
              .whenComplete(() => Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.HomeRoute, (route) => false));

          break;
        case 401:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;
        case 404:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;
        case 403:
          _logger.i(customMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;
        case 402:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;
      }
    } catch (error) {
      _logger.i(error);
    }
  }
}
