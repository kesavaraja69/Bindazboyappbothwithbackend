import 'dart:io';

import 'package:bindazboy/core/notifiers/cache.notifier.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:provider/provider.dart';

class UtilityNotifier extends ChangeNotifier {
  String? _audioUrl;
  String? get audioUrl => _audioUrl;

  Duration? _audioduration;
  Duration? get audioduration => _audioduration;

  Duration? _audiopostion;
  Duration? get audiopostion => _audiopostion;

  bool? _audioisPlay;
  bool? get audioisPlay => _audioisPlay;

  // set setPlay(bool name) {
  //   _audioisPlay = name;
  // }

  AudioPlayer advancedPlayer = AudioPlayer();

  readUserEmail({required BuildContext context}) async {
    CacheNotifier cacheNotifier =
        Provider.of<CacheNotifier>(context, listen: false);
    var cacheUsername = await cacheNotifier.readCache(key: "jwtdata");
    Map<String, dynamic> decodedToken = await JwtDecoder.decode(cacheUsername);
    var useremail = decodedToken["payload"];
    return useremail;
  }

  Future setAudioUrl({required url}) async {
    if (url != null) {
      await advancedPlayer.setUrl(url);
    } else {
      await advancedPlayer.setUrl(
          "https://res.cloudinary.com/dsfbuyj5o/video/upload/v1654126634/samples/DheeramassTamilan_xpfieu.mp3");
    }

    advancedPlayer.durationStream.listen((du) {
      _audioduration = du!;

      notifyListeners();
    });

    advancedPlayer.positionStream.listen((du) {
      _audiopostion = du;

      notifyListeners();
    });

    advancedPlayer.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        // _audioisPlay = false;
        //_position = Duration(seconds: 0);
        notifyListeners();
      }
    });
    notifyListeners();

    return url;
  }

  void changetosecnd(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
    notifyListeners();
  }

  Future audioplaycheck({required bool isplaying}) async {
    if (isplaying == false) {
      _audioisPlay = isplaying;
      //  print(_audioisPlay);
      await advancedPlayer.pause();
    } else if (isplaying == true) {
      _audioisPlay = isplaying;
      await advancedPlayer.play();
    }
    notifyListeners();
  }

  Future audiofiledispose() async {
    var disposeaudio = await advancedPlayer.dispose();
    // _bottomBannerAd.dispose();
    return disposeaudio;
  }
}
