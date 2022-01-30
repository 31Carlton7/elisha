import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/config/constants.dart';
import 'package:elisha/src/models/verse.dart';
import 'package:elisha/src/providers/study_tools_repository_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

Future<void> showFavoriteVerseBottomSheet(BuildContext context, Verse verse) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    elevation: 0,
    useRootNavigator: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(17),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.3,
        widthFactor: 0.75,
        child: Consumer(
          builder: (context, watch, child) {
            return StatefulBuilder(
              builder: (context, setState) {
                var _isFavoriteVerse = watch(studyToolsRepositoryProvider)
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
                            await watch(studyToolsRepositoryProvider).addFavoriteVerse(verse);
                          } else {
                            await watch(studyToolsRepositoryProvider).removeFavoriteVerse(verse);
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
