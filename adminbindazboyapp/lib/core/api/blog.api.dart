import 'dart:convert';

import 'package:adminbindazboyapp/app/routes/api.routes.dart';
import 'package:adminbindazboyapp/credentials/authuration.credentials.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class BlogAPI {
  final client = http.Client();
  final _logger = Logger();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Acess-Control-Allow-Origin": "*",
    "Authorization": Authuration.Authuraition,
  };

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
    final String subUrl = "/blogs/update/$blog_id";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);
    final http.Response response = await client.put(
      uri,
      body: jsonEncode({
        "blog_title": blog_title,
        "blog_description": blog_description,
        "blog_image": blog_image,
        "blog_category": blog_category,
        "blog_date": blog_date,
        "blog_audio": blog_audio,
        "blog_images": blog_images,
      }),
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    //   _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  Future fetchBlogswithlimit({
    required BuildContext context,
    dynamic pageno,
  }) async {
    final String subUrl = "/blogs/$pageno";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.get(uri, headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;
    // _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  Future updateaudioBlog({
    required BuildContext context,
    required dynamic blog_id,
    required dynamic blog_audio,
  }) async {
    final String subUrl = "/blogs/audioupdate/$blog_id";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);
    final http.Response response = await client.put(
      uri,
      body: jsonEncode({"blog_audio": blog_audio}),
      headers: headers,
    );
    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  Future removeBlogfile({
    required BuildContext context,
    required dynamic filetype,
    required dynamic filename,
    required dynamic deleteid,
    required dynamic fileindex,
  }) async {
    final String subUrl =
        "/blogs/filedelete/$filetype/$filename/$deleteid/$fileindex";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);
    final http.Response response = await client.delete(uri, headers: headers);
    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  Future updateimagesBlog({
    required BuildContext context,
    required dynamic blog_id,
    required dynamic blog_images,
  }) async {
    final String subUrl = "/blogs/imagesupdate/$blog_id";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);
    final http.Response response = await client.put(
      uri,
      body: jsonEncode({"blog_images": blog_images}),
      headers: headers,
    );
    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  Future updateimageBlog({
    required BuildContext context,
    required dynamic blog_id,
    required dynamic blog_image,
  }) async {
    final String subUrl = "/blogs/imageupdate/$blog_id";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);
    final http.Response response = await client.put(
      uri,
      body: jsonEncode({"blog_image": blog_image}),
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
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
    final String subUrl = "/blogs/add/$catergory_id";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.post(
      uri,
      body: jsonEncode({
        "blog_title": blog_title,
        "blog_description": blog_description,
        "blog_image": blog_image,
        "blog_category": blog_category,
        "blog_date": blog_date,
        "blog_audio": blog_audio,
        "blog_images": blog_images,
      }),
      headers: headers,
    );

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  Future fetchBlogs({required BuildContext context}) async {
    final String subUrl = "/blogs";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.get(uri, headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;

    if (statuscode == 200) {
      return body;
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  Future loadingBlogsDetail({
    required BuildContext context,
    required dynamic detailid,
  }) async {
    final String subUrl = "/blogs/detail/$detailid";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.get(uri, headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      //  Navigator.of(context).pushNamed(AppRoutes.ServerRoute);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Somthing went wrong")));
    }
  }

  Future deleteBlogs({
    required BuildContext context,
    required dynamic blogid,
  }) async {
    final String subUrl = "/blogs/delete/$blogid";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.delete(uri, headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      //  Navigator.of(context).pushNamed(AppRoutes.ServerRoute);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Somthing went wrong")));
    }
  }

  Future deleteaudioBlog({
    required BuildContext context,
    required dynamic blogid,
  }) async {
    final String subUrl = "/blogs/deleteaudio/delete/$blogid";
    final Uri uri = Uri.parse(APIRoutes.LocalHost + subUrl);

    final http.Response response = await client.delete(uri, headers: headers);

    final statuscode = response.statusCode;
    final body = response.body;
    _logger.i(body, error: statuscode);
    if (statuscode == 200) {
      return body;
    } else {
      //  Navigator.of(context).pushNamed(AppRoutes.ServerRoute);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Somthing went wrong")));
    }
  }
}
