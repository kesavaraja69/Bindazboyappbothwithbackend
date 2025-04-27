import 'dart:convert';
import 'package:bindazboy/core/api/catergory.api.dart';
import 'package:bindazboy/core/models/blogcatergory.model.dart';
import 'package:bindazboy/core/models/catergorys.model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CatergoryBlogNotifer extends ChangeNotifier {
  final CatergorysAPI catergoryblogAPI = CatergorysAPI();

  int? _numberofblog = 1;
  int? get numberofblog => _numberofblog;
  final _logger = Logger();
  Future fetchBlogs({required BuildContext context}) async {
    try {
      var blogData = await catergoryblogAPI.fetchCatergory(context: context);
      var response = Category.fromJson(json.decode(blogData));
      final blogBody = response.data;
      final blogCode = response.code;
      final blogReceived = response.received;
      // _logger.i(_blogBody);
      if (blogReceived) {
        switch (blogCode) {
          case 200:
            return blogBody;
        }
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }

  Future fetchCatergoryBlogs({
    required BuildContext context,
    required dynamic category,
  }) async {
    try {
      var blogData = await catergoryblogAPI.fetchCatergoryBlogs(
        context: context,
        category: category.toString(),
      );
      var response = BlogCatergory.fromJson(json.decode(blogData));
      final blogBody = response.data;
      final blogCode = response.code;
      final blogReceived = response.received;

      if (blogReceived) {
        switch (blogCode) {
          case 200:
            //  _logger.i(_blogBody);
            return blogBody;
        }
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }

  Future fetchCatergoryBlogswithlimit({
    required BuildContext context,
    required dynamic catergory_title,
    required dynamic pageno,
  }) async {
    try {
      var blogData = await catergoryblogAPI.fetchCatergoryBlogswithlimit(
        context: context,
        catergory_title: catergory_title,
        pageno: pageno,
      );
      var response = BlogCatergory.fromJson(json.decode(blogData));
      final blogBody = response.data;
      final blogCode = response.code;
      final blogReceived = response.received;

      if (blogReceived) {
        switch (blogCode) {
          case 200:
            //  _logger.i(_blogBody);
            _numberofblog = response.totalcount;
            notifyListeners();
            return blogBody;
        }
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }
}
