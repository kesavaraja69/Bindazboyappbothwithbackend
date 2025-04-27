import 'package:bindazboy/core/notifiers/utility.notifer.dart';
import 'package:bindazboy/meta/views/home/components/audio/audiodetails/audiobooklowerplane.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../../../../app/constant/colors.dart';
import '../../../../../../core/models/audiobook/audiobookdetail.model.dart';

class AudioDetailsView extends StatefulWidget {
  final dynamic snapdata;

  const AudioDetailsView({super.key, this.snapdata});

  @override
  State<AudioDetailsView> createState() => _AudioDetailsViewState();
}

class _AudioDetailsViewState extends State<AudioDetailsView> {
  int? audioid;

  // Duration _duration = new Duration();
  // Duration _position = new Duration();
  bool isPaused = false;
  bool isPlaying = false;
  bool isLopp = false;
  String? path;

  String? titlead;
  bool isalplaying = false;

  final List<IconData> _icon = [
    Icons.play_circle_outlined,
    Icons.pause_circle_outlined,
  ];

  // @override
  // void initState() {
  //   super.initState();

  //   advancedPlayer.setUrl(
  //       "https://res.cloudinary.com/dsfbuyj5o/video/upload/v1654126634/samples/DheeramassTamilan_xpfieu.mp3");
  //   advancedPlayer.durationStream.listen((du) {
  //     setState(() {
  //       _duration = du!;
  //     });
  //   });

  //   advancedPlayer.positionStream.listen((du) {
  //     setState(() {
  //       _position = du;
  //     });
  //   });

  //   advancedPlayer.playbackEventStream.listen((event) {
  //     if (event.processingState == ProcessingState.completed) {
  //       setState(() {
  //         isPlaying = false;
  //         //_position = Duration(seconds: 0);
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final mheight = MediaQuery.of(context).size.height;
    final mwidth = MediaQuery.of(context).size.width;

    final planeHeightclosed = MediaQuery.of(context).size.height * 0.68;
    final planeHeightopen = MediaQuery.of(context).size.height * 0.68;
    final audioutilty = Provider.of<UtilityNotifier>(context, listen: true);
    Dataadwch data = widget.snapdata;

    return WillPopScope(
      onWillPop: () async {
        audioutilty.advancedPlayer.stop();

        audioutilty.audioplaycheck(isplaying: false);

        setState(() {
          audioid = null;
          isPlaying = false;
        });
        // Navigator.pop(context);
        return true;
      },
      child: Stack(
        children: [
          Image.network(
            data.audiobookImagecover.toString(),
            fit: BoxFit.cover,
            width: mwidth,
            height: mheight * 0.34,
          ),
          Positioned(
            top: mheight * 0.06,
            left: 10,
            child: GestureDetector(
              onTap: () {
                audioutilty.advancedPlayer.pause();

                audioutilty.audioplaycheck(isplaying: false);

                setState(() {
                  audioid = null;
                  isPlaying = false;
                });
                Navigator.pop(context);
              },
              child: iconcontainer(
                context,
                Icons.arrow_back_ios_new_sharp,
                BConstantColors.detailcontrollColor,
                24.0,
              ),
            ),
          ),

          // Positioned(
          //   top: mheight * 0.32,
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Color.fromARGB(255, 233, 235, 187),
          //       borderRadius: BorderRadius.only(
          //           topRight: Radius.circular(12), topLeft: Radius.circular(12)),
          //     ),
          //     child: SingleChildScrollView(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.only(left: 15, top: 13),
          //             child: Text(
          //               data.audiobookTitle.toString(),
          //               style: TextStyle(
          //                   color: Color.fromARGB(255, 8, 8, 8),
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.w600),
          //             ),
          //           ),
          //           Padding(
          //             padding:
          //                 const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          //             child: Text(
          //               data.audiobookDescription.toString(),
          //               style: TextStyle(
          //                   color: Color.fromARGB(255, 8, 8, 8),
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w400),
          //             ),
          //           ),
          //           Padding(
          //             padding:
          //                 const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          //             child: Text(
          //               "Chapters",
          //               style: TextStyle(
          //                   color: Color.fromARGB(255, 8, 8, 8),
          //                   fontSize: 19,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //           SizedBox(
          //             height: 7,
          //           ),
          //           AudioBookchapList(),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SlidingUpPanel(
            color: Color.fromARGB(255, 255, 240, 176),
            maxHeight: planeHeightopen,
            minHeight: planeHeightclosed,
            borderRadius: BorderRadius.vertical(top: Radius.circular(17.0)),
            panelBuilder:
                (controller) => AudiobookLowerpanel(
                  controller: controller,
                  booktitle: data.audiobookTitle.toString(),
                  audiolist: data.audiochapter,
                  callback: (int id, dynamic url, bool play, dynamic title) {
                    setState(() {
                      audioid = id;
                      titlead = title;
                      isPlaying = play;
                    });
                  },
                  description: data.audiobookDescription.toString(),
                ),
          ),
          audioid != null && audioutilty.audioisPlay == true
              ? Positioned(
                left: 5,
                right: 5,
                bottom: 15,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 7.0,
                      vertical: 2.0,
                    ),
                    height: 85,
                    width: mwidth,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 8, 8, 8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                titlead.toString(),
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(220, 223, 223, 223),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: slider(),
                            ),
                            SizedBox(
                              height: 26,
                              width: 290,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 4,
                                      right: 2,
                                    ),
                                    child: Text(
                                      audioutilty.audiopostion.toString().split(
                                        ".",
                                      )[0],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(
                                          220,
                                          223,
                                          223,
                                          223,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 4,
                                      left: 2,
                                    ),
                                    child: Text(
                                      audioutilty.audioduration
                                          .toString()
                                          .split(".")[0],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(
                                          220,
                                          223,
                                          223,
                                          223,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12, right: 6),
                          child: btnStart(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : Container(),
        ],
      ),
    );
  }

  Widget btnStart() {
    final audioutilty = Provider.of<UtilityNotifier>(context, listen: true);
    return IconButton(
      onPressed: () {
        if (audioutilty.audioisPlay == true) {
          setState(() {
            isPlaying = true;
          });
        }

        if (isPlaying == false) {
          audioutilty.audioplaycheck(isplaying: true);
          setState(() {
            isPlaying = true;
            isalplaying = true;
          });
        } else if (isPlaying == true) {
          audioutilty.audioplaycheck(isplaying: false);
          setState(() {
            isPlaying = false;
            isalplaying = false;
          });
        }
      },
      icon: Icon(
        isPlaying == false ? _icon[0] : _icon[1],
        size: 45,
        color: Color.fromARGB(232, 237, 237, 237),
      ),
    );
  }

  Widget slider() {
    final audioutilty = Provider.of<UtilityNotifier>(context, listen: true);
    return SizedBox(
      height: 9,
      width: 320,
      child: Slider(
        min: 0.0,
        activeColor: BConstantColors.detailcontrollColor,
        inactiveColor: Color.fromARGB(220, 223, 223, 223),
        max:
            audioutilty.audioduration?.inSeconds.toDouble() ??
            Duration.zero.inSeconds.toDouble(),
        value:
            audioutilty.audiopostion?.inSeconds.toDouble() ??
            Duration.zero.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            audioutilty.changetosecnd(value.toInt());
            value = value;
          });
        },
      ),
    );
  }

  Widget iconcontainer(BuildContext context, icon, color2, size) => Container(
    height: 35,
    width: 35,
    decoration: BoxDecoration(
      color: BConstantColors.fullblack.withOpacity(0.60),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Center(child: Icon(icon, color: color2, size: size)),
  );
}
