import 'package:audioplayers/audioplayers.dart';
import 'package:bindazboy/core/notifiers/utility.notifer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../../app/constant/colors.dart';
import '../../../../../core/notifiers/audiobook.notifer.dart';
import '../../../../utils/audiobookdetail_argument.dart';
import 'audiodetails/audiobookdetail.view.dart';

class AudiobookDetailsdata extends StatefulWidget {
  final AudiobookDetailArguments audiobookDetailArguments;
  const AudiobookDetailsdata({Key? key, required this.audiobookDetailArguments})
      : super(key: key);

  @override
  State<AudiobookDetailsdata> createState() => _AudiobookDetailsdataState();
}

class _AudiobookDetailsdataState extends State<AudiobookDetailsdata> {
  @override
  Widget build(BuildContext context) {
    final mheight = MediaQuery.of(context).size.height;
    final mwidth = MediaQuery.of(context).size.width;
    final audioprovider = Provider.of<AudioBookNotifer>(context, listen: false);
    return Scaffold(
      backgroundColor: BConstantColors.backgroundColor,
      body: SizedBox(
        height: mheight,
        width: mwidth,
        child: FutureBuilder(
            future: audioprovider.fetchAudioBookdetail(
                context: context, audioid: widget.audiobookDetailArguments.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: SpinKitFadingCircle(
                  color: BConstantColors.black,
                  size: 50.0,
                ));
              }
              if (snapshot.data != null) {
                var _snapshot = snapshot.data;
                return AudioDetailsView(
                  snapdata: _snapshot,
                );
              } else {
                return Center(
                  child: Text(
                    "No Audiobook Details",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(243, 8, 7, 7)),
                  ),
                );
              }
            }),
      ),
    );
  }
}
