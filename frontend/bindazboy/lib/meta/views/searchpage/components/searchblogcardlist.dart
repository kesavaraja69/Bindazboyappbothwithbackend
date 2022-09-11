import 'package:bindazboy/core/notifiers/blogs.notifier.dart';
import 'package:bindazboy/meta/views/searchpage/components/searchblogcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class SearchBlogcardlist extends StatelessWidget {
  final dynamic query;
  const SearchBlogcardlist({required this.query});

  @override
  Widget build(BuildContext context) {
    final _logger = Logger();
    final provider = Provider.of<BlogNotifer>(context, listen: false);
    return Container(
        child: FutureBuilder(
      future: provider.searchBlog(context: context, query: query),
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
                "Post Not Found",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            );
          }
          _logger.i(snapshot.data);
          return Searchblogcard(snapshot: _snaphot);
        }
        return Center(
          child: Text("Search Post"),
        );
      },
    ));
  }
}
