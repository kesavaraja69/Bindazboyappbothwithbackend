import 'package:bindazboyadminapp/core/notifiers/category.notifier.dart';
import 'package:bindazboyadminapp/meta/views/addblog/catergorycomponents/catergorys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatergoryList extends StatelessWidget {
  final Function callback;
  final int selected;

  const CatergoryList({required this.callback, required this.selected});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryNotifer>(context, listen: false);
    return Container(
      height: 80,
      child: FutureBuilder(
          future: provider.fetchCategorys(
            context: context,
          ),
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
                callback: callback,
                selected: selected,
              );
            }
            return Center(
              child: Text("something went wrong try again"),
            );
          }),
    );
  }
}
