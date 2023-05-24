import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/models/zoomdetails.model.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ZoomMeetingDetails extends StatelessWidget {
  ZoomDetailsData data;
  ZoomMeetingDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final mheigth = MediaQuery.of(context).size.height;
    final mwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: BConstantColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Container(
          height: mheigth * 0.39,
          width: mwidth,
          decoration: BoxDecoration(
            color: BConstantColors.fullblack,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: BConstantColors.fullblack.withOpacity(0.6),
                  offset: Offset(0.0, 10.0),
                  blurRadius: 10.0,
                  spreadRadius: -6.0),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Text(
                    "Zoom Meeting Details",
                    style: TextStyle(
                        color: Color.fromARGB(221, 254, 222, 81),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                top: mheigth * 0.055,
                child: Row(
                  children: [
                    Text(
                      "Title : ${data.zoomMeetTopic}",
                      style: TextStyle(
                          color: Color.fromARGB(221, 254, 222, 81),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                top: mheigth * 0.095,
                child: Text(
                  "Date & Time : ${data.zoommeetdateandtime}",
                  style: TextStyle(
                      color: Color.fromARGB(221, 254, 222, 81),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                top: mheigth * 0.15,
                child: Row(
                  children: [
                    Text(
                      "Meeting ID : ${data.zoomMeetId}",
                      style: TextStyle(
                          color: Color.fromARGB(221, 254, 222, 81),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: data.zoomMeetId));
                        ShowsnackBarUtiltiy.showSnackbar(
                            message: "Copied to Clipboard", context: context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Icon(
                          Icons.copy,
                          size: 25,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                top: mheigth * 0.199,
                child: Row(
                  children: [
                    Text(
                      "Meeting Password : ${data.zoomMeetPassword}",
                      style: TextStyle(
                          color: Color.fromARGB(221, 254, 222, 81),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: data.zoomMeetPassword));
                        ShowsnackBarUtiltiy.showSnackbar(
                            message: "Copied to Clipboard", context: context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Icon(
                          Icons.copy,
                          size: 25,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                top: mheigth * 0.25,
                child: Text(
                  data.zoommeetupcomingdate != null
                      ? "UpComing Meeting : ${data.zoommeetupcomingdate}"
                      : "UpComing Meeting : None",
                  style: TextStyle(
                      color: Color.fromARGB(221, 254, 222, 81),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "( OR )",
                    style: TextStyle(
                        color: Color.fromARGB(221, 254, 222, 81),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    final url = '${data.zoommeetURL}';
                    openBrowserUrl(url: url, inApp: false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Text(
                      "Click Here",
                      style: TextStyle(
                          color: Color.fromARGB(221, 254, 222, 81),
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future openBrowserUrl({required dynamic url, bool inApp = false}) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
      );
    }
  }

  Widget bulidMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.brown[700];
    return Padding(
      padding: const EdgeInsets.only(left: 12),
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
