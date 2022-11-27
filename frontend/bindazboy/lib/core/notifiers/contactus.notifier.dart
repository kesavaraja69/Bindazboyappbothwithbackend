import 'dart:convert';

import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/api/contactus.api.dart';
import 'package:bindazboy/core/notifiers/cache.notifier.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ContactusNotifier extends ChangeNotifier {
  final _logger = Logger();
  String? _loggedgmail1;
  String? get loggedgmail1 => _loggedgmail1;

  ContactusApi contactusApi = ContactusApi();

  Future addContactus({usname, usmessage, iscontactus, context}) async {
    try {
      final cahce = Provider.of<CacheNotifier>(context, listen: false);
      await cahce.readCache(key: "key2").then((value) {
        _loggedgmail1 = value;
      });

      var _contactusdata = await contactusApi.addContactus(
        useremail: _loggedgmail1,
        usname: usname,
        usmessage: usmessage,
        iscontactus: iscontactus,
        context: context,
      );

      final Map<String, dynamic> parsedData = await json.decode(_contactusdata);

      final customStatusCode = parsedData['code'];
      final contactrptdata = parsedData['data'];

      //  _logger.i("like is added code $customStatusCode");

      switch (customStatusCode) {
        case 201:
          Navigator.of(context).pushNamed(AppRoutes.HomeRoute);
          ShowsnackBarUtiltiy.showSnackbar(
              message: contactrptdata, context: context);
          break;
        case 202:
          ShowsnackBarUtiltiy.showSnackbar(
              message: contactrptdata, context: context);
          break;
        case 402:
          ShowsnackBarUtiltiy.showSnackbar(
              message: contactrptdata, context: context);
          break;
        case 406:
          ShowsnackBarUtiltiy.showSnackbar(
              message: contactrptdata, context: context);
          break;
      }
    } catch (error) {
      _logger.i(error);
    }
  }
}
