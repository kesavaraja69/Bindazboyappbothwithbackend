import 'package:flutter/material.dart';

class ShowsnackBarUtiltiy {
  static showSnackbar(
      {required String message, required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Color.fromARGB(221, 16, 20, 14)),
        ),
      ),
    );
  }
}
