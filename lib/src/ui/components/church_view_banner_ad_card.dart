import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/ad_state_provider.dart';
import 'package:elisha/src/services/ad_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
