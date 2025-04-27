import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  final List<String> images;
  const ImageList({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 260,
      child: ListView.builder(
        itemCount: images.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 9, right: 9, left: 9, bottom: 7),
            child: Container(
              width: 360,
              height: 270,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(images[index]),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
