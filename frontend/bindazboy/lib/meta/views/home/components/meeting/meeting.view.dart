import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/models/zoomdetails.model.dart';
import 'package:bindazboy/core/notifiers/zoom.notifier.dart';
import 'package:bindazboy/meta/utils/ads_helper.dart';
import 'package:bindazboy/meta/utils/alertbox.utils.dart';
import 'package:bindazboy/meta/utils/custombannerad.dart';
import 'package:bindazboy/meta/views/home/components/meeting/meetingdetailview.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../../utils/showsnackbar.utils.dart';

const int maxFailedLoadAttempts = 3;
const String testDevice = '198039EA87A433F495D95F51D12D8139';

class MeetingView extends StatefulWidget {
  const MeetingView({super.key});

  @override
  State<MeetingView> createState() => _MeetingViewState();
}

class _MeetingViewState extends State<MeetingView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool isRegisted = false;

  dynamic fndata;

  dynamic zoomslot;

  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;

  static final AdRequest request = AdRequest();

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    fetchuserZoom();
    fetchZoom();
    _createRewardedInterstitialAd();
    super.initState();
  }

  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: AdHelper.interstrialRewardAdUnitid,
        request: request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            print('$ad loaded.');
            _rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedInterstitialAd failed to load: $error');
            _rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedInterstitialAd();
            }
          },
        ));
  }

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedInterstitialAd();
      },
    );

    _rewardedInterstitialAd!.setImmersiveMode(true);
    _rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedInterstitialAd = null;
  }

  Future<bool> _logoutdailog({text, isZoom}) async {
    return await AlertdailogBoxgm.showAlertbox2(
            context: context,
            onclick1: () async {
              if (isZoom) {
                Navigator.of(context).pop();
                _showRewardedInterstitialAd();
                // Navigator.of(context).pop();
                setState(() {
                  fetchuserZoom();
                });
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            title: "Message",
            content: text,
            isCorrect: isZoom) ??
        false;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    _rewardedInterstitialAd?.dispose();
  }

  fetchuserZoom() async {
    final zoomprovider = Provider.of<ZoomNoitifer>(context, listen: false);
    final data = await zoomprovider.checkzoomUser(context: context);
    setState(() {
      isRegisted = data;
    });
  }

  fetchZoom() async {
    final zoomprovider = Provider.of<ZoomNoitifer>(context, listen: false);
    final data = await zoomprovider.fetchzoomDetail(context: context);

    var fndatas = data as ZoomDetailsData;

    setState(() {
      fndata = fndatas.zoomMeetId;
    });
  }

  Future<bool> _onWillPop() async {
    FocusManager.instance.primaryFocus?.unfocus();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final zoomprovider = Provider.of<ZoomNoitifer>(context, listen: false);

    final mheigth = MediaQuery.of(context).size.height;
    final mwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: BConstantColors.backgroundColor,
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: isRegisted == false
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: mheigth * 0.1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9),
                                child: Container(
                                  height: mheigth * 0.21,
                                  width: mwidth,
                                  decoration: BoxDecoration(
                                    color: BConstantColors.fullblack,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: FutureBuilder(
                                      future: zoomprovider.fetchzoomDetail(
                                          context: context),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: Text(
                                              "Loading....",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      221, 254, 222, 81),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        }
                                        if (snapshot.data != null) {
                                          var data =
                                              snapshot.data as ZoomDetailsData;

                                          zoomslot = data.zoomAvailableSlots;

                                          if (zoomslot != 0) {
                                            return Stack(children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 9),
                                                  child: Text(
                                                    "Zoom Meeting Details",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            221, 254, 222, 81),
                                                        fontSize:
                                                            mwidth * 0.045,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: mwidth * 0.07,
                                                top: mheigth * 0.055,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Title : ${data.zoomMeetTopic}",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              221,
                                                              254,
                                                              222,
                                                              81),
                                                          fontSize:
                                                              mwidth * 0.045,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                left: mwidth * 0.07,
                                                top: mheigth * 0.087,
                                                child: Text(
                                                  "Date & Time : ${data.zoommeetdateandtime}",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          221, 254, 222, 81),
                                                      fontSize: mwidth * 0.045,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Positioned(
                                                left: mwidth * 0.07,
                                                top: mheigth * 0.12,
                                                child: Text(
                                                  "UpComing Date : ${data.zoommeetupcomingdate}",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          221, 254, 222, 81),
                                                      fontSize: mwidth * 0.045,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 9,
                                                        horizontal: 20),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: SizedBox(
                                                    height: mheigth * 0.03,
                                                    width: mwidth,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          child: Text(
                                                            "Total Slots : ${data.zoomTotalSlots}",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        221,
                                                                        254,
                                                                        222,
                                                                        81),
                                                                fontSize:
                                                                    mwidth *
                                                                        0.04,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          child: Text(
                                                            "Available Slots : ${data.zoomAvailableSlots}",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        221,
                                                                        254,
                                                                        222,
                                                                        81),
                                                                fontSize:
                                                                    mwidth *
                                                                        0.04,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ]);
                                          } else {
                                            return Center(
                                              child: Text(
                                                "No Slot Available, Try Next Time",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        221, 254, 222, 81),
                                                    fontSize: mwidth * 0.045,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }
                                        }
                                        return Center(
                                          child: Text(
                                            "No Zoom Meeting Available",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    221, 254, 222, 81),
                                                fontSize: mwidth * 0.045,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomBannerAd(),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Register Here for Zoom Meeting",
                                style: TextStyle(
                                    color: BConstantColors.appbartitleColor,
                                    fontSize: mwidth * 0.060,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              labeltext("Name"),
                              const SizedBox(
                                height: 2,
                              ),
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color:
                                        BConstantColors.authenticationIconColor,
                                  ),
                                  hintText: "Enter Name",
                                  labelStyle:
                                      TextStyle(color: BConstantColors.black),
                                  //fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9),
                                      borderSide: BorderSide(
                                          color: BConstantColors.lightgrey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9),
                                      borderSide: BorderSide(
                                          color: BConstantColors.fullblack)),
                                ),
                                style: TextStyle(
                                    color: BConstantColors.appbartitleColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              labeltext("Email"),
                              const SizedBox(
                                height: 2,
                              ),
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color:
                                        BConstantColors.authenticationIconColor,
                                  ),
                                  hintText: "Enter Email",
                                  labelStyle:
                                      TextStyle(color: BConstantColors.black),
                                  //fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9),
                                      borderSide: BorderSide(
                                          color: BConstantColors.lightgrey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9),
                                      borderSide: BorderSide(
                                          color: BConstantColors.fullblack)),
                                ),
                                style: TextStyle(
                                    color: BConstantColors.appbartitleColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 19,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  var useremail = emailController.text;
                                  var username = nameController.text;
                                  if (fndata != null) {
                                    if (useremail.isNotEmpty &&
                                        username.isNotEmpty) {
                                      await zoomprovider
                                          .fetchzoomDetail(context: context)
                                          .then((value) async {
                                        print(value);

                                        ZoomDetailsData data = value;

                                        print(data.zoomAvailableSlots);

                                        if (data.zoomAvailableSlots != 0) {
                                          await zoomprovider
                                              .registerZoom(
                                                  context: context,
                                                  username: username,
                                                  useremail: useremail,
                                                  zoomid: 1)
                                              .then((value) async {
                                            if (value != null &&
                                                value != false) {
                                              await zoomprovider
                                                  .updatezoomSlot(
                                                      context: context,
                                                      zoomid: data.zoomId,
                                                      nofSlots:
                                                          data.zoomAvailableSlots! -
                                                              1)
                                                  .then((value) async {
                                                if (value == true) {
                                                  _logoutdailog(
                                                      text:
                                                          "Successfully Registered",
                                                      isZoom: true);
                                                  ;
                                                }
                                              });
                                            }
                                          });
                                        } else {
                                          await _logoutdailog(
                                              text:
                                                  "No Slot Available, try next time",
                                              isZoom: false);
                                        }
                                      });
                                    } else {
                                      _logoutdailog(
                                          text: "Fill The Value Correctly",
                                          isZoom: false);
                                    }
                                  } else {
                                    _logoutdailog(
                                        text: "No Zoom Meeting Available",
                                        isZoom: false);
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: BConstantColors
                                          .authenticationTxtColor,
                                      fontSize: 21),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      BConstantColors.authenticationBtnColor,
                                  minimumSize: Size(100, 45),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          child: Container(
                            height: mheigth * 0.46,
                            width: mwidth,
                            decoration: BoxDecoration(
                              color: BConstantColors.fullblack,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FutureBuilder(
                                future: zoomprovider.fetchzoomDetail(
                                    context: context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: Text(
                                        "Loading....",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                221, 254, 222, 81),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }
                                  if (snapshot.data != null) {
                                    var data = snapshot.data as ZoomDetailsData;

                                    return ZoomMeetingDetails(
                                      data: data,
                                      userem: zoomprovider.isUserRegistereduser,
                                      bookdate:
                                          zoomprovider.isUserRegistereddate,
                                    );
                                  }
                                  return Center(
                                    child: Text(
                                      "No Zoom Meeting Available",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(221, 254, 222, 81),
                                          fontSize: mwidth * 0.045,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        CustomBannerAd(),
                      ],
                    )),
        ),
      ),
    );
  }
}
