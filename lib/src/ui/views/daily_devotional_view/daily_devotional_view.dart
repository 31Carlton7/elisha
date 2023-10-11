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
import 'package:flutter_html/flutter_html.dart' as htm;
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:elisha/src/providers/reader_settings_repository_provider.dart';
import 'package:elisha/src/ui/views/daily_devotional_view/components/daily_devotional_view_header.dart';

class DailyDevotionalView extends ConsumerWidget {
  const DailyDevotionalView({Key? key, required this.htmlData}) : super(key: key);

  final String htmlData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CantonScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context, ref),
    );
  }

  Widget _content(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const DailyDevotionalViewHeader(),
        _body(context, ref),
      ],
    );
  }

  Widget _body(BuildContext context, WidgetRef ref) {
    final _scrollController = ScrollController();
    final font = ref.watch(readerSettingsRepositoryProvider).typeFace;

    return Expanded(
      child: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: htm.Html(
                  style: {
                    'h1': htm.Style(fontSize: htm.FontSize(32), fontFamily: font),
                    'center': htm.Style(fontSize: htm.FontSize(20), fontFamily: font),
                    'b': htm.Style(
                      fontSize: htm.FontSize(18),
                      lineHeight: const htm.LineHeight(1.5),
                      fontFamily: font,
                    ),
                    'p': htm.Style(
                      fontSize: htm.FontSize(18),
                      lineHeight: const htm.LineHeight(1.85),
                      fontFamily: font,
                    ),
                  },
                  data: htmlData,
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Container(
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
                        'Daily Devotional is courtesy of © 2022 DAILY SCRIPTURE READINGS AND MEDITATIONS. Their Website is located at https://www.dailyscripture.net/daily-meditation/',
                    style: Theme.of(context).textTheme.headline6,
                    linkStyle: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
            ],
          ),
        ),
      ),
    );
  }
}
