import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/models/blogcatergory.model.dart';

import 'package:bindazboy/meta/utils/blogdetail_arguments.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';

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
          child: CachedNetworkImage(
            imageUrl: "${_blog.blogImage}",
            width: MediaQuery.of(context).size.width,
            height: 135,
            imageBuilder: (context, imageProvider) => Container(
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
                        BConstantColors.fullblack.withOpacity(0.55),
                        BlendMode.darken),
                    image: imageProvider,
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 19,
                    right: 6,
                    left: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            _blog.blogTitle,
                            overflow: TextOverflow.clip,
                            maxLines: null,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
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
                          horizontal: 13, vertical: 9.0),
                      child: Text(
                        "Posted On ${_blog.blogDate.split('-').reversed.join('-')}",
                        style: TextStyle(
                            color: BConstantColors.titleColor.withOpacity(0.75),
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                      ),
                    ),
                    alignment: Alignment.bottomLeft,
                  ),
                  Positioned(
                    bottom: 1,
                    left: MediaQuery.of(context).size.width * 0.42,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            size: 13,
                            color: BConstantColors.titleColor.withOpacity(0.75),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${Numeral(int.parse(_blog.blogView)).format()}",
                            style: TextStyle(
                                color: BConstantColors.titleColor
                                    .withOpacity(0.75),
                                fontWeight: FontWeight.w400,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 9.0),
                      child: Text(
                        "Posted By BindazBoy",
                        style: TextStyle(
                            color: BConstantColors.titleColor.withOpacity(0.75),
                            fontWeight: FontWeight.w400,
                            fontSize: 9),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // placeholder: (context, url) => const SizedBox(
            //   height: 15,
            //   width: 15,
            //   child: CircularProgressIndicator(
            //     color: Colors.deepPurpleAccent,
            //   ),
            // ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.image_search_rounded),
          ),
        );
      },
    );
  }
}
