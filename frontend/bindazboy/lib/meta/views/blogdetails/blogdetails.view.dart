import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/models/blogdetail.model.dart';
import 'package:bindazboy/core/notifiers/blogs.notifier.dart';
import 'package:bindazboy/core/notifiers/bookmark.notifer.dart';
import 'package:bindazboy/meta/utils/blogdetail_arguments.dart';
import 'package:bindazboy/meta/utils/custombannerad.dart';
import 'package:bindazboy/meta/views/blogdetails/components/lower.plane.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Blogdetailsview extends StatefulWidget {
  final BlogDetailArguments blogDetailArguments;
  const Blogdetailsview({required this.blogDetailArguments});

  @override
  _BlogdetailsviewState createState() => _BlogdetailsviewState();
}

class _BlogdetailsviewState extends State<Blogdetailsview> {
  AudioPlayer advancedPlayer = AudioPlayer();
  // late BannerAd _bottomBannerAd;
  // bool _isBottomBannerAdLoaded = false;

  // void _createBottomBannerAd() {
  //   _bottomBannerAd = BannerAd(
  //       size: AdSize.fullBanner,
  //       adUnitId: AdHelper.bannerAdUnitid,
  //       listener: BannerAdListener(onAdLoaded: (_) {
  //         setState(() {
  //           _isBottomBannerAdLoaded = true;
  //         });
  //       }, onAdFailedToLoad: (ad, error) {
  //         ad.dispose();
  //       }),
  //       request: AdRequest());
  //   _bottomBannerAd.load();
  // }

  @override
  void initState() {
    final BookmarkNotifier bookmarkNotifier =
        Provider.of<BookmarkNotifier>(context, listen: false);
    bookmarkNotifier.checkIfBookmarkExists(
        context: context, blog_id: widget.blogDetailArguments.id);
    super.initState();
    advancedPlayer = AudioPlayer();
    // _createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    advancedPlayer.dispose();
    // _bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final planeHeightclosed = MediaQuery.of(context).size.height * 0.65;
    final planeHeightopen = MediaQuery.of(context).size.height * 0.65;
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    final provider = Provider.of<BlogNotifer>(context, listen: false);
    final BookmarkNotifier bookmarkNotifier =
        Provider.of<BookmarkNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: BConstantColors.backgroundColor,
      // bottomNavigationBar: _isBottomBannerAdLoaded
      //     ? Container(
      //         color: Colors.black.withOpacity(0.50),
      //         height: 50.0,
      //         width: _bottomBannerAd.size.width.toDouble(),
      //         child: AdWidget(ad: _bottomBannerAd),
      //       )
      //     : null,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.93,
            child: SizedBox(
              child: FutureBuilder(
                  future: provider.loadingBlogsDetail(
                      context: context,
                      detailid: widget.blogDetailArguments.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: SpinKitFadingCircle(
                        color: BConstantColors.fullblack,
                        size: 50.0,
                      ));
                    } else {
                      var blogdetialdata = snapshot.data as dynamic;
                      Datadetails datadetails = blogdetialdata;
                      return CachedNetworkImage(
                        imageUrl: "${datadetails.blogImage}",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: BConstantColors.fullblack,
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                  color: BConstantColors.fullblack
                                      .withOpacity(0.6),
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
                            fit: StackFit.expand,
                            children: <Widget>[
                              // Image.network(
                              //   datadetails.blogImage,
                              //   fit: BoxFit.cover,
                              //   color: Colors.black54.withOpacity(0.45),
                              //   colorBlendMode: BlendMode.darken,
                              // ),
                              Positioned(
                                top: screenheight * 0.06,
                                left: 13,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    advancedPlayer.stop();
                                  },
                                  child: iconcontainer(
                                    context,
                                    Icons.arrow_back_ios_new_sharp,
                                    BConstantColors.detailcontrollColor,
                                    24.0,
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: screenheight * 0.06,
                                  right: 15,
                                  child: Container(
                                    child: FutureBuilder(
                                      future: bookmarkNotifier
                                          .checkIfBookmarkExists(
                                        context: context,
                                        blog_id: widget.blogDetailArguments.id,
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return iconcontainer(
                                            context,
                                            Icons.bookmark_border,
                                            BConstantColors.detailcontrollColor,
                                            25.0,
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                                ConnectionState.none &&
                                            snapshot.data == null) {
                                          return iconcontainer(
                                            context,
                                            Icons.bookmark_border,
                                            BConstantColors.detailcontrollColor,
                                            25.0,
                                          );
                                        }
                                        if (snapshot.data != null) {
                                          bool isBookmarked =
                                              snapshot.data as bool;
                                          return InkWell(
                                            onTap: () async {
                                              if (!isBookmarked) {
                                                await bookmarkNotifier
                                                    .addBookmark(
                                                  context: context,
                                                  blog_id: widget
                                                      .blogDetailArguments.id,
                                                );
                                                setState(() {
                                                  isBookmarked = true;
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                      Text("Bookmark is added"),
                                                ));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Already bookmarked!")));
                                              }
                                            },
                                            child: iconcontainer(
                                              context,
                                              isBookmarked
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              BConstantColors
                                                  .detailcontrollColor,
                                              25.0,
                                            ),
                                          );
                                        }
                                        return iconcontainer(
                                          context,
                                          Icons.bookmark_border,
                                          BConstantColors.detailcontrollColor,
                                          25.0,
                                        );
                                      },
                                    ),
                                  )),
                              Positioned(
                                  top: screenheight * 0.22,
                                  right: 4,
                                  child: titletext(
                                      context,
                                      "Posted On ${datadetails.blogDate.toString().split('-').reversed.join('-')}",
                                      screenwidth * 0.029,
                                      FontWeight.w500)),
                              Positioned(
                                top: screenheight * 0.22,
                                left: 3,
                                child: titletext(
                                    context,
                                    "Category by ${datadetails.blogCategory}",
                                    screenwidth * 0.029,
                                    FontWeight.w500),
                              ),
                              Positioned(
                                top: screenheight * 0.115,
                                left: 50,
                                right: 50,
                                child: titletext(context, datadetails.blogTitle,
                                    screenwidth * 0.037, FontWeight.bold),
                              ),
                              SlidingUpPanel(
                                color: Colors.black.withOpacity(0.30),
                                maxHeight: planeHeightopen,
                                minHeight: planeHeightclosed,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0)),
                                panelBuilder: (controller) => LowerPlane(
                                    audioplay: datadetails.blogAudio,
                                    blogdetails: datadetails.blogDescription,
                                    advancedPlayer: advancedPlayer,
                                    images: datadetails.blogImages,
                                    controller: controller),
                              ),
                            ],
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_search_rounded),
                      );
                    }
                  }),
            ),
          ),
          Expanded(child: CustomBannerAd())
        ],
      ),
      //  bottomNavigationBar: CustomBannerAd(),
    );
  }

  Widget titletext(BuildContext context, title, size, weight) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: BConstantColors.descrptionColor,
                    fontSize: size,
                    fontWeight: weight),
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: BConstantColors.fullblack.withOpacity(0.50),
              borderRadius: BorderRadius.circular(12.0)),
        ),
      );

  Widget iconcontainer(BuildContext context, icon, color2, size) => Container(
        height: 35,
        width: 35,
        child: Center(
          child: Icon(
            icon,
            color: color2,
            size: size,
          ),
        ),
        decoration: BoxDecoration(
            color: BConstantColors.fullblack.withOpacity(0.60),
            borderRadius: BorderRadius.circular(12.0)),
      );
}
