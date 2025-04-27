import 'package:bindazboy/core/notifiers/utility.notifer.dart';
import 'package:flutter/material.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/models/audiobook/audiobookdetail.model.dart';

class AudioBookchapList extends StatefulWidget {
  final dynamic snapdata;
  final Function audiodatacallback;

  const AudioBookchapList({
    super.key,
    this.snapdata,
    required this.audiodatacallback,
  });

  @override
  State<AudioBookchapList> createState() => _AudioBookchapListState();
}

class _AudioBookchapListState extends State<AudioBookchapList> {
  /// AudioPlayer advancedPlayer = AudioPlayer();
  ///

  final List<Color> colors = [
    Colors.redAccent,
    Colors.lightGreenAccent,
    Colors.lightBlueAccent,
    Colors.yellowAccent,
  ];

  int _currentItem = 0;
  @override
  Widget build(BuildContext context) {
    final audioutilty = Provider.of<UtilityNotifier>(context, listen: false);
    final mwidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: widget.snapdata.length,
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        Audiochapter audiochapter = widget.snapdata[index];
        return GestureDetector(
          onTap: () async {
            setState(() {
              _currentItem = index;
              audioutilty.audioplaycheck(isplaying: true);
            });
            await audioutilty.setAudioUrl(
              url: audiochapter.audiobookchapterAudiourl,
            );

            await widget.audiodatacallback(
              audiochapter.audiobookchapterId,
              audiochapter.audiobookchapterAudiourl,
              audioutilty.audioisPlay,
              audiochapter.audiobookchapterTitle,
            );
            await audioutilty.advancedPlayer.play();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            child: Container(
              height: 70,
              width: mwidth,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 8, 8, 8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 12),
                        child: Text(
                          audiochapter.audiobookchapterTitle.toString(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 195, 195, 195),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        child: Text(
                          audiochapter.audiobookchapterDescription.toString(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 195, 195, 195),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _currentItem == index
                      ? audioutilty.audioisPlay == true
                          ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              height: 20,
                              width: 35,
                              child: MiniMusicVisualizer(
                                color: Colors.greenAccent,
                                width: 4,
                                height: 15,
                              ),
                            ),
                          )
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: SizedBox(
                              height: 70,
                              width: 30,
                              child: Icon(
                                Icons.play_circle_outlined,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: SizedBox(
                          height: 70,
                          width: 30,
                          child: Icon(
                            Icons.play_circle_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        );
        // return Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        //   child: Container(
        //     height: 75,
        //     width: mwidth,
        //     decoration: BoxDecoration(
        //       color: Color.fromARGB(255, 184, 229, 171),
        //       borderRadius: BorderRadius.all(Radius.circular(12)),
        //     ),
        //     child: Center(child: Text("${audiochapter.audiobookchapterId}")),
        //   ),
        // );
      },
    );
  }
}
