import 'dart:async';
import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/notifiers/audiobook.notifer.dart';
import 'package:bindazboy/core/notifiers/blogs.notifier.dart';
import 'package:bindazboy/core/notifiers/cache.notifier.dart';
import 'package:bindazboy/meta/utils/alertbox.utils.dart';
import 'package:bindazboy/meta/views/home/components/parallxBlogList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
            ))

        // (await showDialog(
        //   context: context,
        //   builder: (context) => new AlertDialog(
        //     title: new Text('Are you sure?'),
        //     content: new Text('Do you want to exit an App'),
        //     actions: <Widget>[
        //       TextButton(
        //         onPressed: () => Navigator.of(context).pop(false),
        //         child: new Text('No'),
        //       ),
        //       TextButton(
        //         onPressed: () => Navigator.of(context).pop(true),
        //         child: new Text('Yes'),
        //       ),
        //     ],
        //   ),
        // ))

        ??
        false;
  }

  Future loadblog() async {
    final databg = Provider.of<BlogNotifer>(context, listen: false)
        .fetchBlogs(context: context);
    return databg;
  }

  Future loadblogs() async {
    setState(() {
      data1 = Provider.of<BlogNotifer>(context, listen: false)
          .fetchBlogs(context: context);
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
                      fontSize: 23,
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
            //     : SizedBox(),
            SizedBox(
              height: 9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Text(
                "All Posts",
                style: TextStyle(
                    color: BConstantColors.appbartitleColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: RefreshIndicator(
                onRefresh: loadblogs,
                backgroundColor: BConstantColors.black,
                color: BConstantColors.yellow,
                child: FutureBuilder(
                    future: data1,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: SpinKitFadingCircle(
                          color: BConstantColors.black,
                          size: 50.0,
                        ));
                      }
                      if (snapshot.data == null) {
                        return Center(
                          child: Container(),
                        );
                      }
                      if (snapshot.data != null) {
                        var _snapshot = snapshot.data as List;

                        if (_snapshot.isEmpty) {
                          return Center(
                            child: Text(
                              "No Blogs Post Yet",
                              style: TextStyle(
                                  fontSize: 17, color: BConstantColors.black),
                            ),
                          );
                        }
                        return Bloglist(
                          snapshot: _snapshot,
                        );
                      }
                      return Center(
                        child: Text("something went wrong try again"),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
