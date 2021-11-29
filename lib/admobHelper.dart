import 'dart:io';
class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4315903975362102/2975171291';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4315903975362102/5144151598';
    } else {
      throw UnsupportedError("unsupported Platform");
    }
  }
}
