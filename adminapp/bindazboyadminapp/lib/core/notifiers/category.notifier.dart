import 'dart:convert';

import 'package:adminbindazboyapp/core/api/category.api.dart';
import 'package:adminbindazboyapp/core/models/category.model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CategoryNotifer extends ChangeNotifier {
  final CategoryApi categoryApi = new CategoryApi();
  final _logger = Logger();
  Future fetchCategorys({required BuildContext context}) async {
    try {
      var _blogData = await categoryApi.fetchCategorys(context: context);
      var response = await Category.fromJson(json.decode(_blogData));
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went Wrong"),
        ),
      );
    }
  }

  Stream getcatergory({
    required BuildContext context,
  }) =>
      Stream.periodic(Duration(seconds: 2))
          .asyncMap((_) => fetchCategorys(context: context));

  Future addCategory(
      {required BuildContext context, required dynamic catergory}) async {
    final CategoryApi categoryApi = new CategoryApi();
    final _logger = Logger();

    try {
      var categroydata =
          await categoryApi.addCategory(context: context, catergory: catergory);

      final Map<String, dynamic> parsedData = await jsonDecode(categroydata);
      final customStatusCode = parsedData["code"];
      final customMessage = parsedData["message"];

      switch (customStatusCode) {
        case 201:
          _logger.i(customMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;

        case 401:
          _logger.i(customMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;

        case 402:
          _logger.i(customMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(customMessage),
            ),
          );
          break;
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went Wrong"),
        ),
      );
    }
  }
}
