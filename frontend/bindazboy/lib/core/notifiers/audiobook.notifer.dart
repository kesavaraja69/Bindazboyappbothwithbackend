import 'dart:convert';
import 'package:bindazboy/core/api/audiobook.api.dart';
import 'package:bindazboy/core/models/audiobook/audiobookfetchall.model.dart';
import 'package:bindazboy/core/models/blog.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../meta/utils/showsnackbar.utils.dart';
import '../models/audiobook/audiobookdetail.model.dart';

class AudioBookNotifer extends ChangeNotifier {
  final AudiobookApi audiobookApi = AudiobookApi();

  final _logger = Logger();

  int? _isAudiobookln;
  int? get isAudiobookln => _isAudiobookln;

  Future fetchAudioBooksall({
    required BuildContext context,
  }) async {
    try {
      var _blogData = await audiobookApi.fetchAudioBooksall(context: context);
      var response = AudioBookFetchAll.fromJson(json.decode(_blogData));
      final blogBody = response.data;
      final _blogCode = response.code;
      final _blogMsg = response.message;
      //   _logger.i(_blogBody);

      switch (_blogCode) {
        case 200:
          _logger.i("audio lenght is ${blogBody?.length}");

          _isAudiobookln = blogBody?.length;

          notifyListeners();
          return blogBody;

        case 402:
          _isAudiobookln = 0;
          ShowsnackBarUtiltiy.showSnackbar(
              message: _blogMsg.toString(), context: context);
          notifyListeners();
          return null;

        case 403:
          _isAudiobookln = 0;
          ShowsnackBarUtiltiy.showSnackbar(
              message: _blogMsg.toString(), context: context);
          notifyListeners();
          return null;
      }
    } catch (error) {
      ShowsnackBarUtiltiy.showSnackbar(
          message: "Something went Wrong", context: context);
    }
  }

  Future fetchAudioBookdetail(
      {required BuildContext context, required dynamic audioid}) async {
    try {
      var _blogData = await audiobookApi.fetchAudioBookdetail(
          context: context, audioid: audioid);
      var response = AudioDetailwithChapter.fromJson(json.decode(_blogData));
      final blogBody = response.data;
      final _blogCode = response.code;
      final _blogMsg = response.message;
      //   _logger.i(_blogBody);

      switch (_blogCode) {
        case 200:
          // _logger.i(_blogBody?.length);
          notifyListeners();
          return blogBody;

        case 402:
          ShowsnackBarUtiltiy.showSnackbar(
              message: _blogMsg.toString(), context: context);
          notifyListeners();
          return null;

        case 403:
          ShowsnackBarUtiltiy.showSnackbar(
              message: _blogMsg.toString(), context: context);
          notifyListeners();
          return null;
      }
    } catch (error) {
      ShowsnackBarUtiltiy.showSnackbar(
          message: "Something went Wrong", context: context);
    }
  }
}
