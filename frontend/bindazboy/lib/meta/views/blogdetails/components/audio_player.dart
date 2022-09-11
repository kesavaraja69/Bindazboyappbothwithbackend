import 'package:audioplayers/audioplayers.dart';
import 'package:bindazboy/app/constant/colors.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;

  final String url;
  AudioFile({Key? key, required this.advancedPlayer, required this.url})
      : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  AudioCache audioCache = AudioCache();
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPaused = false;
  bool isPlaying = false;
  bool isLopp = false;
  String path = '';

  //     "https://res.cloudinary.com/dsfbuyj5o/video/upload/v1638775170/images%20demo/03DARBAR_Tamil_-_Kannula_Thimiru_Lyric_Video___Rajinikanth___AR_Murugadoss___Anirudh___Subaskaran_256kbps_cbr_lrsyip.mp3";

  List<IconData> _icon = [Icons.play_circle_fill, Icons.pause_circle_filled];

  @override
  void initState() {
    super.initState();
    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    widget.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        isPlaying = false;
        widget.advancedPlayer.stop();
      });
    });
    setState(() {
      path = widget.url;
    });

    widget.advancedPlayer.setUrl(path);
  }

  Widget btnStart() {
    return IconButton(
      onPressed: () {
        if (isPlaying == false) {
          widget.advancedPlayer.play(path);
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          widget.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
      icon: Icon(
        isPlaying == false ? _icon[0] : _icon[1],
        size: 45,
        color: BConstantColors.detailcontrollColor,
      ),
    );
  }

  Widget slider() {
    return Slider(
        min: 0.0,
        activeColor: BConstantColors.detailcontrollColor,
        inactiveColor: Color.fromARGB(255, 32, 32, 32),
        max: _duration.inSeconds.toDouble(),
        value: _position.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changetosecnd(value.toInt());
            value = value;
          });
        });
  }

  void changetosecnd(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
      height: 140,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 9.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split(".")[0],
                  style: TextStyle(
                    color: BConstantColors.detailcontrollColor,
                  ),
                ),
                Text(
                  _duration.toString().split(".")[0],
                  style: TextStyle(
                    color: BConstantColors.detailcontrollColor,
                  ),
                ),
              ],
            ),
          ),
          slider(),
          loadasset(),
        ],
      ),
    );
  }
}
