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

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:elisha/src/config/constants.dart';
import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/providers/reader_settings_repository_provider.dart';
import 'package:elisha/src/providers/study_tools_repository_provider.dart';
import 'package:elisha/src/ui/components/show_favorite_verse_bottom_sheet.dart';

class BibleReader extends ConsumerWidget {
  const BibleReader({Key? key, required this.chapter}) : super(key: key);

  final Chapter chapter;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    List<Widget> children = [const SizedBox(height: 10)];
    List<InlineSpan> spans = [];
    children.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        child: Text.rich(
          TextSpan(children: spans),
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: watch(readerSettingsRepositoryProvider.notifier).bodyTextSize * 1.4,
                height: watch(readerSettingsRepositoryProvider.notifier).bodyTextHeight * 1.1,
                fontFamily: watch(readerSettingsRepositoryProvider).typeFace,
              ),
        ),
      ),
    );
    for (int i = 0; i < chapter.verses!.length; i++) {
      var item = chapter.verses![i];
      var _isFavoriteVerse =
          watch(studyToolsRepositoryProvider).favoriteVerses.where((element) => element.id == item.id).isNotEmpty;

      spans.add(
        WidgetSpan(
          child: GestureDetector(
            onTap: () async {
              HapticFeedback.mediumImpact();
              await showFavoriteVerseBottomSheet(context, item);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (_isFavoriteVerse)
                  Icon(LineAwesomeIcons.heart_1,
                      size: watch(readerSettingsRepositoryProvider).verseNumberSize * 1.4, color: heartColor(context)),
                Text(
                  item.verseId.toString() + ' ',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        fontSize: watch(readerSettingsRepositoryProvider).verseNumberSize * 1.4,
                        height: watch(readerSettingsRepositoryProvider).verseNumberHeight * 1.1,
                        fontFamily: watch(readerSettingsRepositoryProvider).typeFace,
                      ),
                ),
              ],
            ),
          ),
        ),
      );

      spans.add(
        TextSpan(
          text: item.text,
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              HapticFeedback.mediumImpact();
              await showFavoriteVerseBottomSheet(context, item);
            },
        ),
      );

      if (!(i == chapter.verses!.length - 1)) {
        spans.add(const TextSpan(text: ' '));
      }
    }

    children.add(const SizedBox(height: 40));

    return Column(
      children: [...children],
    );
  }
}
