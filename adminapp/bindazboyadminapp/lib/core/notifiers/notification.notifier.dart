import 'dart:convert';

import 'package:bindazboyadminapp/core/api/notification.api.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NotificationNotifiter extends ChangeNotifier {
  final NotificationApi notificationApi = new NotificationApi();
  final _logger = Logger();
  Future sendnotification(
      {required String title,
      required String body,
      required BuildContext context}) async {
    try {
      var _notificationdata = await notificationApi.sendnotification(
          title: title, body: body, context: context);
      final Map<String, dynamic> parsedData =
          await jsonDecode(_notificationdata);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Send Notification Sucessfully"),
            ),
          );
          break;
        case 401:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;
      }
    } catch (e) {
      _logger.i(e);
    }
  }
}
