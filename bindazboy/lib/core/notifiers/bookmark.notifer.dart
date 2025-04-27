import 'dart:convert';
import 'package:bindazboy/core/api/bookmark.api.dart';
import 'package:bindazboy/core/models/bookmark.model.dart';
import 'package:bindazboy/core/models/checkbookmark.model.dart';
import 'package:bindazboy/core/notifiers/utility.notifer.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class BookmarkNotifier extends ChangeNotifier {
  final BookmarkAPI _bookmarkApi = BookmarkAPI();
  UtilityNotifier utilityNotifier({required BuildContext context}) =>
      Provider.of<UtilityNotifier>(context, listen: false);

  final _logger = Logger();
  Future addBookmark({
    required BuildContext context,
    required int blog_id,
  }) async {
    try {
      var data = await utilityNotifier(
        context: context,
      ).readUserEmail(context: context);
      var response = await _bookmarkApi.addBookmark(
        useremail: data.toString(),
        blog_id: blog_id,
        context: context,
      );
      final Map<String, dynamic> parsedData = await response;
      final bookmarkStatusCode = parsedData["code"];

      switch (bookmarkStatusCode) {
        case 406:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Already Bookmarked")));
      }
    } catch (e) {
      print(e);
    }
  }

  Future fetchBookmarksByUser({required BuildContext context}) async {
    try {
      var data = await utilityNotifier(
        context: context,
      ).readUserEmail(context: context);
      var response = await _bookmarkApi.fetchBookmarksByUser(
        context: context,
        useremail: data.toString(),
      );

      var modelledData = Bookmark.fromJson(json.decode(response));
      var bookmarkCode = modelledData.code;
      var bookmarkData = modelledData.data;
      //  _logger.i(bookmarkData, bookmarkCode);
      switch (bookmarkCode) {
        case 200:
          {
            return bookmarkData;
          }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Somthing went wrong,try again")));
    }
  }

  Stream getblogs({required BuildContext context}) => Stream.periodic(
    Duration(seconds: 2),
  ).asyncMap((_) => fetchBookmarksByUser(context: context));

  Future deleteBookmark({
    required BuildContext context,
    required dynamic bookmark_id,
  }) async {
    try {
      var response = await _bookmarkApi.deleteBookmark(
        bookmark_id: bookmark_id,
        context: context,
      );
      final Map<String, dynamic> parsedData = await response;
      final bookmarkStatusCode = parsedData["code"];

      switch (bookmarkStatusCode) {
        case 204:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Bookmark removed")));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream checkbookmark({
    required BuildContext context,
    required dynamic blog_id,
  }) => Stream.periodic(
    Duration(seconds: 2),
  ).asyncMap((_) => checkIfBookmarkExists(context: context, blog_id: blog_id));

  Future<bool> checkIfBookmarkExists({
    required BuildContext context,
    required dynamic blog_id,
  }) async {
    var data = await utilityNotifier(
      context: context,
    ).readUserEmail(context: context);
    var response = await _bookmarkApi.checkIfBookmarkExists(
      useremail: data.toString(),
      blog_id: blog_id,
      context: context,
    );
    var modelledData = CheckBookmark.fromJson(json.decode(response));
    final statuscode = modelledData.code;
    if (statuscode == 404) {
      return false;
    } else {
      return true;
    }
  }
}
