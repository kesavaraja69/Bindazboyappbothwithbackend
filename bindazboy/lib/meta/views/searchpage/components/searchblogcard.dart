import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/models/search.model.dart';
import 'package:bindazboy/meta/utils/ads_helper.dart';
import 'package:bindazboy/meta/utils/blogdetail_arguments.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:numeral/numeral.dart';

const int maxFailedLoadAttempts = 3;

class Searchblogcard extends StatefulWidget {
  final dynamic snapshot;
  const Searchblogcard({super.key, required this.snapshot});

  @override
  State<Searchblogcard> createState() => _SearchblogcardState();
}

class _SearchblogcardState extends State<Searchblogcard> {
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempts = 0;
  // late BannerAd _bottomBannerAd;
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
      ),
    );
  }

  @override
  void initState() {
    _createInterstitialAd();
    super.initState();
  }

  // void _showInterstitialAd() {
  //   if (_interstitialAd == null) {
  //     print('Warning: attempt to show interstitial before loaded.');
  //     return;
  //   }
  //   _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (InterstitialAd ad) =>
  //         print('ad onAdShowedFullScreenContent.'),
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       print('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //   );
  //   _interstitialAd!.show();
  //   _interstitialAd = null;
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _interstitialAd?.dispose();
  //   // _bottomBannerAd.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.snapshot.length,
      itemBuilder: (context, index) {
        Searchdata blog = widget.snapshot[index];
        int detailid = blog.blogId;
        return GestureDetector(
          onTap: () async {
            Navigator.of(context).pushNamed(
              AppRoutes.BlogDetailRoute,
              arguments: BlogDetailArguments(id: detailid),
            );
          },
          child: CachedNetworkImage(
            imageUrl: blog.blogImage,
            width: MediaQuery.of(context).size.width,
            height: 135,
            imageBuilder:
                (context, imageProvider) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 9,
                  ),
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
                        spreadRadius: -6.0,
                      ),
                    ],
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        BConstantColors.fullblack.withOpacity(0.55),
                        BlendMode.darken,
                      ),
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
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
                                blog.blogTitle,
                                overflow: TextOverflow.clip,
                                maxLines: null,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: BConstantColors.titleColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 9.0,
                          ),
                          child: Text(
                            "Posted On ${blog.blogDate.split('-').reversed.join('-')}",
                            style: TextStyle(
                              color: BConstantColors.titleColor.withOpacity(
                                0.75,
                              ),
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        left: MediaQuery.of(context).size.width * 0.42,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 7,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.visibility,
                                size: 13,
                                color: BConstantColors.titleColor.withOpacity(
                                  0.75,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                Numeral(int.parse(blog.blogView)).numeral(),
                                style: TextStyle(
                                  color: BConstantColors.titleColor.withOpacity(
                                    0.75,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 9.0,
                          ),
                          child: Text(
                            "Posted By BindazBoy",
                            style: TextStyle(
                              color: BConstantColors.titleColor.withOpacity(
                                0.75,
                              ),
                              fontWeight: FontWeight.w400,
                              fontSize: 9,
                            ),
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
            errorWidget:
                (context, url, error) => const Icon(Icons.image_search_rounded),
          ),
        );
      },
    );
  }
}
