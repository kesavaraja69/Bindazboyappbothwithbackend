import 'dart:convert';

import 'package:bindazboy/core/api/views.api.dart';
import 'package:bindazboy/core/notifiers/cache.notifier.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ViewsNotifier extends ChangeNotifier {
  final _logger = Logger();
  String? _loggedgmail1;
  String? get loggedgmail1 => _loggedgmail1;
  final ViewsApi viewApi = ViewsApi();
  dynamic _viewidData;
  dynamic get viewidData => _viewidData;
  dynamic _fetchviewData;
  dynamic get fetchviewData => _fetchviewData;

  bool? _isFetchviewData;
  bool? get isFetchviewData => _isFetchviewData;

  dynamic _viewidData2;
  dynamic get viewidData2 => _viewidData2;

  bool? _isviewData;
  bool? get isviewData => _isviewData;

  Future addView(
      {required BuildContext context, required dynamic fspostid}) async {
    try {
      final cahce = Provider.of<CacheNotifier>(context, listen: false);
      await cahce.readCache(key: "key2").then((value) {
        _loggedgmail1 = value;
      });

      var _viewdata = await viewApi.addpostViews(
          context: context, useremail: _loggedgmail1, post_id: fspostid);

      final Map<String, dynamic> parsedData = await json.decode(_viewdata);

      final customStatusCode = parsedData['code'];
      final viewdata = parsedData['data'];

      //  _logger.i("like is added code $customStatusCode");

      switch (customStatusCode) {
        case 201:
          return viewdata;
        // ShowsnackBarUtiltiy.showSnackbar(message: likedata, context: context);
        case 403:
          ShowsnackBarUtiltiy.showSnackbar(message: viewdata, context: context);
          break;
        case 402:
          ShowsnackBarUtiltiy.showSnackbar(message: viewdata, context: context);
          break;
      }
    } catch (error) {
      _logger.i(error);
    }
  }

  Future featchViews(
      {required BuildContext context, required dynamic post_id}) async {
    try {
      var _likedata =
          await viewApi.featchpostViews(context: context, blog_id: post_id);
      final Map<String, dynamic> parsedData = await json.decode(_likedata);

      final customStatusCode = parsedData['code'];
      final viewdata = parsedData['data'];
      //  final parsedData = FetchLike.fromJson(json.decode(_likedata));

      //  final customStatusCode = parsedData.code;
      //  final viewdata = parsedData.data.length;
      _logger.i("view is added code $customStatusCode");
      switch (customStatusCode) {
        case 201:
          //  _isFetchviewData = recived;

          // var parsedDatalike = FetchLike.fromJson(json.decode(_likedata));
          _viewidData2 = viewdata.length.toString();
          _logger.i("view is added code $_viewidData2");
          //  }
          notifyListeners();
          return viewdata.length.toString();

        case 204:
          _viewidData2 = "0";
          notifyListeners();
          return "0";
      }
    } catch (error) {
      _logger.i(error);
    }
  }

  Future checkViews({
    required BuildContext context,
    required dynamic post_id,
  }) async {
    try {
      final cahce = Provider.of<CacheNotifier>(context, listen: false);

      await cahce.readCache(key: "key2").then((value) {
        _loggedgmail1 = value;
      });

      _logger.i("logged user like fn is $_loggedgmail1");

      var _likedata = await viewApi.checkpostViews(
          context: context, blog_id: post_id, useremail: _loggedgmail1);

      final Map<String, dynamic> parsedData = await json.decode(_likedata);

      final customStatusCode = parsedData["code"];
      final customData = parsedData["isViewed"];

      //  final customStatusCode = parsedDatalike.code;
      //  _islikeData = customData;
      _logger.i("logged user like fn is $customData");
      // _logger
      //     .i("check like notifer model id is ${parsedDatalike.message.likeId}");

      switch (customStatusCode) {
        case 201:
          _isviewData = customData;

          notifyListeners();
          return _isviewData = true;
        case 301:
          // _islikeData = customData;
          notifyListeners();
          return _isviewData = false;
      }
    } catch (error) {
      _logger.i(error);
    }
  }
}
