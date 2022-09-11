import 'dart:convert';
import 'package:bindazboy/core/api/catergory.api.dart';
import 'package:bindazboy/core/models/blogcatergory.model.dart';
import 'package:bindazboy/core/models/catergorys.model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CatergoryBlogNotifer extends ChangeNotifier {
  final CatergorysAPI catergoryblogAPI = new CatergorysAPI();
  // final CacheService _cacheService = new CacheService();
  final _logger = Logger();
  Future fetchBlogs({
    required BuildContext context,
  }) async {
    try {
      var _blogData = await catergoryblogAPI.fetchCatergory(context: context);
      var response = await Category.fromJson(json.decode(_blogData));
      final _blogBody = response.data;
      final _blogCode = response.code;
      final _blogReceived = response.received;
      _logger.i(_blogBody);
      if (_blogReceived) {
        switch (_blogCode) {
          case 200:
            return _blogBody;
        }
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

  Future fetchCatergoryBlogs(
      {required BuildContext context, required dynamic category}) async {
    try {
      var _blogData = await catergoryblogAPI.fetchCatergoryBlogs(
          context: context, category: category.toString());
      var response = await BlogCatergory.fromJson(json.decode(_blogData));
      final _blogBody = response.data;
      final _blogCode = response.code;
      final _blogReceived = response.received;

      if (_blogReceived) {
        switch (_blogCode) {
          case 200:
            _logger.i(_blogBody);
            return _blogBody;
        }
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
