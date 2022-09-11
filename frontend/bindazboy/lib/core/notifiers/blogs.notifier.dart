import 'dart:convert';
import 'package:bindazboy/core/api/blog.api.dart';
import 'package:bindazboy/core/models/blog.model.dart';
import 'package:bindazboy/core/models/blogdetail.model.dart';
import 'package:bindazboy/core/models/search.model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class BlogNotifer extends ChangeNotifier {
  final BlogAPI blogAPI = new BlogAPI();
  // final CacheService _cacheService = new CacheService();
  final _logger = Logger();
  Future fetchBlogs({
    required BuildContext context,
  }) async {
    try {
      var _blogData = await blogAPI.fetchBlogs(
        context: context,
      );
      var response = await Blogs.fromJson(json.decode(_blogData));
      final _blogBody = response.data;
      final _blogCode = response.code;
      final _blogReceived = response.received;
      //   _logger.i(_blogBody);

      if (_blogReceived) {
        switch (_blogCode) {
          case 200:
            return _blogBody;
          case 304:
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_blogReceived.toString()),
              ),
            );
        }
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  Future searchBlog({
    required BuildContext context,
    required dynamic query,
  }) async {
    var _blogData = await blogAPI.searchBlog(context: context, query: query);
    try {
      var response = await Searchblog.fromJson(json.decode(_blogData));

      final _blogBody = response.data;
      final _blogCode = response.code;

      _logger.i(_blogBody);

      switch (_blogCode) {
        case 200:
          return _blogBody;
        case 402:
          return Text("Try agian");
        case 404:
          return Text("Something went Wrong");
      }
    } catch (e) {
      _logger.i(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went Wrong"),
        ),
      );
    }
  }

  Future loadingBlogsDetail({
    required BuildContext context,
    required dynamic detailid,
  }) async {
    try {
      var _blogData = await blogAPI.loadingBlogsDetail(
          context: context, detailid: detailid);

      var response = await Blogdetails.fromJson(json.decode(_blogData));
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
}
