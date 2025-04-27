import 'dart:convert';
import 'package:bindazboy/core/api/blog.api.dart';
import 'package:bindazboy/core/models/blog.model.dart';
import 'package:bindazboy/core/models/blogdetail.model.dart';
import 'package:bindazboy/core/models/search.model.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class BlogNotifer extends ChangeNotifier {
  final BlogAPI blogAPI = BlogAPI();
  // final CacheService _cacheService = new CacheService();
  final _logger = Logger();
  int? _numberofblog = 1;
  int? get numberofblog => _numberofblog;
  Future fetchBlogs({required BuildContext context}) async {
    try {
      var blogData = await blogAPI.fetchBlogs(context: context);
      var response = Blogs.fromJson(json.decode(blogData));
      final blogBody = response.data;
      final blogCode = response.code;
      final blogReceived = response.received;
      //   _logger.i(_blogBody);

      if (blogReceived) {
        switch (blogCode) {
          case 200:
            return blogBody;
          case 304:
            return ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(blogReceived.toString())));
        }
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  Future fetchBlogswithlimit({
    required BuildContext context,
    dynamic pageno,
  }) async {
    try {
      var blogData = await blogAPI.fetchBlogswithlimit(
        context: context,
        pageno: pageno,
      );
      var response = Blogs.fromJson(json.decode(blogData));
      final blogBody = response.data;
      final blogCode = response.code;
      final blogReceived = response.received;
      //   _logger.i(_blogBody);

      if (blogReceived) {
        switch (blogCode) {
          case 200:
            _numberofblog = response.totalcount;
            notifyListeners();
            return blogBody;
          case 304:
            return ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(blogReceived.toString())));
        }
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  Future searchBlog({
    required BuildContext context,
    required dynamic query,
  }) async {
    var blogData = await blogAPI.searchBlog(context: context, query: query);
    try {
      var response = Searchblog.fromJson(json.decode(blogData));

      final blogBody = response.data;
      final blogCode = response.code;

      _logger.i(blogBody);

      switch (blogCode) {
        case 200:
          return blogBody;
        case 402:
          return Text("Try agian");
        case 404:
          return Text("Something went Wrong");
      }
    } catch (e) {
      _logger.i(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }

  Future addviewupdatepost({
    required BuildContext context,
    required dynamic blog_id,
    required dynamic post_view,
  }) async {
    var data = await blogAPI.addviewupdatepost(
      context: context,
      blog_id: blog_id,
      post_view: post_view,
    );

    final Map<String, dynamic> parsedData = await json.decode(data);

    final customStatusCode = parsedData['code'];
    final viewdata = parsedData['message'];

    //  _logger.i("like is added code $customStatusCode");

    switch (customStatusCode) {
      case 201:
        return viewdata;
      case 301:
        ShowsnackBarUtiltiy.showSnackbar(message: viewdata, context: context);
        break;
      case 401:
        ShowsnackBarUtiltiy.showSnackbar(message: viewdata, context: context);
        break;
    }
  }

  Future loadingBlogsDetail({
    required BuildContext context,
    required dynamic detailid,
  }) async {
    try {
      var blogData = await blogAPI.loadingBlogsDetail(
        context: context,
        detailid: detailid,
      );

      var response = Blogdetails.fromJson(json.decode(blogData));
      final blogBody = response.data;
      final blogCode = response.code;
      final blogReceived = response.received;
      _logger.i(blogBody);
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
}
