import 'dart:convert';

import 'package:adminbindazboyapp/core/api/zoom.api.dart';
import 'package:adminbindazboyapp/core/models/zoomdetails.model.dart';
import 'package:adminbindazboyapp/meta/widgets/snackbarutitly.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class ZoomNoitifer extends ChangeNotifier {
  final ZoomMeetApi _zoomMeetApi = ZoomMeetApi();

  Future fetchzoomDetail({required BuildContext context}) async {
    try {
      var zoomData = await _zoomMeetApi.fetchzoomDetail(context: context);
      var response = ZoomDetails.fromJson(json.decode(zoomData));
      final zoomBody = response.data;
      final dataCode = response.code;
      //   _logger.i(_blogBody);

      switch (dataCode) {
        case 201:
          notifyListeners();
          return zoomBody;

        case 301:
          devtools.log("zoom check user log $zoomBody");
          return null;

        case 401:
          devtools.log("zoom check user log $zoomBody");
          return null;
      }
    } catch (e) {
      devtools.log("zoom data not found $e");
    }
  }

  Future registerZoom({
    required BuildContext context,
    required dynamic zoomMtPwd,
    required dynamic zoomMtID,
    required dynamic zoomMtTitle,
    required dynamic zoomAvaibleSlot,
    required dynamic zoomTotalSlot,
    required dynamic zoomMtUrl,
    required dynamic zoomdateandtime,
    dynamic zoomUpCompingDate,
  }) async {
    try {
      var userData = await _zoomMeetApi.registerZoom(
        context: context,
        zoomMtPwd: zoomMtPwd,
        zoomMtID: zoomMtID,
        zoomMtTitle: zoomMtTitle,
        zoomAvaibleSlot: zoomAvaibleSlot,
        zoomTotalSlot: zoomTotalSlot,
        zoomMtUrl: zoomMtUrl,
        zoomdateandtime: zoomdateandtime,
      );
      final Map<String, dynamic> parsedData = await jsonDecode(userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          ShowsnackBarUtiltiy.showSnackbar(
            message: "Added zoom",
            context: context,
          );

          // await Provider.of<CacheNotifier>(context, listen: false)
          //     .writeCache(key: "jwtdata", value: authdata)
          //     .whenComplete(() => Navigator.of(context).pushNamedAndRemoveUntil(
          //         AppRoutes.HomeRoute, (route) => false));
          break;

        case 301:
          devtools.log("zoom add log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;

        case 402:
          devtools.log("zoom add log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;
      }
    } catch (error) {
      devtools.log("zoom add api data not found");
    }
  }

  Future updateregisterZoom({
    required BuildContext context,
    required zoomid,
    required dynamic zoomMtPwd,
    required dynamic zoomMtID,
    required dynamic zoomMtTitle,
    required dynamic zoomAvaibleSlot,
    required dynamic zoomTotalSlot,
    required dynamic zoomMtUrl,
    required dynamic zoomdateandtime,
    dynamic zoomUpCompingDate,
  }) async {
    try {
      var userData = await _zoomMeetApi.updateregisterZoom(
        context: context,
        zoomid: zoomid,
        zoomMtPwd: zoomMtPwd,
        zoomMtID: zoomMtID,
        zoomMtTitle: zoomMtTitle,
        zoomAvaibleSlot: zoomAvaibleSlot,
        zoomTotalSlot: zoomTotalSlot,
        zoomMtUrl: zoomMtUrl,
        zoomdateandtime: zoomdateandtime,
        zoomUpCompingDate: zoomUpCompingDate,
      );
      final Map<String, dynamic> parsedData = await jsonDecode(userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          ShowsnackBarUtiltiy.showSnackbar(
            message: "Updated zoom",
            context: context,
          );

          // await Provider.of<CacheNotifier>(context, listen: false)
          //     .writeCache(key: "jwtdata", value: authdata)
          //     .whenComplete(() => Navigator.of(context).pushNamedAndRemoveUntil(
          //         AppRoutes.HomeRoute, (route) => false));
          break;

        case 301:
          devtools.log("zoom upd log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;

        case 402:
          devtools.log("zoom upd log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;
      }
    } catch (error) {
      devtools.log("zoom upd api data not found");
    }
  }

  Future updateZoomavailable({
    required BuildContext context,
    required zoomid,
    required dynamic zoomAvaibleSlot,
  }) async {
    try {
      var userData = await _zoomMeetApi.updateZoomavailable(
        context: context,
        zoomid: zoomid,
        zoomAvaibleSlot: zoomAvaibleSlot,
      );
      final Map<String, dynamic> parsedData = await jsonDecode(userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          ShowsnackBarUtiltiy.showSnackbar(
            message: "Updated av zoom",
            context: context,
          );

          // await Provider.of<CacheNotifier>(context, listen: false)
          //     .writeCache(key: "jwtdata", value: authdata)
          //     .whenComplete(() => Navigator.of(context).pushNamedAndRemoveUntil(
          //         AppRoutes.HomeRoute, (route) => false));
          break;

        case 302:
          devtools.log("zoom av log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;

        case 401:
          devtools.log("zoom av log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;
      }
    } catch (error) {
      devtools.log("zoom av api data not found");
    }
  }

  Future updateZoomIseanble({
    required BuildContext context,
    required zoomid,
    dynamic zoomMeetIsEnable,
  }) async {
    try {
      var userData = await _zoomMeetApi.updateZoomIseanble(
        context: context,
        zoomid: zoomid,
        zoomMeetIsEnable: zoomMeetIsEnable,
      );
      final Map<String, dynamic> parsedData = await jsonDecode(userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          ShowsnackBarUtiltiy.showSnackbar(
            message: "Updated enable zoom",
            context: context,
          );

          // await Provider.of<CacheNotifier>(context, listen: false)
          //     .writeCache(key: "jwtdata", value: authdata)
          //     .whenComplete(() => Navigator.of(context).pushNamedAndRemoveUntil(
          //         AppRoutes.HomeRoute, (route) => false));
          break;

        case 302:
          devtools.log("zoom enable log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;

        case 401:
          devtools.log("zoom enable log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;
      }
    } catch (error) {
      devtools.log("zoom date api data not found");
    }
  }

  Future updateZoomdate({
    required BuildContext context,
    required zoomid,
    dynamic zoomUpCompingDate,
  }) async {
    try {
      var userData = await _zoomMeetApi.updateZoomdate(
        context: context,
        zoomid: zoomid,
        zoomUpCompingDate: zoomUpCompingDate,
      );
      final Map<String, dynamic> parsedData = await jsonDecode(userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          ShowsnackBarUtiltiy.showSnackbar(
            message: "Updated date zoom",
            context: context,
          );

          // await Provider.of<CacheNotifier>(context, listen: false)
          //     .writeCache(key: "jwtdata", value: authdata)
          //     .whenComplete(() => Navigator.of(context).pushNamedAndRemoveUntil(
          //         AppRoutes.HomeRoute, (route) => false));
          break;

        case 302:
          devtools.log("zoom date log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;

        case 401:
          devtools.log("zoom date log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;
      }
    } catch (error) {
      devtools.log("zoom date api data not found");
    }
  }

  Future removeAllUsers({required BuildContext context}) async {
    try {
      var userData = await _zoomMeetApi.removeAllUsers(context: context);
      final Map<String, dynamic> parsedData = await jsonDecode(userData);

      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          ShowsnackBarUtiltiy.showSnackbar(
            message: "Removed All User data",
            context: context,
          );

          // await Provider.of<CacheNotifier>(context, listen: false)
          //     .writeCache(key: "jwtdata", value: authdata)
          //     .whenComplete(() => Navigator.of(context).pushNamedAndRemoveUntil(
          //         AppRoutes.HomeRoute, (route) => false));
          break;

        case 301:
          devtools.log("All User log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;

        case 402:
          devtools.log("All User log $customMessage");
          ShowsnackBarUtiltiy.showSnackbar(
            message: customMessage,
            context: context,
          );
          break;
      }
    } catch (error) {
      devtools.log("All User api data not found");
    }
  }
}
