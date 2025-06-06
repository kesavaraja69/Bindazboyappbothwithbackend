import 'dart:async';
import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/notifiers/audiobook.notifer.dart';
import 'package:bindazboy/core/notifiers/blogs.notifier.dart';
import 'package:bindazboy/core/notifiers/cache.notifier.dart';
import 'package:bindazboy/meta/utils/alertbox.utils.dart';
import 'package:bindazboy/meta/views/home/components/parallxblogList.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBlogs extends StatefulWidget {
  final VoidCallback keys;
  const HomeBlogs({required this.keys});

  @override
  State<HomeBlogs> createState() => _HomeBlogsState();
}

class _HomeBlogsState extends State<HomeBlogs> {
  late Future<dynamic> data;
  late Future<dynamic> data1;

  Future<bool> _logoutdailog() async {
    return await AlertdailogBoxgm.showAlertbox(
            context: context,
            onclick1: () async {
              await Provider.of<CacheNotifier>(context, listen: false)
                  .deleteCache(key: "jwtdata");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.LoginRoute, (route) => false);
            },
            onclick2: () => Navigator.of(context).pop(false),
            title: "Are you sure?",
            content: Text(
              "Do you want to Logout",
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 24),
            )) ??
        false;
  }

  Future loadblog() async {
    final databg = Provider.of<BlogNotifer>(context, listen: false)
        .fetchBlogswithlimit(context: context, pageno: 1);
    return databg;
  }

  Future loadblogs() async {
    setState(() {
      data1 = Provider.of<BlogNotifer>(context, listen: false)
          .fetchBlogswithlimit(context: context, pageno: 1);
    });
  }

  Future loadblogaudio() async {
    setState(() {
      this.data = Provider.of<AudioBookNotifer>(context, listen: false)
          .fetchAudioBooksall(context: context);
    });
  }

  @override
  void initState() {
    //  loadblogaudio();
    // data = loadblog();
    data1 = loadblog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<BlogNotifer>(context, listen: false);
    // final audioprovider = Provider.of<AudioBookNotifer>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: BConstantColors.backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: widget.keys,
                  icon: Icon(
                    Icons.menu,
                    size: 29,
                    color: BConstantColors.appbartitleColor,
                  ),
                ),
                Text(
                  "Bindaz Boy App",
                  style: TextStyle(
                      color: BConstantColors.appbartitleColor,
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    // Provider.of<CacheNotifier>(context, listen: false)
                    //     .deleteCache(key: "jwtdata");
                    // Navigator.of(context).pushNamedAndRemoveUntil(
                    //     AppRoutes.LoginRoute, (route) => false);
                    _logoutdailog();
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 29,
                    color: BConstantColors.appbartitleColor,
                  ),
                ),
              ],
            ),
            // audioprovider.isAudiobookln != 0
            //     ? Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 9),
            //         child: Text(
            //           "Audio Books",
            //           style: TextStyle(
            //               color: BConstantColors.appbartitleColor,
            //               fontSize: 17,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       )
            //     : Container(),
            // audioprovider.isAudiobookln != 0
            //     ? SizedBox(
            //         height: 4,
            //       )
            //     : Container(),
            // audioprovider.isAudiobookln != 0
            //     ? Padding(
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 9, vertical: 1),
            //         child: Container(
            //           height: 170,
            //           width: MediaQuery.of(context).size.width,
            //           decoration: BoxDecoration(
            //             // color: Color.fromARGB(255, 0, 0, 0),
            //             borderRadius: BorderRadius.circular(9),
            //           ),
            //           child: FutureBuilder(
            //               future: audioprovider.fetchAudioBooksall(
            //                   context: context),
            //               builder: (context, snapshot) {
            //                 if (snapshot.connectionState ==
            //                     ConnectionState.waiting) {
            //                   return Center(
            //                       child: SpinKitFadingCircle(
            //                     color: BConstantColors.black,
            //                     size: 50.0,
            //                   ));
            //                 }
            //                 if (snapshot.data != null) {
            //                   var _snapshot = snapshot.data as List;

            //                   if (_snapshot.isEmpty) {
            //                     return Center(
            //                       child: Text(
            //                         "No Audiobook",
            //                         style: TextStyle(
            //                             fontSize: 15,
            //                             color: Color.fromARGB(243, 8, 7, 7)),
            //                       ),
            //                     );
            //                   }
            //                   return AudiobookList(
            //                     snapshot: _snapshot,
            //                   );
            //                 }
            //                 return Center(
            //                   child: Text("something went wrong try again"),
            //                 );
            //               }),
            //         ),
            //       )
            //
            //    : SizedBox(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Posts",
                    style: TextStyle(
                        color: BConstantColors.appbartitleColor,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).pushNamed(AppRoutes.ZoomMeetRoute);
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(bottom: 4),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width * 0.45,
                  //       height: 34,
                  //       decoration: BoxDecoration(
                  //         color: BConstantColors.fullblack,
                  //         borderRadius: BorderRadius.circular(14),
                  //       ),
                  //       child: Center(
                  //         child: Padding(
                  //           padding: EdgeInsets.all(4.0),
                  //           child: Text(
                  //             "Register here for Meeting",
                  //             style: TextStyle(
                  //               fontSize:
                  //                   MediaQuery.of(context).size.width * 0.035,
                  //               color: BConstantColors.yellow,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.847,
              child: RefreshIndicator(
                onRefresh: loadblogs,
                backgroundColor: BConstantColors.black,
                color: BConstantColors.yellow,
                child: Bloglist(),
                // FutureBuilder(
                //     future: data1,
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Center(
                //             child: SpinKitFadingCircle(
                //           color: BConstantColors.black,
                //           size: 50.0,
                //         ));
                //       }
                //       if (snapshot.data == null) {
                //         return Center(
                //           child: Container(),
                //         );
                //       }
                //       if (snapshot.data != null) {
                //         var _snapshot = snapshot.data as List;

                //         if (_snapshot.isEmpty) {
                //           return Center(
                //             child: Text(
                //               "No Blogs Post Yet",
                //               style: TextStyle(
                //                   fontSize: 17, color: BConstantColors.black),
                //             ),
                //           );
                //         }
                //         return Bloglist(
                //           snapshot: _snapshot,
                //         );
                //       }
                //       return Center(
                //         child: Text("something went wrong try again"),
                //       );
                //     }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
