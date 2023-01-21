import 'package:bindazboyadminapp/app/routes/app.routes.dart';
import 'package:bindazboyadminapp/core/models/blogs.model.dart';
import 'package:bindazboyadminapp/core/notifiers/blog.notifier.dart';
import 'package:bindazboyadminapp/core/notifiers/notification.notifier.dart';
import 'package:bindazboyadminapp/core/notifiers/utility.notifer.dart';
import 'package:bindazboyadminapp/meta/utils/blogdetail.arguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bloglist extends StatelessWidget {
  final dynamic snapshot;

  Bloglist({
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    final utilityNotifer = Provider.of<UtilityNotifer>(context, listen: true);
    final blogNotifer = Provider.of<BlogNotifer>(context, listen: false);
    final notifiNotifer =
        Provider.of<NotificationNotifiter>(context, listen: false);
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              Data _blog = snapshot[index];
              int detailid = _blog.blogId;
              return InkWell(
                onTap: () async {
                  Navigator.of(context).pushNamed(AppRoutes.BlogDetailRoute,
                      arguments: BlogDetailArguments(
                          blog_audio: _blog.blogAudio,
                          id: detailid,
                          blogTitle: _blog.blogTitle,
                          blogDescription: _blog.blogDescription,
                          blogCategroy: _blog.blogCategory,
                          blogDate: _blog.blogDate,
                          blogImage: _blog.blogImage,
                          blogImages: _blog.blogImages));
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 12, right: 12, top: 0.0, bottom: 15.0),
                  width: MediaQuery.of(context).size.width,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          offset: Offset(0.0, 10.0),
                          blurRadius: 10.0,
                          spreadRadius: -6.0),
                    ],
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.50), BlendMode.multiply),
                        image: NetworkImage(_blog.blogImage),
                        fit: BoxFit.cover),
                  ),
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Positioned(
                          top: 11,
                          left: 13,
                          child: InkWell(
                            onDoubleTap: () {
                              notifiNotifer.sendnotification(
                                  title: "New Blog Added",
                                  body: _blog.blogTitle,
                                  context: context);
                            },
                            child: iconcontainr(
                              icon: CupertinoIcons.bell_fill,
                              iccolor: Colors.yellow,
                              bgcolor: Colors.black.withOpacity(0.65),
                            ),
                          )),
                      Positioned(
                        top: 11,
                        right: 13,
                        child: InkWell(
                          onDoubleTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.UpdateblogRoute,
                                    arguments: BlogDetailArguments(
                                      blog_audio: _blog.blogAudio,
                                      id: detailid,
                                      blogTitle: _blog.blogTitle,
                                      blogDescription: _blog.blogDescription,
                                      blogCategroy: _blog.blogCategory,
                                      blogDate: _blog.blogDate,
                                      blogImages: _blog.blogImages == null
                                          ? null
                                          : _blog.blogImages,
                                      blogImage: _blog.blogImage,
                                    ));
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            child: Icon(
                              Icons.edit,
                              color: Colors.yellow,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.65),
                                borderRadius: BorderRadius.circular(12.0)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 11,
                        right: 13,
                        child: InkWell(
                          onDoubleTap: () async {
                            await blogNotifer
                                .deleteBlogs(
                                    context: context, blogid: _blog.blogId)
                                .whenComplete(() {
                              utilityNotifer.deleteblogImage(
                                  context: context, url: _blog.blogImage);
                            });
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            child: Icon(
                              Icons.delete,
                              color: Colors.yellow,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.65),
                                borderRadius: BorderRadius.circular(12.0)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 35,
                        right: 5,
                        left: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.all(5),
                              child: Text(
                                _blog.blogTitle,
                                overflow: TextOverflow.clip,
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Posted On ${_blog.blogDate.split('-').reversed.join('-')}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: snapshot.length,
          ),
        ),
      ],
    );
  }

  Widget iconcontainr(
      {required IconData icon, required iccolor, required bgcolor}) {
    return Container(
      height: 35,
      width: 35,
      child: Icon(
        icon,
        color: iccolor,
      ),
      decoration: BoxDecoration(
          color: bgcolor, borderRadius: BorderRadius.circular(12.0)),
    );
  }
}
