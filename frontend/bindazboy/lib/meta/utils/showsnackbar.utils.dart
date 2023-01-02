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

Widget labeltext(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 19,
              fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}
