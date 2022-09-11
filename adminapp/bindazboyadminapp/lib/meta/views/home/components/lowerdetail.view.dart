import 'package:flutter/material.dart';

class LowerPlane extends StatelessWidget {
  final String blogdetails;
  final ScrollController controller;

  const LowerPlane({
    required this.blogdetails,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.zero,
      children: [bulidAboutpage()],
    );
  }

  Widget bulidAboutpage() => Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        // padding: EdgeInsets.only(top: 7, right: 8, left: 10, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 7, right: 9, left: 15, bottom: 15),
              child: Text(
                blogdetails,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      );
}
