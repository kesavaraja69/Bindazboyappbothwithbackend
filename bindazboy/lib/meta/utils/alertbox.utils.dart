import 'package:bindazboy/app/constant/colors.dart';
import 'package:flutter/material.dart';

class AlertdailogBoxgm {
  static showAlertbox({
    onclick1,
    onclick2,
    content,
    title,
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: BConstantColors.backgroundColor,
            title: Text(title),
            content: content,
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
            actionsOverflowButtonSpacing: 20,
            buttonPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            actions: [
              ElevatedButton(
                onPressed: onclick1,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 14, 14, 14),
                  minimumSize: const Size(80, 45),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              ElevatedButton(
                onPressed: onclick2,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 14, 14, 14),
                  minimumSize: const Size(80, 45),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                child: const Text(
                  "No",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(9)),
            ),
          ),
    );
  }

  static showAlertbox2({
    onclick1,
    content,
    title,
    isCorrect,
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: contentBox(
              context: context,
              title: title,
              descriptions: content,
              isCorrect: isCorrect,
              onclick1: onclick1,
            ),
          ),
    );
  }
}

contentBox({context, title, descriptions, onclick1, isCorrect}) {
  final mheigth = MediaQuery.of(context).size.height;
  final mwidth = MediaQuery.of(context).size.width;
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: mheigth * 0.01),
        margin: EdgeInsets.only(top: mheigth * 0.035),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: BConstantColors.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(0, 3), blurRadius: 5),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(top: mwidth * 0.06),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: mwidth * 0.07,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15),
              Text(
                descriptions,
                style: TextStyle(
                  fontSize: mwidth * 0.06,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: onclick1,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 14, 14, 14),
                      minimumSize: const Size(80, 45),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        left: mwidth * 0.1,
        right: mwidth * 0.1,
        child: CircleAvatar(
          backgroundColor: Colors.black87,
          radius: mwidth * 0.06,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Center(
              child: Icon(
                isCorrect ? Icons.check_circle_outline : Icons.close_rounded,
                color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                size: 29,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
