import 'dart:convert';
import 'package:bindazboy/core/api/zoom.api.dart';
import 'package:bindazboy/core/models/zoomdetails.model.dart';
import 'package:bindazboy/core/notifiers/cache.notifier.dart';
import 'package:bindazboy/meta/utils/alertbox.utils.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as devtools show log;

class ZoomNoitifer extends ChangeNotifier {
  final ZoomMeetApi _zoomMeetApi = ZoomMeetApi();

  bool? _isUserRegistered;
  bool? get isUserRegistered => _isUserRegistered;

  Future<bool> _logoutdailog({text, isZoom, context}) async {
    return await AlertdailogBoxgm.showAlertbox2(
            context: context,
            onclick1: () async {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            title: "Message",
            content: text,
            isCorrect: isZoom) ??
        false;
  }

  Future registerZoom({
    required BuildContext context,
    required String username,
    required String useremail,
    required dynamic zoomid,
  }) async {
    try {
      final cacheprovider = Provider.of<CacheNotifier>(context, listen: false);

      var userData = await _zoomMeetApi.registerZoom(
          context: context,
          username: username,
          useremail: useremail,
          zoomid: zoomid);
      final Map<String, dynamic> parsedData = await jsonDecode(userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          cacheprovider.writeCache(key: "Zoomuser", value: useremail);

          _isUserRegistered = true;

          notifyListeners();

          return true;

        case 400:
          devtools.log("zoom rg log $customMessage");
          await cacheprovider.writeCache(key: "Zoomuser", value: useremail);
          await _logoutdailog(
              context: context,
              text: "Email is Already Registered",
              isZoom: false);

          return false;

        case 301:
          devtools.log("zoom rg log $customMessage");
          // ShowsnackBarUtiltiy.showSnackbar(
          //     message: "Email is Not Registered", context: context);
          await _logoutdailog(
              context: context, text: "Email is Not Registered", isZoom: false);
          break;

        case 403:
          devtools.log("zoom rg log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
              message: customMessage, context: context);
          break;

        case 402:
          devtools.log("zoom rg log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
              message: customMessage, context: context);
          break;
      }
    } catch (error) {
      devtools.log("zoom rg api data not found");
      ShowsnackBarUtiltiy.showSnackbar(
          message: error.toString(), context: context);
    }
  }

  Future checkzoomUser({
    required BuildContext context,
  }) async {
    try {
      final cacheprovider = Provider.of<CacheNotifier>(context, listen: false);

      final userem = await cacheprovider.readCache(key: "Zoomuser");
      var userData =
          await _zoomMeetApi.checkzoomUser(context: context, useremail: userem);
      final Map<String, dynamic> parsedData = await jsonDecode(userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];
      switch (customStatusCode) {
        case 201:
          //await cacheprovider.writeCache(key: "Zoomuser", value: userem);
          devtools.log("zoom check user log $customMessage");
          _isUserRegistered = true;
          notifyListeners();
          return true;

        case 301:
          devtools.log("zoom check user log $customMessage");
          _isUserRegistered = false;
          notifyListeners();
          return false;

        case 402:
          devtools.log("zoom check user log $customMessage");
          _isUserRegistered = false;
          notifyListeners();
          return false;
      }
    } catch (error) {
      devtools.log("zoom check user api data not found $error");
    }
  }

  Future updatezoomSlot(
      {required BuildContext context,
      required dynamic zoomid,
      required nofSlots}) async {
    try {
      var userData = await _zoomMeetApi.updatezoomSlot(
          context: context, zoomid: zoomid, nofSlots: nofSlots);
      final Map<String, dynamic> parsedData = await jsonDecode(userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];
      switch (customStatusCode) {
        case 201:
          //await cacheprovider.writeCache(key: "Zoomuser", value: userem);
          devtools.log("zoom slot update log $customMessage");
          return true;

        case 302:
          devtools.log("zoom slot update log $customMessage");
          return false;

        case 401:
          devtools.log("zoom slot update log $customMessage");
          return false;
      }
    } catch (error) {
      devtools.log("zoom slot update api data not found $error");
      return false;
    }
  }

  Future fetchzoomDetail({
    required BuildContext context,
  }) async {
    try {
      var _zoomData = await _zoomMeetApi.fetchzoomDetail(context: context);
      var response = await ZoomDetails.fromJson(json.decode(_zoomData));
      final _zoomBody = response.data;
      final _dataCode = response.code;
      //   _logger.i(_blogBody);

      switch (_dataCode) {
        case 201:
          notifyListeners();
          return _zoomBody;

        case 301:
          devtools.log("zoom check user log $_zoomBody");
          return null;

        case 401:
          devtools.log("zoom check user log $_zoomBody");
          return null;
      }
    } catch (e) {
      devtools.log("zoom data not found $e");
    }
  }
}
