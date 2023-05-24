import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/models/zoomdetails.model.dart';
import 'package:bindazboy/core/notifiers/zoom.notifier.dart';
import 'package:bindazboy/meta/views/home/components/meeting/meetingdetailview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../utils/showsnackbar.utils.dart';

class MeetingView extends StatefulWidget {
  const MeetingView({super.key});

  @override
  State<MeetingView> createState() => _MeetingViewState();
}

class _MeetingViewState extends State<MeetingView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool? isRegisted;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    fetchuserZoom();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
  }

  fetchuserZoom() async {
    final zoomprovider = Provider.of<ZoomNoitifer>(context, listen: false);
    final data = await zoomprovider.checkzoomUser(context: context);
    setState(() {
      isRegisted = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final zoomprovider = Provider.of<ZoomNoitifer>(context, listen: false);

    final mheigth = MediaQuery.of(context).size.height;
    final mwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: BConstantColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: isRegisted == false
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: mheigth * 0.1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            child: Container(
                              height: mheigth * 0.19,
                              width: mwidth,
                              decoration: BoxDecoration(
                                color: BConstantColors.fullblack,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: FutureBuilder(
                                  future: zoomprovider.fetchzoomDetail(
                                      context: context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: Text(
                                          "Loading....",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  221, 254, 222, 81),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }
                                    if (snapshot.data != null) {
                                      var data =
                                          snapshot.data as ZoomDetailsData;

                                      return Stack(children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 9),
                                            child: Text(
                                              "Zoom Meeting Details",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      221, 254, 222, 81),
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
                                                    color: Color.fromARGB(
                                                        221, 254, 222, 81),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: mwidth * 0.07,
                                          top: mheigth * 0.087,
                                          child: Text(
                                            "Date & Time : ${data.zoommeetdateandtime}",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    221, 254, 222, 81),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Positioned(
                                          left: mwidth * 0.07,
                                          top: mheigth * 0.12,
                                          child: Text(
                                            "UpComing Date : ${data.zoommeetupcomingdate}",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    221, 254, 222, 81),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ]);
                                    }
                                    return Center(
                                      child: Text(
                                        "No Zoom Meeting Available",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                221, 254, 222, 81),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Register Here for Zoom Meeting",
                            style: TextStyle(
                                color: BConstantColors.appbartitleColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          labeltext("Name"),
                          const SizedBox(
                            height: 2,
                          ),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: BConstantColors.authenticationIconColor,
                              ),
                              hintText: "Enter Name",
                              labelStyle:
                                  TextStyle(color: BConstantColors.black),
                              //fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: BorderSide(
                                      color: BConstantColors.lightgrey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: BorderSide(
                                      color: BConstantColors.fullblack)),
                            ),
                            style: TextStyle(
                                color: BConstantColors.appbartitleColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          labeltext("Email"),
                          const SizedBox(
                            height: 2,
                          ),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: BConstantColors.authenticationIconColor,
                              ),
                              hintText: "Enter Email",
                              labelStyle:
                                  TextStyle(color: BConstantColors.black),
                              //fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: BorderSide(
                                      color: BConstantColors.lightgrey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: BorderSide(
                                      color: BConstantColors.fullblack)),
                            ),
                            style: TextStyle(
                                color: BConstantColors.appbartitleColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              var useremail = emailController.text;
                              var username = nameController.text;

                              if (useremail.isNotEmpty && username.isNotEmpty) {
                                await zoomprovider.registerZoom(
                                    context: context,
                                    username: username,
                                    useremail: useremail,
                                    zoomid: 1);

                                setState(() {
                                  fetchuserZoom();
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Fill the values")));
                              }
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: BConstantColors.authenticationTxtColor,
                                  fontSize: 21),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  BConstantColors.authenticationBtnColor,
                              minimumSize: Size(100, 45),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Container(
                    height: mheigth * 0.39,
                    width: mwidth,
                    decoration: BoxDecoration(
                      color: BConstantColors.fullblack,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FutureBuilder(
                        future: zoomprovider.fetchzoomDetail(context: context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text(
                                "Loading....",
                                style: TextStyle(
                                    color: Color.fromARGB(221, 254, 222, 81),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }
                          if (snapshot.data != null) {
                            var data = snapshot.data as ZoomDetailsData;

                            return ZoomMeetingDetails(data: data);
                          }
                          return Center(
                            child: Text(
                              "No Zoom Meeting Available",
                              style: TextStyle(
                                  color: Color.fromARGB(221, 254, 222, 81),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }),
                  ),
                ),
          // Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 25),
          //     child: Container(
          //       height: mheigth * 0.37,
          //       width: mwidth,
          //       decoration: BoxDecoration(
          //         color: BConstantColors.fullblack,
          //         borderRadius: BorderRadius.circular(15),
          //         boxShadow: [
          //           BoxShadow(
          //               color: BConstantColors.fullblack.withOpacity(0.6),
          //               offset: Offset(0.0, 10.0),
          //               blurRadius: 10.0,
          //               spreadRadius: -6.0),
          //         ],
          //       ),
          //       child: Stack(
          //         children: [
          //           Align(
          //             alignment: Alignment.topCenter,
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 9),
          //               child: Text(
          //                 "Zoom Meeting Details",
          //                 style: TextStyle(
          //                     color: Color.fromARGB(221, 254, 222, 81),
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ),
          //           Positioned(
          //             left: mwidth * 0.07,
          //             top: mheigth * 0.055,
          //             child: Row(
          //               children: [
          //                 Text(
          //                   "Title : Meditation",
          //                   style: TextStyle(
          //                       color: Color.fromARGB(221, 254, 222, 81),
          //                       fontSize: 20,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Positioned(
          //             left: mwidth * 0.07,
          //             top: mheigth * 0.095,
          //             child: Text(
          //               "Date & Time : 16 Apr 23 at 6.00 pm",
          //               style: TextStyle(
          //                   color: Color.fromARGB(221, 254, 222, 81),
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //           Positioned(
          //             left: mwidth * 0.07,
          //             top: mheigth * 0.135,
          //             child: Row(
          //               children: [
          //                 Text(
          //                   "Meeting ID : 76876785646",
          //                   style: TextStyle(
          //                       color: Color.fromARGB(221, 254, 222, 81),
          //                       fontSize: 20,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //                 GestureDetector(
          //                   onTap: () {
          //                     Clipboard.setData(
          //                         ClipboardData(text: "raja"));
          //                     ShowsnackBarUtiltiy.showSnackbar(
          //                         message: "Copied to Clipboard",
          //                         context: context);
          //                   },
          //                   child: Padding(
          //                     padding: const EdgeInsets.only(left: 65),
          //                     child: Icon(
          //                       Icons.copy,
          //                       size: 25,
          //                       color: Colors.amber,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Positioned(
          //             left: mwidth * 0.07,
          //             top: mheigth * 0.185,
          //             child: Row(
          //               children: [
          //                 Text(
          //                   "Meeting Password : yrjjyf7587",
          //                   style: TextStyle(
          //                       color: Color.fromARGB(221, 254, 222, 81),
          //                       fontSize: 20,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //                 GestureDetector(
          //                   onTap: () {
          //                     Clipboard.setData(
          //                         ClipboardData(text: "raja"));
          //                     ShowsnackBarUtiltiy.showSnackbar(
          //                         message: "Copied to Clipboard",
          //                         context: context);
          //                   },
          //                   child: Padding(
          //                     padding: const EdgeInsets.only(left: 65),
          //                     child: Icon(
          //                       Icons.copy,
          //                       size: 25,
          //                       color: Colors.amber,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Positioned(
          //             left: mwidth * 0.07,
          //             top: mheigth * 0.227,
          //             child: Text(
          //               "UpComing Meeting : None",
          //               style: TextStyle(
          //                   color: Color.fromARGB(221, 254, 222, 81),
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(vertical: 50),
          //             child: Align(
          //               alignment: Alignment.bottomCenter,
          //               child: Text(
          //                 "( OR )",
          //                 style: TextStyle(
          //                     color: Color.fromARGB(221, 254, 222, 81),
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //           ),
          //           Align(
          //             alignment: Alignment.bottomCenter,
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 9),
          //               child: Text(
          //                 "Click Here",
          //                 style: TextStyle(
          //                     color: Color.fromARGB(221, 254, 222, 81),
          //                     fontSize: 25,
          //                     fontWeight: FontWeight.w600),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
        ),
      ),
    );
  }
}
