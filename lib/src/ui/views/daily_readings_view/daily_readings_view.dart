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
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:elisha/src/models/daily_reading.dart';
import 'package:elisha/src/models/reading.dart';
import 'package:elisha/src/providers/reader_settings_repository_provider.dart';
import 'package:elisha/src/ui/views/daily_readings_view/components/daily_readings_view_header.dart';

class DailyReadingsView extends ConsumerWidget {
  const DailyReadingsView(this.dailyReading, {Key? key}) : super(key: key);

  final DailyReading dailyReading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context, ref),
    );
  }

  Widget _content(BuildContext context, WidgetRef ref) {
    final _scrollController = ScrollController();
    return Scrollbar(
      controller: _scrollController,
      child: ListView(
        controller: _scrollController,
        children: [
          const DailyReadingsViewHeader(),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._body(context, ref),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _body(BuildContext context, WidgetRef ref) {
    List<Widget> children = [
      Text(
        dailyReading.name!,
        style: Theme.of(context).textTheme.headline3?.copyWith(
              fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
            ),
      ),
      const SizedBox(height: 5),
      Text(
        'Lectionary: ' + dailyReading.lectionary!,
        style: Theme.of(context).textTheme.headline6?.copyWith(
              color: Theme.of(context).colorScheme.secondaryContainer,
              fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
            ),
      ),
      const SizedBox(height: 30),
    ];

    for (int i = 0; i < dailyReading.readings!.length; i++) {
      children.add(
        _readingCard(context, dailyReading.readings![i], ref),
      );
      if (i != dailyReading.readings!.length - 1) {
        children.add(const SizedBox(height: 30));
      }
    }

    children.add(const SizedBox(height: 17));
    children.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Linkify(
          onOpen: (link) async {
            if (await canLaunch(link.url)) {
              await launch(link.url);
            } else {
              throw 'Could not launch $link';
            }
          },
          text:
              'Daily Readings is courtesy of the United States Conference of Catholic Bishops © 2022. Their Website is located at https://bible.usccb.org/bible/readings',
          style: Theme.of(context).textTheme.headline6,
          linkStyle: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                decoration: TextDecoration.underline,
              ),
        ),
      ),
    );

    return children;
  }

  Widget _readingCard(BuildContext context, Reading reading, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              reading.name!,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
                  ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                reading.snippetAddress!,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
                    ),
              ),
            ),
          ],
        ),
        const Divider(height: 20),
        Text(
          reading.text!,
          style: Theme.of(context).textTheme.headline5?.copyWith(
                fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
                fontWeight: FontWeight.w400,
                fontSize: ref.watch(readerSettingsRepositoryProvider).bodyTextSize * 1.3,
                height: ref.watch(readerSettingsRepositoryProvider).bodyTextHeight,
              ),
        ),
      ],
    );
  }
}
