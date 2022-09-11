import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/models/blogcatergory.model.dart';

import 'package:bindazboy/meta/utils/blogdetail_arguments.dart';
import 'package:flutter/material.dart';

class CatergoryblogList extends StatelessWidget {
  final dynamic snapshot;

  const CatergoryblogList({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        Data _blog = snapshot[index];
        int detailid = _blog.blogId;
        return GestureDetector(
          onTap: () async {
            Navigator.of(context).pushNamed(AppRoutes.BlogDetailRoute,
                arguments: BlogDetailArguments(id: detailid));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
            width: MediaQuery.of(context).size.width,
            height: 135,
            decoration: BoxDecoration(
              color: BConstantColors.fullblack,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: BConstantColors.fullblack.withOpacity(0.6),
                    offset: Offset(0.0, 10.0),
                    blurRadius: 10.0,
                    spreadRadius: -6.0),
              ],
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      BConstantColors.fullblack.withOpacity(0.40),
                      BlendMode.darken),
                  image: NetworkImage(_blog.blogImage),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 17,
                  right: 6,
                  left: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9.0, vertical: 4.0),
                        child: Text(
                          _blog.blogTitle,
                          overflow: TextOverflow.clip,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: BConstantColors.titleColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9.0, vertical: 8.0),
                    child: Text(
                      "Posted On ${_blog.blogDate.split('-').reversed.join('-')}",
                      style: TextStyle(
                          color: BConstantColors.titleColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 10),
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9.0, vertical: 8.0),
                    child: Text(
                      "Posted By BindazBoy",
                      style: TextStyle(
                          color: BConstantColors.titleColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
