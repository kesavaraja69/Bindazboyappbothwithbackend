import 'package:bindazboy/app/constant/colors.dart';
import 'package:flutter/material.dart';

class AlertdailogBoxgm {
  static showAlertbox(
      {onclick1, onclick2, content, title, required BuildContext context}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: BConstantColors.backgroundColor,
              title: Text(title),
              content: content,
              titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
              actionsOverflowButtonSpacing: 20,
              buttonPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              actions: [
                ElevatedButton(
                  onPressed: onclick1,
                  child: const Text("Yes",
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 14, 14, 14),
                    minimumSize: const Size(80, 45),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: onclick2,
                  child: const Text("No",
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 14, 14, 14),
                    minimumSize: const Size(80, 45),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(9)),
              ),
            ));
  }
}
