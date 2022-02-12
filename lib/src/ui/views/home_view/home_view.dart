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
import 'package:elisha/src/providers/ad_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/services/ad_state.dart';
import 'package:elisha/src/ui/components/daily_devotional_card.dart';
import 'package:elisha/src/ui/components/streaks_card.dart';
import 'package:elisha/src/ui/components/sunday_mass_card.dart';
import 'package:elisha/src/ui/components/verse_of_the_day_card.dart';
import 'package:elisha/src/ui/views/home_view/components/home_view_header.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  BannerAd? _ad;

  @override
  void initState() {
    super.initState();

    final hvAd = ref.read(adStateProvider).votdViewBannerAd;

    _ad = BannerAd(
      adUnitId: hvAd.adUnitId,
      size: AdSize.banner,
      request: hvAd.request,
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          setState(() {
            homeViewBannerAdIsLoaded = false;
          });

          ad.dispose();
        },
        onAdLoaded: (Ad ad) {
          setState(() {
            homeViewBannerAdIsLoaded = true;
          });
        },
      ),
    );

    _ad!.load();
  }

  @override
  void dispose() {
    _ad!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const HomeViewHeader(),
          _body(context),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    final isSunday = DateTime.now().weekday == DateTime.sunday;

    return Responsive(
      mobile: _buildMobileBody(context, isSunday),
      tablet: _buildTabletBody(context, isSunday),
    );
  }

  Widget _buildMobileBody(BuildContext context, bool isSunday) {
    return Column(
      children: [
        const StreaksCard(marginalPadding: false),
        const SizedBox(height: 17),
        if (isSunday) const SundayMassCard(),
        if (isSunday) const SizedBox(height: 17),
        const VerseOfTheDayCard(),
        homeViewBannerAdIsLoaded ? const SizedBox(height: 27) : const SizedBox(height: 17),
        if (homeViewBannerAdIsLoaded)
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            width: _ad!.size.width.toDouble(),
            height: _ad!.size.height.toDouble(),
            child: AdWidget(ad: _ad!),
          ),
        if (homeViewBannerAdIsLoaded) const SizedBox(height: 17),
        const DailyDevotionalCard(),
        const SizedBox(height: 17),
      ],
    );
  }

  Widget _buildTabletBody(BuildContext context, bool isSunday) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const StreaksCard(marginalPadding: false),
        ),
        const SizedBox(height: 17),
        if (isSunday)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const SundayMassCard(),
          ),
        if (isSunday) const SizedBox(height: 17),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const VerseOfTheDayCard(),
        ),
        homeViewBannerAdIsLoaded ? const SizedBox(height: 27) : const SizedBox(height: 17),
        if (homeViewBannerAdIsLoaded)
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            width: _ad!.size.width.toDouble(),
            height: _ad!.size.height.toDouble(),
            child: AdWidget(ad: _ad!),
          ),
        if (homeViewBannerAdIsLoaded) const SizedBox(height: 17),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const DailyDevotionalCard(),
        ),
        const SizedBox(height: 17),
      ],
    );
  }
}
