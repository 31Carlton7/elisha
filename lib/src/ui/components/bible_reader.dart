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
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:elisha/src/config/constants.dart';
import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/providers/reader_settings_repository_provider.dart';
import 'package:elisha/src/providers/study_tools_repository_provider.dart';
import 'package:elisha/src/ui/components/show_favorite_verse_bottom_sheet.dart';
import '../../providers/bible_repository_provider.dart';


class BibleReader extends ConsumerWidget {
  const BibleReader({Key? key, required this.chapter, required this.scrollController}) : super(key: key);

  final Chapter chapter;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> children = [const SizedBox(height: 10)];
    List<InlineSpan> spans = [];
    children.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        child: Text.rich(
          TextSpan(children: spans),
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: ref.watch(readerSettingsRepositoryProvider.notifier).bodyTextSize * 1.4,
                height: ref.watch(readerSettingsRepositoryProvider.notifier).bodyTextHeight * 1.1,
                fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
              ),
        ),
      ),
    );
    for (int i = 0; i < chapter.verses!.length; i++) {
      var item = chapter.verses![i];
      var _isFavoriteVerse =
          ref.watch(studyToolsRepositoryProvider).favoriteVerses.where((element) => element.id == item.id).isNotEmpty;

      spans.add(
        WidgetSpan(
          child: GestureDetector(
            onTap: () async {
              HapticFeedback.mediumImpact();
              await showFavoriteVerseBottomSheet(context, item);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_isFavoriteVerse)
                    Icon(
                      LineAwesomeIcons.heart_1,
                      size: ref.watch(readerSettingsRepositoryProvider).verseNumberSize * 1.3,
                      color: heartColor(context),
                    ),
                  Text(
                    item.verseId.toString(),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          fontSize: ref.watch(readerSettingsRepositoryProvider).verseNumberSize * 1.1,
                          // height: ref.watch(readerSettingsRepositoryProvider).verseNumberHeight,
                          fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
                        ),
                  ),
                  if (!_isFavoriteVerse)
                    const Icon(
                      LineAwesomeIcons.heart_1,
                      size: 10,
                      color: CantonColors.transparent,
                    ),
                ],
              ),
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

    return GestureDetector(
      onHorizontalDragEnd: (details) async {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          // Swiped from left to right (previous chapter)
          await ref
              .read(bibleRepositoryProvider)
              .goToNextPreviousChapter(ref, true);
          scrollController.jumpTo(0.0);
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          // Swiped from right to left (next chapter)
          await ref
              .read(bibleRepositoryProvider)
              .goToNextPreviousChapter(ref, false);
          scrollController.jumpTo(0.0);
        }
      },
      child: Column(
        children: [...children],
      ),
    );
  }
}
