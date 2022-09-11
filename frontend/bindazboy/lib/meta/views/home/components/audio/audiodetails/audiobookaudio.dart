import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../../app/constant/colors.dart';

class AudioBookFile extends StatefulWidget {
  final String url;
  AudioBookFile({Key? key, required this.url}) : super(key: key);

  @override
  _AudioBookFileState createState() => _AudioBookFileState();
}

class _AudioBookFileState extends State<AudioBookFile> {
  AudioPlayer advancedPlayer = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
    advancedPlayer.dispose();
    // _bottomBannerAd.dispose();
  }

  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPaused = false;
  bool isPlaying = false;
  bool isLopp = false;
  String path = '';
  bool isalplaying = false;

  //     "https://res.cloudinary.com/dsfbuyj5o/video/upload/v1638775170/images%20demo/03DARBAR_Tamil_-_Kannula_Thimiru_Lyric_Video___Rajinikanth___AR_Murugadoss___Anirudh___Subaskaran_256kbps_cbr_lrsyip.mp3";

  List<IconData> _icon = [Icons.play_circle_fill, Icons.pause_circle_filled];

  @override
  void initState() {
    super.initState();

    advancedPlayer.setUrl(widget.url);
    advancedPlayer.durationStream.listen((du) {
      setState(() {
        _duration = du!;
      });
    });

    advancedPlayer.positionStream.listen((du) {
      setState(() {
        _position = du;
      });
    });

    advancedPlayer.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        setState(() {
          isPlaying = false;
          //_position = Duration(seconds: 0);
        });
      }
    });

    // advancedPlayer.onDurationChanged.listen((d) {
    //   setState(() {
    //     _duration = d;
    //   });
    // });

    // advancedPlayer.onPlayerStateChanged.listen((PlayerState s) {
    //   print('Current player state: $s');
    // });

    // advancedPlayer.onAudioPositionChanged.listen((p) {
    //   setState(() {
    //     _position = p;
    //   });
    // });
    // advancedPlayer.onPlayerCompletion.listen((event) {
    //   setState(() {
    //     _position = Duration(seconds: 0);
    //     isPlaying = false;
    //     advancedPlayer.stop();
    //   });
    // });
    // setState(() {
    //   path = widget.url;
    // });

    // advancedPlayer.setUrl(path);
  }

  Widget btnStart() {
    return IconButton(
      onPressed: () {
        if (isPlaying == false) {
          advancedPlayer.play();
          setState(() {
            isPlaying = true;
            isalplaying = true;
          });
        } else if (isPlaying == true) {
          advancedPlayer.pause();
          setState(() {
            isPlaying = false;
            isalplaying = false;
          });
        }
      },
      icon: Icon(
        isPlaying == false ? _icon[0] : _icon[1],
        size: 45,
        color: Color.fromARGB(220, 223, 223, 223),
      ),
    );
  }

  Widget slider() {
    return SizedBox(
      height: 20,
      width: 310,
      child: Slider(
          min: 0.0,
          activeColor: BConstantColors.detailcontrollColor,
          inactiveColor: Color.fromARGB(220, 223, 223, 223),
          max: _duration.inSeconds.toDouble(),
          value: _position.inSeconds.toDouble(),
          onChanged: (double value) {
            setState(() {
              changetosecnd(value.toInt());
              value = value;
            });
          }),
    );
  }

  void changetosecnd(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  Widget loadasset() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [btnStart()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mheight = MediaQuery.of(context).size.height;
    final mwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
        height: 70,
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
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: slider(),
                ),
                Container(
                  height: 26,
                  width: 290,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: Text(
                          _position.toString().split(".")[0],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(220, 223, 223, 223),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        child: Text(
                          _duration.toString().split(".")[0],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(220, 223, 223, 223),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: btnStart(),
            ),
          ],
        ),
      ),
    );
  }
}
