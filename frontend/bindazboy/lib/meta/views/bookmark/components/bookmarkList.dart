import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/models/bookmark.model.dart';
import 'package:bindazboy/core/notifiers/bookmark.notifer.dart';
import 'package:bindazboy/meta/utils/blogdetail_arguments.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';
import 'package:provider/provider.dart';

class Bookmarklist extends StatelessWidget {
  final dynamic snapshot;
  final VoidCallback onclik;

  Bookmarklist({
    required this.snapshot,
    required this.onclik,
  });

  @override
  Widget build(BuildContext context) {
    final BookmarkNotifier bookmarkNotifier =
        Provider.of<BookmarkNotifier>(context, listen: false);
    return ListView.builder(
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        BookmarkData _blog = snapshot[index];
        int detailid = _blog.bookmarkBlogdata.blogId;
        if (snapshot[index] == null) {
          return Center(
              child: Text(
            "Add BookMarks",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ));
        }
        return GestureDetector(
          onTap: () async {
            Navigator.of(context).pushNamed(AppRoutes.BlogDetailRoute,
                arguments: BlogDetailArguments(id: detailid));
          },
          child: CachedNetworkImage(
            imageUrl: "${_blog.bookmarkBlogdata.blogImage}",
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
                            _blog.bookmarkBlogdata.blogTitle,
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
                        "Posted On ${_blog.bookmarkBlogdata.blogDate.split('-').reversed.join('-')}",
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
                            "${Numeral(int.parse(_blog.bookmarkBlogdata.blogView)).format()}",
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
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
          //   width: MediaQuery.of(context).size.width,
          //   height: 135,
          //   decoration: BoxDecoration(
          //     color: BConstantColors.fullblack,
          //     borderRadius: BorderRadius.circular(15),
          //     boxShadow: [
          //       BoxShadow(
          //           color: BConstantColors.fullblack.withOpacity(0.6),
          //           offset: Offset(0.0, 10.0),
          //           blurRadius: 10.0,
          //           spreadRadius: -6.0),
          //     ],
          //     image: DecorationImage(
          //         colorFilter: ColorFilter.mode(
          //             BConstantColors.fullblack.withOpacity(0.40),
          //             BlendMode.darken),
          //         image: NetworkImage(_blog.bookmarkBlogdata.blogImage),
          //         fit: BoxFit.cover),
          //   ),
          //   child: Stack(
          //     children: [
          //       Positioned(
          //         top: 17,
          //         right: 24,
          //         left: 7,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.symmetric(
          //                   horizontal: 10.0, vertical: 4.0),
          //               child: Text(
          //                 _blog.bookmarkBlogdata.blogTitle,
          //                 overflow: TextOverflow.clip,
          //                 maxLines: null,
          //                 textAlign: TextAlign.left,
          //                 style: TextStyle(
          //                     fontSize: 13,
          //                     color: BConstantColors.titleColor,
          //                     fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Positioned(
          //         bottom: 1,
          //         left: MediaQuery.of(context).size.width * 0.42,
          //         child: Padding(
          //           padding:
          //               const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          //           child: Row(
          //             children: [
          //               Icon(
          //                 Icons.visibility,
          //                 size: 13,
          //                 color: BConstantColors.titleColor.withOpacity(0.75),
          //               ),
          //               SizedBox(
          //                 width: 7,
          //               ),
          //               Text(
          //                 "${Numeral(int.parse(_blog.bookmarkBlogdata.blogView)).format()}",
          //                 style: TextStyle(
          //                     color:
          //                         BConstantColors.titleColor.withOpacity(0.75),
          //                     fontWeight: FontWeight.w400,
          //                     fontSize: 13),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Align(
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 9.0, vertical: 8.0),
          //           child: Text(
          //             "Posted On ${_blog.bookmarkBlogdata.blogDate.split('-').reversed.join('-')}",
          //             style: TextStyle(
          //                 color: BConstantColors.titleColor,
          //                 fontWeight: FontWeight.w400,
          //                 fontSize: 10),
          //           ),
          //         ),
          //         alignment: Alignment.bottomLeft,
          //       ),
          //       Positioned(
          //         top: 7,
          //         right: 9,
          //         child: InkWell(
          //           onTap: () async {
          //             await bookmarkNotifier.deleteBookmark(
          //                 context: context, bookmark_id: _blog.bookmarkId);
          //             onclik();
          //           },
          //           child: Container(
          //             width: 35,
          //             height: 35,
          //             decoration: BoxDecoration(
          //                 color: BConstantColors.fullblack.withOpacity(0.70),
          //                 borderRadius: BorderRadius.circular(12.0)),
          //             child: Center(
          //               child: Icon(
          //                 Icons.delete,
          //                 size: 20,
          //                 color: BConstantColors.yellow,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Align(
          //         alignment: Alignment.bottomRight,
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 9.0, vertical: 8.0),
          //           child: Text(
          //             "Posted By BindazBoy",
          //             style: TextStyle(
          //                 color: BConstantColors.titleColor,
          //                 fontWeight: FontWeight.w400,
          //                 fontSize: 10),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}
