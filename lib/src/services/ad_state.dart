/*
Elisha iOS & Android App
Copyright (C) 2022 Carlton Aikins

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

var homeViewBannerAdIsLoaded = false;
var churchViewBannerAdIsLoaded = false;
var votdViewBannerAdIsLoaded = false;

class AdState {
  // iOS ad ids
  static const _iosHomeViewBannerAdId = 'ca-app-pub-6026970342993334/4798379037';
  static const _iosChurchViewBannerAdId = 'ca-app-pub-6026970342993334/8562928877';
  static const _iosVotdViewBannerAdId = 'ca-app-pub-6026970342993334/4452474650';

  // Android ad ids
  static const _androidHomeViewBannerAdId = 'ca-app-pub-6026970342993334/8364189149';
  static const _androidChurchViewBannerAdId = 'ca-app-pub-6026970342993334/6049936860';
  static const _androidVotdViewBannerAdId = 'ca-app-pub-6026970342993334/2331037330';

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

  String get votdViewbannerAdUnitId {
    if (Platform.isAndroid) {
      return _androidVotdViewBannerAdId;
    } else {
      return _iosVotdViewBannerAdId;
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
        churchViewBannerAdIsLoaded = false;
      },
      onAdLoaded: (Ad ad) {
        churchViewBannerAdIsLoaded = true;
      },
    ),
  );

  final votdViewBannerAd = BannerAd(
    adUnitId: Platform.isAndroid ? _androidVotdViewBannerAdId : _iosVotdViewBannerAdId,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        votdViewBannerAdIsLoaded = false;
      },
      onAdLoaded: (Ad ad) {
        votdViewBannerAdIsLoaded = true;
      },
    ),
  );
}
