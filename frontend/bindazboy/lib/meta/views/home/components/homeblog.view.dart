import 'dart:async';
import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/notifiers/audiobook.notifer.dart';
import 'package:bindazboy/core/notifiers/blogs.notifier.dart';
import 'package:bindazboy/core/notifiers/cache.notifier.dart';
import 'package:bindazboy/meta/views/home/components/audio/audiobooklist.dart';
import 'package:bindazboy/meta/views/home/components/blogsList.dart';
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

  Future loadblog() async {
    final databg = Provider.of<BlogNotifer>(context, listen: false)
        .fetchBlogs(context: context);
    return databg;
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
    final provider = Provider.of<BlogNotifer>(context, listen: false);
    final audioprovider = Provider.of<AudioBookNotifer>(context, listen: true);
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
                    Provider.of<CacheNotifier>(context, listen: false)
                        .deleteCache(key: "jwtdata");
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.LoginRoute, (route) => false);
                  },
                  icon: Icon(
                    Icons.logout,
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
            Expanded(
              child: RefreshIndicator(
                onRefresh: loadblog,
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
