import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BlogAd extends StatefulWidget {
  final Object adblog;
  final double height;
  final double width;
  BlogAd(
      {Key? key,
      required this.adblog,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  _BlogAdState createState() => _BlogAdState();
}

class _BlogAdState extends State<BlogAd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: AdWidget(key: UniqueKey(), ad: widget.adblog as BannerAd),
    );
  }
}
