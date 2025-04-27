import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/models/catergorys.model.dart';
import 'package:flutter/material.dart';

class Catergorys extends StatelessWidget {
  final dynamic snapshot;
  final Function callback;
  final int selected;

  const Catergorys({
    super.key,
    required this.snapshot,
    required this.callback,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Data blog = snapshot[index];

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => callback(blog.catergoryId, blog.catergoryTitle),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          selected == blog.catergoryId
                              ? BConstantColors.fullblack
                              : BConstantColors.yellow,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        blog.catergoryTitle,
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              selected == blog.catergoryId
                                  ? BConstantColors.yellow
                                  : BConstantColors.fullblack,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
