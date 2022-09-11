import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  final List<String>? images;
  const ImageList({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 130,
      child: ListView.builder(
        itemCount: images?.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 9, right: 4, left: 9, bottom: 7),
            child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 230, 230, 230),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(images![index]), fit: BoxFit.cover),
                )),
          );
        },
      ),
    );
  }
}
