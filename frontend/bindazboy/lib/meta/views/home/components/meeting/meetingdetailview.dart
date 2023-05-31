import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/models/zoomdetails.model.dart';
import 'package:bindazboy/meta/utils/ads_helper.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

const int maxFailedLoadAttempts = 3;
const String testDevice = '198039EA87A433F495D95F51D12D8139';

class ZoomMeetingDetails extends StatefulWidget {
  ZoomDetailsData data;
  dynamic userem;
  dynamic bookdate;
  ZoomMeetingDetails(
      {super.key, required this.data, this.userem, this.bookdate});

  @override
  State<ZoomMeetingDetails> createState() => _ZoomMeetingDetailsState();
}

class _ZoomMeetingDetailsState extends State<ZoomMeetingDetails> {
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempts = 0;
  // late BannerAd _bottomBannerAd;

  static final AdRequest request = AdRequest();

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstrialAdUnitid2,
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
    _interstitialAd?.dispose();
    super.dispose();

    // _bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mheigth = MediaQuery.of(context).size.height;
    final mwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: BConstantColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Container(
          height: mheigth * 0.42,
          width: mwidth,
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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Text(
                    "Your Registration is Successful",
                    style: TextStyle(
                        color: Color.fromARGB(221, 95, 254, 81),
                        fontSize: mwidth * 0.047,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                top: mheigth * 0.055,
                child: Row(
                  children: [
                    Text(
                      "Zoom Meeting Details",
                      style: TextStyle(
                          color: Color.fromARGB(221, 254, 222, 81),
                          fontSize: mwidth * 0.047,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                top: mheigth * 0.097,
                child: Row(
                  children: [
                    Text(
                      "Title : ${widget.data.zoomMeetTopic}",
                      style: TextStyle(
                          color: Color.fromARGB(221, 254, 222, 81),
                          fontSize: mwidth * 0.047,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                top: mheigth * 0.145,
                child: Text(
                  "Date & Time : ${widget.data.zoommeetdateandtime}",
                  style: TextStyle(
                      color: Color.fromARGB(221, 254, 222, 81),
                      fontSize: mwidth * 0.047,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                top: mheigth * 0.19,
                child: Row(
                  children: [
                    Text(
                      "Meeting ID : ${widget.data.zoomMeetId}",
                      style: TextStyle(
                          color: Color.fromARGB(221, 254, 222, 81),
                          fontSize: mwidth * 0.047,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showInterstitialAd();
                        Clipboard.setData(ClipboardData(
                            text: widget.data.zoomMeetId.toString()));
                        ShowsnackBarUtiltiy.showSnackbar(
                            message: "Copied to Clipboard", context: context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Icon(
                          Icons.copy,
                          size: 25,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                top: mheigth * 0.24,
                child: Row(
                  children: [
                    Text(
                      "Meeting Password : ${widget.data.zoomMeetPassword}",
                      style: TextStyle(
                          color: Color.fromARGB(221, 254, 222, 81),
                          fontSize: mwidth * 0.047,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                            text: widget.data.zoomMeetPassword.toString()));
                        ShowsnackBarUtiltiy.showSnackbar(
                            message: "Copied to Clipboard", context: context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Icon(
                          Icons.copy,
                          size: 25,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                top: mheigth * 0.29,
                child: Text(
                  widget.data.zoommeetupcomingdate != null
                      ? "UpComing Meeting : ${widget.data.zoommeetupcomingdate}"
                      : "UpComing Meeting : None",
                  style: TextStyle(
                      color: Color.fromARGB(221, 254, 222, 81),
                      fontSize: mwidth * 0.047,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                bottom: mheigth * 0.067,
                child: Row(
                  children: [
                    Text(
                      "---------------------------------------",
                      style: TextStyle(
                          color: Color.fromARGB(221, 254, 167, 81),
                          fontSize: mwidth * 0.04,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                bottom: mheigth * 0.045,
                child: Row(
                  children: [
                    Text(
                      "UserEmail Id : ${widget.userem}",
                      style: TextStyle(
                          color: Color.fromARGB(221, 254, 167, 81),
                          fontSize: mwidth * 0.04,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: mwidth * 0.07,
                bottom: mheigth * 0.015,
                child: Row(
                  children: [
                    Text(
                      "Booked Date : ${DateFormat().format(DateTime.parse("${widget.bookdate}"))}",
                      style: TextStyle(
                          color: Color.fromARGB(221, 254, 167, 81),
                          fontSize: mwidth * 0.04,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
