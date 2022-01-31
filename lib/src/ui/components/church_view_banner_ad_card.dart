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

import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:elisha/src/providers/ad_state_provider.dart';
import 'package:elisha/src/services/ad_state.dart';

class ChurchViewBannerAdCard extends ConsumerWidget {
  const ChurchViewBannerAdCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ad = watch(adStateProvider).churchViewBannerAd;

    ad.load();

    final adWidget = AdWidget(ad: ad);

    return churchViewBannerAdIsLoaded
        ? Card(
            color: CantonColors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(17),
              height: ad.size.height.toDouble(),
              child: adWidget,
            ),
          )
        : Container();
  }
}
