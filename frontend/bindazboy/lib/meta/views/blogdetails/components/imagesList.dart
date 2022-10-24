import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  final List<String> images;
  const ImageList({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: Color.fromARGB(255, 230, 230, 230),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(images[index]), fit: BoxFit.cover),
                )),
          );
        },
      ),
    );
  }
}
