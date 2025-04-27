import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/notifiers/bookmark.notifer.dart';
import 'package:bindazboy/meta/views/bookmark/components/bookmarkList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  late Future<dynamic> data;
  Future loadblog() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      data = Provider.of<BookmarkNotifier>(
        context,
        listen: false,
      ).fetchBookmarksByUser(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final BookmarkNotifier bookmarkNotifier = Provider.of<BookmarkNotifier>(
      context,
      listen: false,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: BConstantColors.backgroundColor,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Bookmark",
                    style: TextStyle(
                      color: BConstantColors.appbartitleColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: bookmarkNotifier.fetchBookmarksByUser(context: context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitFadingCircle(
                        color: BConstantColors.black,
                        size: 50.0,
                      ),
                    );
                  }
                  if (snapshot.data != null) {
                    var snapshotdata = snapshot.data as List;
                    if (snapshotdata.isEmpty) {
                      return Center(
                        child: Text(
                          "Add Bookmarks",
                          style: TextStyle(
                            fontSize: 17,
                            color: BConstantColors.fullblack,
                          ),
                        ),
                      );
                    }
                    return Bookmarklist(
                      snapshot: snapshotdata,
                      onclik: () => loadblog(),
                    );
                  }
                  if (snapshot.data == null) {
                    return Center(
                      child: Text(
                        "Something Went Wrong",
                        style: TextStyle(
                          fontSize: 20,
                          color: BConstantColors.fullblack,
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      "Add BookMarks",
                      style: TextStyle(
                        fontSize: 20,
                        color: BConstantColors.fullblack,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
