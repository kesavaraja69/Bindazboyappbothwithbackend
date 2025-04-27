import 'dart:io';

class AdHelper {
  static String get bannerAdUnitid {
    if (Platform.isAndroid) {
      // return "ca-app-pub-3940256099942544/6300978111";
      return "ca-app-pub-8041552506861975/1319401665";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitid2 {
    if (Platform.isAndroid) {
      // return "ca-app-pub-3940256099942544/6300978111";
      return "ca-app-pub-8041552506861975/3889427244";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstrialAdUnitid {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
      // return "ca-app-pub-8041552506861975/1127829970";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstrialAdUnitid2 {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
      // return "ca-app-pub-8041552506861975/8659388253";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstrialRewardAdUnitid {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5354046379";
      // return "ca-app-pub-8041552506861975/1127829970";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
