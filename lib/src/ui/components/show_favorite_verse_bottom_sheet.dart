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

import 'package:flutter/services.dart';

import 'package:canton_ui/canton_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:elisha/src/config/constants.dart';
import 'package:elisha/src/models/verse.dart';
import 'package:elisha/src/providers/study_tools_repository_provider.dart';

Future<void> showFavoriteVerseBottomSheet(BuildContext context, Verse verse) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    elevation: 0,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.3,
        widthFactor: Responsive.isTablet(context) ? 0.75 : null,
        child: Consumer(
          builder: (context, ref, child) {
            return StatefulBuilder(
              builder: (context, setState) {
                var _isFavoriteVerse = ref
                    .read(studyToolsRepositoryProvider)
                    .favoriteVerses
                    .where((element) => element.id == verse.id)
                    .isNotEmpty;

                Icon icon() {
                  if (_isFavoriteVerse) {
                    return Icon(LineAwesomeIcons.heart_1, size: 36, color: heartColor(context));
                  }
                  return Icon(LineAwesomeIcons.heart, size: 36, color: Theme.of(context).colorScheme.primary);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            verse.bookChapterVerse,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: CantonActionButton(
                        icon: icon(),
                        padding: EdgeInsets.zero,
                        containerHeight: 60,
                        containerWidth: 60,
                        onPressed: () async {
                          HapticFeedback.lightImpact();

                          setState(() {
                            _isFavoriteVerse = !_isFavoriteVerse;
                          });

                          if (_isFavoriteVerse) {
                            await ref.read(studyToolsRepositoryProvider).addFavoriteVerse(verse);
                          } else {
                            await ref.read(studyToolsRepositoryProvider).removeFavoriteVerse(verse);
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      );
    },
  );
}
