import 'package:bindazboy/meta/utils/ads_helper.dart';
import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomBannerAd extends StatefulWidget {
  const CustomBannerAd({super.key});

  @override
  State<CustomBannerAd> createState() => _CustomBannerAdState();
}

class _CustomBannerAdState extends State<CustomBannerAd> {
  BannerAd? bannerAd;
  bool isBannerAdLoaded = false;

  @override
  void dispose() {
    bannerAd!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdHelper.bannerAdUnitid,
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          print("Ad Failed to Load");
          ad.dispose();
        },
        onAdLoaded: (ad) {
          print("Ad Loaded");
          setState(() {
            isBannerAdLoaded = true;
          });
        },
      ),
      request: const AdRequest(),
    );
    bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return isBannerAdLoaded
        ? SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: AdWidget(ad: bannerAd!),
        )
        : SizedBox();
  }
}
