import 'package:adminbindazboyapp/app/routes/app.routes.dart';
import 'package:adminbindazboyapp/core/models/blogs.model.dart';
import 'package:adminbindazboyapp/core/notifiers/blog.notifier.dart';
import 'package:adminbindazboyapp/core/notifiers/notification.notifier.dart';
import 'package:adminbindazboyapp/meta/utils/blogdetail.arguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Bloglist extends StatefulWidget {
  final dynamic snapshot;

  const Bloglist({super.key, this.snapshot});

  @override
  State<Bloglist> createState() => _BloglistState();
}

class _BloglistState extends State<Bloglist> {
  final ScrollController _controller = ScrollController();
  List<dynamic> items = [];
  int _pageno = 1;
  int _totalpage = 1;
  List<dynamic>? blogdata = [];
  bool loading = false, allloaded = false;

  mockfetch() async {
    if (allloaded) {
      return;
    } else {
      // await Future.delayed(const Duration(milliseconds: 50))
      //     .whenComplete(() async {
      final blogprovider = Provider.of<BlogNotifer>(context, listen: false);
      blogdata = await blogprovider.fetchBlogswithlimit(
        context: context,
        pageno: _pageno,
      );

      _totalpage = blogprovider.numberofblog!;

      if (mounted) {
        setState(() {
          loading = true;
        });
      }
      List<String> newData =
          items.length >= _totalpage
              ? []
              : List.generate(9, (index) => "${index + items.length}");
      if (newData.isNotEmpty) {
        items = blogdata!;
        // items.addAll(data1);
      }
      if (mounted) {
        setState(() {
          loading = false;
          allloaded = newData.isEmpty;
        });
      }
      // });
    }
  }

  mockfetch2() async {
    if (allloaded) {
      return;
    } else {
      setState(() {
        _pageno += 1;
      });
      if (mounted) {
        setState(() {
          loading = true;
        });
      }
      final blogprovider = Provider.of<BlogNotifer>(context, listen: false);
      blogdata = await blogprovider.fetchBlogswithlimit(
        context: context,
        pageno: _pageno,
      );
      // await Future.delayed(const Duration(milliseconds: 10))
      //     .whenComplete(() async {
      _totalpage = blogprovider.numberofblog!;

      List<String> newData =
          items.length >= _totalpage
              ? []
              : List.generate(9, (index) => "${index + items.length}");
      if (newData.isNotEmpty) {
        items.addAll(blogdata!);
      }
      if (mounted) {
        setState(() {
          loading = false;
          allloaded = newData.isEmpty;
        });
      }
      //  });
    }
  }

  // void _createInterstitialAd() {
  //   InterstitialAd.load(
  //     adUnitId: "ca-app-pub-3940256099942544/1033173712",
  //     request: AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (InterstitialAd ad) {
  //         _interstitialAd = ad;
  //       },
  //       onAdFailedToLoad: (LoadAdError error) {
  //         _interstitialLoadAttempts += 1;
  //         _interstitialAd = null;
  //         if (_interstitialLoadAttempts >= maxFailedLoadAttempts) {
  //           _createInterstitialAd();
  //         }
  //       },
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    mockfetch();
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent &&
          !loading) {
        mockfetch2();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final blogNotifer = Provider.of<BlogNotifer>(context, listen: false);
    final notifiNotifer = Provider.of<NotificationNotifiter>(
      context,
      listen: false,
    );
    return items.isNotEmpty
        ? Stack(
          children: [
            CustomScrollView(
              controller: _controller,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Data blog = items[index];
                      int detailid = blog.blogId;
                      return InkWell(
                        onTap: () async {
                          Navigator.of(context).pushNamed(
                            AppRoutes.BlogDetailRoute,
                            arguments: BlogDetailArguments(
                              blog_audio: blog.blogAudio,
                              id: detailid,
                              blogTitle: blog.blogTitle,
                              blogDescription: blog.blogDescription,
                              blogCategroy: blog.blogCategory,
                              blogDate: blog.blogDate,
                              blogImage: blog.blogImage,
                              blogImages: blog.blogImages,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            top: 0.0,
                            bottom: 15.0,
                          ),
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
                                spreadRadius: -6.0,
                              ),
                            ],
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.50),
                                BlendMode.multiply,
                              ),
                              image: NetworkImage(blog.blogImage),
                              fit: BoxFit.cover,
                            ),
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
                                      body: blog.blogTitle,
                                      context: context,
                                    );
                                  },
                                  child: iconcontainr(
                                    icon: CupertinoIcons.bell_fill,
                                    iccolor: Colors.yellow,
                                    bgcolor: Colors.black.withOpacity(0.65),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 11,
                                right: 13,
                                child: InkWell(
                                  onDoubleTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.UpdateblogRoute,
                                      arguments: BlogDetailArguments(
                                        blog_audio: blog.blogAudio,
                                        id: detailid,
                                        blogTitle: blog.blogTitle,
                                        blogDescription: blog.blogDescription,
                                        blogCategroy: blog.blogCategory,
                                        blogDate: blog.blogDate,
                                        blogImages: blog.blogImages,
                                        blogImage: blog.blogImage,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.65),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.yellow,
                                    ),
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
                                          context: context,
                                          blogid: blog.blogId,
                                        )
                                        .whenComplete(() {
                                          Navigator.of(
                                            context,
                                          ).pushNamedAndRemoveUntil(
                                            AppRoutes.HomeRoute,
                                            (route) => false,
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.65),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.yellow,
                                    ),
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
                                        blog.blogTitle,
                                        overflow: TextOverflow.clip,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                    "Posted On ${blog.blogDate.split('-').reversed.join('-')}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount:
                        items.length >= _totalpage ? _totalpage : items.length,
                  ),
                ),
              ],
            ),
            loading == true
                ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 7,
                    ),
                    child: Container(
                      height: 25,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          "Loading....",
                          style: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                : SizedBox(),
          ],
        )
        : Shimmer.fromColors(
          baseColor: Color.fromARGB(255, 233, 249, 173),
          highlightColor: Color.fromARGB(255, 209, 216, 169),
          //   baseColor: Color.fromARGB(255, 223, 234, 185),
          // highlightColor: Color.fromARGB(255, 219, 216, 195),
          child: ListView.builder(
            itemCount: 9,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, __) {
              return Container(
                margin: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 0.0,
                  bottom: 15.0,
                ),
                width: MediaQuery.of(context).size.width,
                height: 110,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 204, 241, 71),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: Offset(0.0, 10.0),
                      blurRadius: 10.0,
                      spreadRadius: -6.0,
                    ),
                  ],
                ),
              );
            },
          ),
        );
  }

  Widget iconcontainr({
    required IconData icon,
    required iccolor,
    required bgcolor,
  }) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Icon(icon, color: iccolor),
    );
  }
}
