import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/models/blog.model.dart';
import 'package:bindazboy/core/notifiers/blogs.notifier.dart';
import 'package:bindazboy/core/notifiers/views.notifier.dart';
import 'package:bindazboy/meta/utils/ads_helper.dart';
import 'package:bindazboy/meta/utils/blogdetail_arguments.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

const int maxFailedLoadAttempts = 3;

class Bloglist extends StatefulWidget {
  final dynamic snapshot;
  bool? detailpage;
  Bloglist({
    required this.snapshot,
  });

  @override
  State<Bloglist> createState() => _BloglistState();
}

class _BloglistState extends State<Bloglist> {
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempts = 0;
  // late BannerAd _bottomBannerAd;

  // bool _isBannerAdload = false;

  final ScrollController _controller = ScrollController();

  // void _createBottomBannerAd() {
  //   _bottomBannerAd = BannerAd(
  //       size: AdSize.fullBanner,
  //       adUnitId: AdHelper.bannerAdUnitid,
  //       listener: BannerAdListener(onAdLoaded: (_) {
  //         setState(() {
  //           _isBannerAdload = true;
  //         });
  //       }, onAdFailedToLoad: (ad, error) {
  //         ad.dispose();
  //       }),
  //       request: AdRequest());
  //   _bottomBannerAd.load();
  // }

  List<String> items = [];
  bool loading = false, allloaded = false;

  mockfetch() async {
    if (allloaded) {
      return;
    } else {
      await Future.delayed(const Duration(milliseconds: 500))
          .whenComplete(() async {
        if (mounted) {
          setState(() {
            loading = true;
          });
        }
        List<String> newData = items.length >= widget.snapshot.length
            ? []
            : List.generate(5, (index) => "${index + items.length}");
        if (newData.isNotEmpty) {
          items.addAll(newData);
        }
        if (mounted) {
          setState(() {
            loading = false;
            allloaded = newData.isEmpty;
          });
        }
      });
    }
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstrialAdUnitid,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts >= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mockfetch();
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent &&
          !loading) {
        mockfetch();
      }
    });

    // _createBottomBannerAd();
    _createInterstitialAd();
    // _blogwithAds = List.from(widget.snapshot);
    // for (var i = _blogwithAds.length - 2; i >= 1; i -= 3) {
    //   _blogwithAds.insert(i, _bottomBannerAd);
    // }
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    // _bottomBannerAd.dispose();
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final postprovider = Provider.of<BlogNotifer>(context, listen: false);
    final viewprovider = Provider.of<ViewsNotifier>(context, listen: false);
    return ListView.builder(
      // separatorBuilder: (context, index) {
      //   return (_isBottomBannerAdLoaded && index != 0 && index % 3 == 0)
      //       ? Container(
      //           height: _bottomBannerAd.size.height.toDouble(),
      //           width: _bottomBannerAd.size.width.toDouble(),
      //           child: AdWidget(key: UniqueKey(), ad: _bottomBannerAd),
      //         )
      //       : Divider(
      //           height: 2.0,
      //         );
      // },
      itemCount: items.length >= widget.snapshot.length
          ? widget.snapshot.length
          : widget.detailpage == false
              ? items.length
              : widget.snapshot.length,
      itemBuilder: (context, index) {
        final _blog = widget.snapshot[index] as Data;
        return GestureDetector(
          onTap: () async {
            int detailid = _blog.blogId;
            if (index != 0 && (index % 3).toInt() == 0) {
              _showInterstitialAd();
            }
            Navigator.of(context).pushNamed(AppRoutes.BlogDetailRoute,
                arguments: BlogDetailArguments(id: detailid));
            // EasyLoading.show(status: 'Updateing..Wait..');
            await viewprovider
                .checkViews(context: context, post_id: _blog.blogId)
                .whenComplete(() async {
              if (viewprovider.isviewData == false) {
                //  EasyLoading.dismiss();
                await viewprovider
                    .addView(context: context, fspostid: _blog.blogId)
                    .then((v) {
                  viewprovider
                      .featchViews(context: context, post_id: _blog.blogId)
                      .then((f) {
                    //    _logger.i("view is ${viewprovider.likeidData2}");
                    postprovider.addviewupdatepost(
                        context: context,
                        blog_id: _blog.blogId,
                        post_view: "${viewprovider.viewidData2.toString()}");
                  });
                });
              }
            });
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
                      BConstantColors.fullblack.withOpacity(0.55),
                      BlendMode.darken),
                  image: NetworkImage(_blog.blogImage),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                    child: Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 13,
                          color: BConstantColors.titleColor.withOpacity(0.75),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "${_blog.blogView}",
                          style: TextStyle(
                              color:
                                  BConstantColors.titleColor.withOpacity(0.75),
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
        );
      },
    );
  }
}
