import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/notifiers/catergoryblogs.notifer.dart';
import 'package:bindazboy/meta/views/catergory/components/catergorys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatergoryList extends StatefulWidget {
  final Function callback;
  final int selected;

  const CatergoryList({
    super.key,
    required this.callback,
    required this.selected,
  });

  @override
  State<CatergoryList> createState() => _CatergoryListState();
}

class _CatergoryListState extends State<CatergoryList> {
  dynamic _futureCatergory;

  @override
  void initState() {
    final catergoryprovider = Provider.of<CatergoryBlogNotifer>(
      context,
      listen: false,
    );
    _futureCatergory = catergoryprovider.fetchBlogs(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<CatergoryBlogNotifer>(context, listen: false);
    return SizedBox(
      height: 60,
      child: FutureBuilder(
        future: _futureCatergory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center();
          }
          if (snapshot.data != null) {
            var snapshot1 = snapshot.data as List;
            if (snapshot1.isEmpty) {
              return Center(
                child: Text(
                  "Add category",
                  style: TextStyle(
                    fontSize: 17,
                    color: BConstantColors.fullblack,
                  ),
                ),
              );
            }
            return Catergorys(
              snapshot: snapshot1,
              callback: widget.callback,
              selected: widget.selected,
            );
          }
          return Center(child: Text("something went wrong try again"));
        },
      ),
    );
  }
}
