import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9458621217720467/3097459170';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9458621217720467/1401234122';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}