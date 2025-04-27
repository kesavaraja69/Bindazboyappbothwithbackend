import 'dart:convert';

import 'package:adminbindazboyapp/core/api/blog.api.dart';
import 'package:adminbindazboyapp/core/models/blogdetails.model.dart';
import 'package:adminbindazboyapp/core/models/blogs.model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class BlogNotifer extends ChangeNotifier {
  final BlogAPI blogAPI = BlogAPI();
  // final CacheService _cacheService = new CacheService();
  final _logger = Logger();

  int? _numberofblog = 1;
  int? get numberofblog => _numberofblog;

  Future updateimageBlog({
    required BuildContext context,
    required dynamic blog_id,
    required dynamic blog_image,
  }) async {
    try {
      var blogupdate = await blogAPI.updateimageBlog(
        context: context,
        blog_id: blog_id,
        blog_image: blog_image,
      );
      final Map<String, dynamic> parsedData = await jsonDecode(blogupdate);
      final statuscode = parsedData["code"];
      final statusmessage = parsedData["message"];

      switch (statuscode) {
        case 201:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
        case 401:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
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

  Future updateimagesBlog({
    required BuildContext context,
    required dynamic blog_id,
    required dynamic blog_images,
  }) async {
    try {
      var blogupdate = await blogAPI.updateimagesBlog(
        context: context,
        blog_id: blog_id,
        blog_images: blog_images,
      );
      final Map<String, dynamic> parsedData = await jsonDecode(blogupdate);
      final statuscode = parsedData["code"];
      final statusmessage = parsedData["message"];
      switch (statuscode) {
        case 201:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
        case 401:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }

  Future updateaudioBlog({
    required BuildContext context,
    required dynamic blog_id,
    required dynamic blog_audio,
  }) async {
    try {
      var blogupdate = await blogAPI.updateaudioBlog(
        context: context,
        blog_id: blog_id,
        blog_audio: blog_audio,
      );
      final Map<String, dynamic> parsedData = await jsonDecode(blogupdate);
      final statuscode = parsedData["code"];
      final statusmessage = parsedData["message"];

      switch (statuscode) {
        case 201:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
        case 401:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
      }
    } catch (error) {
      _logger.i(error);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Something went Wrong"),
      //   ),
      // );
    }
  }

  Future removeBlogfile({
    required BuildContext context,
    required dynamic filetype,
    required dynamic filename,
    dynamic deleteid,
    dynamic fileindex,
  }) async {
    try {
      var blogupdate = await blogAPI.removeBlogfile(
        context: context,
        filetype: filetype,
        filename: filename,
        deleteid: deleteid,
        fileindex: fileindex,
      );
      final Map<String, dynamic> parsedData = await jsonDecode(blogupdate);
      final statuscode = parsedData["code"];
      final statusmessage = parsedData["message"];

      switch (statuscode) {
        case 201:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
        case 401:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
        case 302:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
        case 303:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
      }
    } catch (error) {
      _logger.i(error);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Something went Wrong"),
      //   ),
      // );
    }
  }

  Future updateBlogs({
    required BuildContext context,
    required dynamic blog_id,
    required dynamic blog_title,
    required dynamic blog_description,
    required dynamic blog_image,
    required dynamic blog_category,
    required dynamic blog_date,
    dynamic blog_audio,
    dynamic blog_images,
  }) async {
    try {
      var blogupdate = await blogAPI.updateBlogs(
        context: context,
        blog_id: blog_id,
        blog_title: blog_title,
        blog_description: blog_description,
        blog_image: blog_image,
        blog_category: blog_category,
        blog_date: blog_date,
        blog_audio: blog_audio,
        blog_images: blog_images,
      );

      final Map<String, dynamic> parsedData = await jsonDecode(blogupdate);
      final statuscode = parsedData["code"];
      final statusmessage = parsedData["message"];

      switch (statuscode) {
        case 201:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
        case 401:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }

  Future addBlogs({
    required BuildContext context,
    required dynamic catergory_id,
    required dynamic blog_title,
    required dynamic blog_description,
    required dynamic blog_image,
    required dynamic blog_category,
    required dynamic blog_date,
    dynamic blog_audio,
    dynamic blog_images,
  }) async {
    try {
      var blogadd = await blogAPI.addBlogs(
        context: context,
        catergory_id: catergory_id,
        blog_title: blog_title,
        blog_description: blog_description,
        blog_image: blog_image,
        blog_category: blog_category,
        blog_audio: blog_audio,
        blog_images: blog_images,
        blog_date: blog_date,
      );

      final Map<String, dynamic> parsedData = await jsonDecode(blogadd);
      final statuscode = parsedData["code"];
      final statusmessage = parsedData["message"];

      switch (statuscode) {
        case 201:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
        case 401:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
        case 409:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }

  Future fetchBlogs({required BuildContext context}) async {
    try {
      var blogData = await blogAPI.fetchBlogs(context: context);
      var response = Blogs.fromJson(json.decode(blogData));
      final blogBody = response.data;
      final blogCode = response.code;
      final blogReceived = response.received;
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

  Stream getblogs({required BuildContext context}) => Stream.periodic(
    Duration(seconds: 2),
  ).asyncMap((_) => fetchBlogs(context: context));

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
      _logger.i(blogBody);

      switch (blogCode) {
        case 200:
          return blogBody;
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }

  Future deleteaudioBlog({
    required BuildContext context,
    required dynamic blogid,
  }) async {
    try {
      var blogDelete = await blogAPI.deleteaudioBlog(
        context: context,
        blogid: blogid,
      );

      final Map<String, dynamic> parsedData = await jsonDecode(blogDelete);
      final statuscode = parsedData["code"];
      final statusmessage = parsedData["message"];

      switch (statuscode) {
        case 201:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));

          break;
        case 302:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
        case 402:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }

  Future deleteBlogs({
    required BuildContext context,
    required dynamic blogid,
  }) async {
    try {
      var blogDelete = await blogAPI.deleteBlogs(
        context: context,
        blogid: blogid,
      );

      final Map<String, dynamic> parsedData = await jsonDecode(blogDelete);
      final statuscode = parsedData["code"];
      final statusmessage = parsedData["message"];

      switch (statuscode) {
        case 201:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));

          break;
        case 302:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
        case 402:
          _logger.i(statuscode, error: statusmessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(statusmessage)));
          break;
      }
    } catch (error) {
      _logger.i(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }
}
