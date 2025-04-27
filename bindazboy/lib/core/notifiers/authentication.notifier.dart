import 'dart:convert';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/api/authentication.api.dart';
import 'package:bindazboy/core/models/auth_response.model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'cache.notifier.dart';

class AuthenticationNotifer extends ChangeNotifier {
  final AuthenticationAPI authenticationAPI = AuthenticationAPI();

  String? _loggedUserEmail;
  String? get loggedUserEmail => _loggedUserEmail;

  final _logger = Logger();
  Future createNewAccount({
    required BuildContext context,
    required String username,
    required String useremail,
    required String userpassword,
  }) async {
    try {
      var userData = await authenticationAPI.createNewAccount(
        context: context,
        username: username,
        useremail: useremail,
        userpassword: userpassword,
      );
      final Map<String, dynamic> parsedData = await jsonDecode(userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];
      final authdata = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          _loggedUserEmail = parsedData["user"];
          notifyListeners();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Register Sucessfully")));
          await Provider.of<CacheNotifier>(
            context,
            listen: false,
          ).writeCache(key: "key2", value: _loggedUserEmail.toString());
          await Provider.of<CacheNotifier>(context, listen: false)
              .writeCache(key: "jwtdata", value: authdata)
              .whenComplete(
                () => Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.HomeRoute,
                  (route) => false,
                ),
              );
          break;

        case 400:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(customMessage)));
          break;

        case 403:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(customMessage)));
          break;
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }

  Future login({
    required BuildContext context,
    required String useremail,
    required String userpassword,
  }) async {
    try {
      var userData = await authenticationAPI.login(
        context: context,
        useremail: useremail,
        userpassword: userpassword,
      );
      var response = AuthResponse.fromJson(jsonDecode(userData));
      final customStatusCode = response.code;
      final customMessage = response.message;

      //  _logger.i(customMessage, customStatusCode);

      switch (customStatusCode) {
        case 201:
          final authdata = response.message;
          _loggedUserEmail = response.user;
          final user = response.user;
          _logger.i(response.user);
          notifyListeners();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("$user Logged in")));
          await Provider.of<CacheNotifier>(
            context,
            listen: false,
          ).writeCache(key: "key2", value: user.toString());
          await Provider.of<CacheNotifier>(context, listen: false)
              .writeCache(key: "jwtdata", value: authdata.toString())
              .whenComplete(
                () => Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.HomeRoute,
                  (route) => false,
                ),
              );
          break;

        case 401:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(customMessage.toString())));
          break;

        case 402:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("user not found")));
          break;

        case 404:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("user not found")));
          break;

        case 409:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Wrong Password")));
          break;

        case 403:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(customMessage.toString())));
          break;
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }
}
