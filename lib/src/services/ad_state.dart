import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

var homeViewBannerAdIsLoaded = false;
var churchViewBannerAdIsLoaded = false;

class AdState {
  // iOS ad ids
  static const _iosHomeViewBannerAdId = 'ca-app-pub-6026970342993334/4798379037';
  static const _iosChurchViewBannerAdId = 'ca-app-pub-6026970342993334/8562928877';

  // Android ad ids
  static const _androidHomeViewBannerAdId = 'ca-app-pub-6026970342993334/8364189149';
  static const _androidChurchViewBannerAdId = 'ca-app-pub-6026970342993334/6049936860';

  String get homeViewbannerAdUnitId {
    if (Platform.isAndroid) {
      return _androidHomeViewBannerAdId;
    } else {
      return _iosHomeViewBannerAdId;
    }
  }

  String get churchViewbannerAdUnitId {
    if (Platform.isAndroid) {
      return _androidChurchViewBannerAdId;
    } else {
      return _iosChurchViewBannerAdId;
    }
  }

  final homeViewBannerAd = BannerAd(
    adUnitId: Platform.isAndroid ? _androidHomeViewBannerAdId : _iosHomeViewBannerAdId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        homeViewBannerAdIsLoaded = false;
      },
      onAdLoaded: (Ad ad) {
        homeViewBannerAdIsLoaded = true;
      },
    ),
  );

  final churchViewBannerAd = BannerAd(
    adUnitId: Platform.isAndroid ? _androidChurchViewBannerAdId : _iosChurchViewBannerAdId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        homeViewBannerAdIsLoaded = false;
      },
      onAdLoaded: (Ad ad) {
        homeViewBannerAdIsLoaded = true;
      },
    ),
  );
}
