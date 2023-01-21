import 'dart:convert';

import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/api/forgotpassword.api.dart';
import 'package:bindazboy/meta/utils/otpverify_arguments.dart';
import 'package:bindazboy/meta/utils/updatepasswod_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';

class ForgotPasswordNotifer extends ChangeNotifier {
  final ForgotPasswordAPI forgotPasswordAPI = new ForgotPasswordAPI();
  final _logger = Logger();

  Future forgotPassword({
    required BuildContext context,
    required String useremail,
  }) async {
    try {
      var _userData = await forgotPasswordAPI.forgotPassword(
          context: context, useremail: useremail);

      final Map<String, dynamic> parsedData = await jsonDecode(_userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          EasyLoading.dismiss();
          await Navigator.of(context).pushNamed(AppRoutes.VerifyOTPRoute,
              arguments: OTPVerfiyArguments(useremail: useremail));
          break;
        case 404:
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;

        case 403:
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;

        case 402:
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;
      }
    } catch (error) {
      _logger.i(error);
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went Wrong"),
        ),
      );
    }
  }

  Future otpVerification({
    required BuildContext context,
    required String useremail,
    required String otpcode,
  }) async {
    try {
      var _userData = await forgotPasswordAPI.otpVerification(
          context: context, otpcode: otpcode, useremail: useremail);

      final Map<String, dynamic> parsedData = await jsonDecode(_userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          await Navigator.of(context).pushNamed(AppRoutes.UpdatePasswordRoute,
              arguments: UpdatePasswordArguments(useremail: useremail));
          break;
        case 301:
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
        case 306:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;

        case 305:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;

        case 500:
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
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went Wrong"),
        ),
      );
    }
  }

  Future updatePassword({
    required BuildContext context,
    required String updateforgotPassword,
    required dynamic useremail,
  }) async {
    try {
      var _userData = await forgotPasswordAPI.updatePassword(
          context: context,
          updateforgotPassword: updateforgotPassword,
          useremail: useremail);

      final Map<String, dynamic> parsedData = await jsonDecode(_userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          await Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.LoginRoute, (route) => true);
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
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went Wrong"),
        ),
      );
    }
  }
}
