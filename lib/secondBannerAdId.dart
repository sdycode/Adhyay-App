import 'dart:io';

import 'package:flutter/foundation.dart';

class SecondAdsUnitID {
  static String get bannerAdUnitId {
    return
      (!kReleaseMode)? (Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/6300978111'):
      (Platform.isIOS && !kReleaseMode) ? 'ca-app-pub-3940256099942544/2934735716'
        :
      (Platform.isAndroid && kReleaseMode) ? 'ca-app-pub-2613436750082691/2944953881'
        :
      (Platform.isIOS && kReleaseMode) ? ''
        :
      throw  UnsupportedError('Unsupported platform');
  }

  static String get interstitialAdUnitId {
    return
      (Platform.isAndroid && !kReleaseMode) ? "ca-app-pub-3940256099942544/1033173712"
          :
      (Platform.isIOS && !kReleaseMode) ? "ca-app-pub-3940256099942544/4411468910"
          :
      (Platform.isAndroid && kReleaseMode) ? ''
          :
      (Platform.isIOS && kReleaseMode) ? ''
          :
      throw  UnsupportedError('Unsupported platform');
  }

  static String get rewardedAdUnitId {
    return
      (Platform.isAndroid && !kReleaseMode) ? "ca-app-pub-3940256099942544/5224354917"
          :
      (Platform.isIOS && !kReleaseMode) ? "ca-app-pub-3940256099942544/1712485313"
          :
      (Platform.isAndroid && kReleaseMode) ? ''
          :
      (Platform.isIOS && kReleaseMode) ? ''
          :
      throw  UnsupportedError('Unsupported platform');
  }

  static String get nativeAdUnitId {
    return
      (Platform.isAndroid && !kReleaseMode) ? "ca-app-pub-3940256099942544/1044960115"
          :
      (Platform.isIOS && !kReleaseMode) ? "ca-app-pub-3940256099942544/2521693316"
          :
      (Platform.isAndroid && kReleaseMode) ? ''
          :
      (Platform.isIOS && kReleaseMode) ? ''
          :
      throw  UnsupportedError('Unsupported platform');
  }
}