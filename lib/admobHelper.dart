import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-4315903975362102/2975171291'
      : 'ca-app-pub-4315903975362102/2975171291';
  static String get interstitialAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-4315903975362102/4004916971'
      : 'ca-app-pub-4315903975362102/4004916971';
  static initialize() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
        size: AdSize.banner,
        adUnitId: bannerAdUnitId,
        listener: BannerAdListener(
            onAdLoaded: (Ad ad) => print('Ad loaded'),
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              ad.dispose();
            },
            onAdOpened: (Ad ad) => print('Ad Opened'),
            onAdClosed: (Ad ad) => print('Ad Closed')),
        request: AdRequest());
    return ad;
  }

  static BannerAd createlargeBannerAd() {
    BannerAd ad = new BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: bannerAdUnitId,
        listener: BannerAdListener(
            onAdLoaded: (Ad ad) => print('Ad loaded'),
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              ad.dispose();
            },
            onAdOpened: (Ad ad) => print('Ad Opened'),
            onAdClosed: (Ad ad) => print('Ad Closed')),
        request: AdRequest());
    return ad;
  }
}
