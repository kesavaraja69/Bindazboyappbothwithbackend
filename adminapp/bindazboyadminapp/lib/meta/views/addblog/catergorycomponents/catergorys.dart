import 'package:bindazboyadminapp/core/models/category.model.dart';
import 'package:flutter/material.dart';

class Catergorys extends StatelessWidget {
  final dynamic snapshot;
  final Function callback;
  final int selected;

  const Catergorys({
    required this.snapshot,
    required this.callback,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.length,
          itemBuilder: (context, index) {
            Data _blog = snapshot[index];

            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () =>
                        callback(_blog.catergoryId, _blog.catergoryTitle),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected == _blog.catergoryId
                            ? Colors.black
                            : Colors.yellow[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          _blog.catergoryTitle,
                          style: TextStyle(
                            fontSize: 17,
                            color: selected == _blog.catergoryId
                                ? Colors.yellow
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
