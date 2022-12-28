import 'package:bindazboyadminapp/core/notifiers/category.notifier.dart';
import 'package:bindazboyadminapp/meta/views/addblog/catergorycomponents/catergorys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatergoryList extends StatefulWidget {
  final Function callback;
  final int selected;

  const CatergoryList({required this.callback, required this.selected});

  @override
  State<CatergoryList> createState() => _CatergoryListState();
}

class _CatergoryListState extends State<CatergoryList> {
  dynamic _futureCatergory;

  @override
  void initState() {
    final catergoryprovider =
        Provider.of<CategoryNotifer>(context, listen: false);
    _futureCatergory = catergoryprovider.fetchCategorys(context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: FutureBuilder(
          future: _futureCatergory,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center();
            }
            if (snapshot.data != null) {
              var _snapshot = snapshot.data as List;
              if (_snapshot.isEmpty) {
                return Center(
                  child: Text("Add Category"),
                );
              }
              return Catergorys(
                snapshot: _snapshot,
                callback: widget.callback,
                selected: widget.selected,
              );
            }
            return Center(
              child: Text("something went wrong try again"),
            );
          }),
    );
  }
}
