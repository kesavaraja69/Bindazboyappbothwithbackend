import 'dart:convert';

import 'package:adminbindazboyapp/core/api/category.api.dart';
import 'package:adminbindazboyapp/core/models/category.model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CategoryNotifer extends ChangeNotifier {
  final CategoryApi categoryApi = CategoryApi();
  final _logger = Logger();
  Future fetchCategorys({required BuildContext context}) async {
    try {
      var blogData = await categoryApi.fetchCategorys(context: context);
      var response = Category.fromJson(json.decode(blogData));
      final blogBody = response.data;
      final blogCode = response.code;
      final blogReceived = response.received;

      if (blogReceived) {
        switch (blogCode) {
          case 200:
            _logger.i(blogBody);
            return blogBody;
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }

  Stream getcatergory({required BuildContext context}) => Stream.periodic(
    Duration(seconds: 2),
  ).asyncMap((_) => fetchCategorys(context: context));

  Future addCategory({
    required BuildContext context,
    required dynamic catergory,
  }) async {
    final CategoryApi categoryApi = CategoryApi();
    final logger = Logger();

    try {
      var categroydata = await categoryApi.addCategory(
        context: context,
        catergory: catergory,
      );

      final Map<String, dynamic> parsedData = await jsonDecode(categroydata);
      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          logger.i(customMessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(customMessage)));
          break;

        case 401:
          logger.i(customMessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(customMessage)));
          break;

        case 402:
          logger.i(customMessage);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(customMessage)));
          break;
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went Wrong")));
    }
  }
}
