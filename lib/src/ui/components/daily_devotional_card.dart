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

import 'package:canton_ui/canton_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:elisha/src/providers/daily_devotional_service_provider.dart';

class DailyDevotionalCard extends ConsumerStatefulWidget {
  const DailyDevotionalCard({Key? key}) : super(key: key);

  @override
  ConsumerState<DailyDevotionalCard> createState() => _DailyDevotionalCardState();
}

class _DailyDevotionalCardState extends ConsumerState<DailyDevotionalCard> {
  Future<void> _onPressed(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    final link = ref.read(dailyDevotionalServiceProvider).interfaceUrl;

    Color bgColor() {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return CantonDarkColors.gray[800]!;
      }
      return CantonColors.gray[300]!;
    }

    // final devotionalRepo = ref.watch(dailyDevotionalTodayProvider);

    return GestureDetector(
      onTap: () async {
        await _onPressed(link);
        // await CantonMethods.viewTransition(context, DailyDevotionalView(htmlData: htmlData));
      },
      child: Container(
        padding: const EdgeInsets.all(17.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: CantonMethods.alternateCanvasColorType3(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(context, bgColor()),
                  const SizedBox(height: 15),
                  _body(context, bgColor()),
                ],
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 7,
                  top: 7,
                  child: Container(
                    height: 130,
                    width: 75,
                    decoration: BoxDecoration(
                      color: bgColor(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(
                  height: 130,
                  width: 75,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [CantonColors.purple[500]!, CantonColors.purple[600]!],
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      LineAwesomeIcons.praying_hands,
                      color: CantonColors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // return devotionalRepo.when(
    //   error: (e, s) => const ErrorCard(),
    //   loading: () => const LoadingCard(),
    //   data: (htmlData) {

    //   },
    // );
  }

  Widget _header(BuildContext context, Color bgColor) {
    return Text(
      'Daily Devotional',
      style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _body(BuildContext context, Color bgColor) {
    final link = ref.read(dailyDevotionalServiceProvider).interfaceUrl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Learn and Meditate on God\'s Word daily',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CantonPrimaryButton(
          containerWidth: 100,
          containerHeight: 40,
          color: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.onBackground,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          buttonText: 'Read',
          onPressed: () async {
            await _onPressed(link);

            // CantonMethods.viewTransition(
            //   context,
            //   DailyDevotionalView(htmlData: htmlData),
            // );
          },
        ),
      ],
    );
  }
}
