import 'package:flutter/material.dart';

import 'audiobookchaplist.dart';

class AudiobookLowerpanel extends StatelessWidget {
  final ScrollController controller;
  final dynamic booktitle;
  final dynamic description;
  final Function callback;
  final dynamic audiolist;
  const AudiobookLowerpanel({
    super.key,
    required this.controller,
    this.booktitle,
    this.description,
    this.audiolist,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 13),
            child: Text(
              booktitle,
              style: TextStyle(
                color: Color.fromARGB(255, 8, 8, 8),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            child: Text(
              description,
              style: TextStyle(
                color: Color.fromARGB(255, 8, 8, 8),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              "Chapters",
              style: TextStyle(
                color: Color.fromARGB(255, 8, 8, 8),
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          AudioBookchapList(snapdata: audiolist, audiodatacallback: callback),
        ],
      ),
    );
  }
}
