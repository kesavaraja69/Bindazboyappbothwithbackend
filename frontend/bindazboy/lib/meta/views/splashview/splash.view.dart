import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow[50],
        body: Stack(children: [
          Positioned(
              top: 160,
              left: 50,
              right: 50,
              child: Image(
                height: 220,
                width: 220,
                image: AssetImage('assets/images/icolgn2.png'),
              )),
          Positioned(
            top: 400,
            left: 50,
            right: 50,
            child: Container(
              child: Image(
                height: 260,
                width: 260,
                image: AssetImage('assets/q5.png'),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
