import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Icon(Icons.signal_cellular_connected_no_internet_4_bar, size: 62),
          SizedBox(
            height: 20,
          ),
          Text("No internet connection",
              style: TextStyle(color: Colors.lightGreenAccent, fontSize: 26)),
          SizedBox(
            height: 30,
          ),
          Text("Bindazboy",
              style: TextStyle(color: Colors.lightGreenAccent, fontSize: 16)),
        ],
      )),
    );
  }
}
