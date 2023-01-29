import 'package:bindazboy/core/notifiers/catergoryblogs.notifer.dart';
import 'package:bindazboy/meta/views/catergory/components/catergorybloglist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class CatergoryBloglistView extends StatelessWidget {
  final Function callback;
  final int selected;
  final dynamic catergorytitle;
  final PageController pageController;
  CatergoryBloglistView(
      {required this.callback,
      required this.selected,
      required this.pageController,
      required this.catergorytitle});
  @override
  Widget build(BuildContext context) {
    final _logger = Logger();
    final provider = Provider.of<CatergoryBlogNotifer>(context, listen: false);
    return Container(
        child: FutureBuilder(
      future: provider.fetchCatergoryBlogswithlimit(
          context: context, catergory_title: catergorytitle, pageno: 1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SpinKitFadingCircle(
            color: Colors.black,
            size: 50.0,
          ));
        }
        if (snapshot.data != null) {
          var _snaphot = snapshot.data as List;
          if (_snaphot.isEmpty) {
            return Center(
              child: Text(
                "No Blogs Post Yet",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            );
          }
          _logger.i(snapshot.data);
          return CatergoryblogList(
            snapshot: _snaphot,
            catergorytitle: catergorytitle,
          );
        }
        return Center(
          child: Text("something went wrong"),
        );
      },
    ));
  }
}
