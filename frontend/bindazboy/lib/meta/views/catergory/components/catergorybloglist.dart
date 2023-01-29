import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/models/blogcatergory.model.dart';
import 'package:bindazboy/core/notifiers/catergoryblogs.notifer.dart';
import 'package:bindazboy/meta/utils/ads_helper.dart';
import 'package:bindazboy/meta/utils/blogdetail_arguments.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:numeral/numeral.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

const int maxFailedLoadAttempts = 3;

class CatergoryblogList extends StatefulWidget {
  List<dynamic> snapshot;
  dynamic catergorytitle;

  CatergoryblogList({required this.snapshot, this.catergorytitle});

  @override
  State<CatergoryblogList> createState() => _CatergoryblogListState();
}

class _CatergoryblogListState extends State<CatergoryblogList> {
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempts = 0;
  // late BannerAd _bottomBannerAd;
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

  List<dynamic> items = [];
  int _pageno = 1;
  int _totalpage = 1;
  List<dynamic>? blogdata = [];
  bool loading = false, allloaded = false;

  mockfetch() async {
    if (allloaded) {
      return;
    } else {
      final blogprovider =
          Provider.of<CatergoryBlogNotifer>(context, listen: false);
      blogdata = await blogprovider.fetchCatergoryBlogswithlimit(
          context: context,
          catergory_title: widget.catergorytitle,
          pageno: _pageno);
      _totalpage = await blogprovider.numberofblog!;
      if (mounted) {
        setState(() {
          loading = true;
        });
      }
      List<String> newData = items.length >= _totalpage
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
      final blogprovider =
          Provider.of<CatergoryBlogNotifer>(context, listen: false);
      blogdata = await blogprovider.fetchCatergoryBlogswithlimit(
          context: context,
          catergory_title: widget.catergorytitle,
          pageno: _pageno);
      _totalpage = await blogprovider.numberofblog!;

      List<String> newData = items.length >= _totalpage
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
    }
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    mockfetch();
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent &&
          !loading) {
        mockfetch2();
      }
    });

    // _createBottomBannerAd();

    // _blogwithAds = List.from(widget.snapshot);
    // for (var i = _blogwithAds.length - 2; i >= 1; i -= 3) {
    //   _blogwithAds.insert(i, _bottomBannerAd);
    // }
  }

  static final AdRequest request = AdRequest();
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstrialAdUnitid,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _interstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _interstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_interstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _controller.dispose();
    // _bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty
        ? Stack(
            children: [
              CustomScrollView(
                controller: _controller,
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount:
                        items.length >= _totalpage ? _totalpage : items.length,
                    (context, index) {
                      //   ListView.builder(
                      // itemCount: widget.snapshot.length,
                      // itemBuilder: (context, index) {
                      Data _blog = items[index];

                      return GestureDetector(
                        onTap: () async {
                          int detailid = _blog.blogId;
                          print("index is ${(index % 3).toInt()}");
                          if ((index % 3).toInt() == 0) {
                            _showInterstitialAd();
                          }
                          Navigator.of(context).pushNamed(
                              AppRoutes.BlogDetailRoute,
                              arguments: BlogDetailArguments(id: detailid));
                        },
                        child: CachedNetworkImage(
                          imageUrl: "${_blog.blogImage.toString()}",
                          width: MediaQuery.of(context).size.width,
                          height: 135,
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 9),
                            width: MediaQuery.of(context).size.width,
                            height: 135,
                            decoration: BoxDecoration(
                              color: BConstantColors.fullblack,
                              borderRadius: BorderRadius.circular(15),
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
                                      BConstantColors.fullblack
                                          .withOpacity(0.55),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
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
                                          color: BConstantColors.titleColor
                                              .withOpacity(0.75),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    ),
                                  ),
                                  alignment: Alignment.bottomLeft,
                                ),
                                Positioned(
                                  bottom: 1,
                                  left:
                                      MediaQuery.of(context).size.width * 0.42,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 7),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.visibility,
                                          size: 13,
                                          color: BConstantColors.titleColor
                                              .withOpacity(0.75),
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
                                          color: BConstantColors.titleColor
                                              .withOpacity(0.75),
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
                  )),
                ],
              ),
              loading == true
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical:
                                MediaQuery.of(context).size.height * 0.09),
                        child: Container(
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Center(
                            child: Text(
                              "Loading....",
                              style: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox()
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
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
                  ),
                );
              },
            ),
          );
  }
}
