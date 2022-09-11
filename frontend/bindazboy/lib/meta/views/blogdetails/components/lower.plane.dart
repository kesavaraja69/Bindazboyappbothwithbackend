import 'package:audioplayers/audioplayers.dart';
import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/meta/views/blogdetails/components/audio_player.dart';
import 'package:bindazboy/meta/views/blogdetails/components/imagesList.dart';
import 'package:flutter/material.dart';

class LowerPlane extends StatelessWidget {
  final String blogdetails;
  final dynamic audioplay;
  final dynamic images;
  final ScrollController controller;
  final AudioPlayer advancedPlayer;

  const LowerPlane(
      {required this.blogdetails,
      required this.controller,
      required this.advancedPlayer,
      this.audioplay,
      this.images});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.zero,
      children: [bulidAboutpage(context)],
    );
  }

  Widget bulidAboutpage(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        // padding: EdgeInsets.only(top: 7, right: 8, left: 10, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            images == null ? Container() : ImageList(images: images),
            audioplay == null
                ? Container()
                : AudioFile(
                    advancedPlayer: advancedPlayer,
                    url: audioplay,
                  ),
            Padding(
              padding: EdgeInsets.only(top: 7, right: 9, left: 15, bottom: 15),
              child: Text(
                blogdetails,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: BConstantColors.descrptionColor, fontSize: 15),
              ),
            ),
          ],
        ),
      );
}
