import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/meta/views/blogdetails/components/audio_player.dart';
import 'package:bindazboy/meta/views/blogdetails/components/imagesList.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LowerPlane extends StatelessWidget {
  final String blogdetails;
  final dynamic audioplay;
  final dynamic blogid;
  final List<String>? images;
  final ScrollController controller;
  final AudioPlayer advancedPlayer;

  const LowerPlane(
      {required this.blogdetails,
      required this.controller,
      required this.advancedPlayer,
      this.audioplay,
      this.blogid,
      required this.images});

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
            images == null || images!.isEmpty
                ? Container()
                : ImageList(images: images!),
            audioplay == null
                ? Container()
                : AudioFile(
                    advancedPlayer: advancedPlayer,
                    url: audioplay,
                  ),
            blogid == 11
                ? GestureDetector(
                    onTap: () {
                      final url = 'https://amzn.eu/d/943eLvv';
                      openBrowserUrl(url: url, inApp: false);
                    },
                    child:
                        bulidMenuItem(text: 'Buy Book now', icon: Icons.book))
                : Container(),
            blogid == 10
                ? GestureDetector(
                    onTap: () {
                      final url =
                          'https://store.pothi.com/book/bindaz-boy-book-bindazboy/';
                      openBrowserUrl(url: url, inApp: false);
                    },
                    child:
                        bulidMenuItem(text: 'Buy Book now ', icon: Icons.book))
                : Container(),
            Padding(
              padding: EdgeInsets.only(top: 7, right: 9, left: 15, bottom: 15),
              child: Text(
                blogdetails,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: BConstantColors.descrptionColor,
                    fontSize: MediaQuery.of(context).size.width * 0.043,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );

  Future openBrowserUrl({required dynamic url, bool inApp = false}) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    }
  }

  Widget bulidMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Color.fromARGB(255, 252, 252, 47);
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 6),
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: onClicked,
      ),
    );
  }
}
