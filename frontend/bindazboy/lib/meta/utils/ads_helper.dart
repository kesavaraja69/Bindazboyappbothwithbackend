import 'dart:io';

class AdHelper {
  static String get bannerAdUnitid {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstrialAdUnitid {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
