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

import 'package:elisha/src/providers/reader_settings_repository_provider.dart';
import 'package:flutter/services.dart';

import 'package:canton_ui/canton_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:elisha/src/models/verse.dart';
import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:elisha/src/providers/study_tools_repository_provider.dart';
import 'package:elisha/src/providers/verse_of_the_day_future_provider.dart';
import 'package:elisha/src/ui/components/error_card.dart';
import 'package:elisha/src/ui/components/loading_card.dart';
import 'package:elisha/src/ui/views/verse_of_the_day_view/verse_of_the_day_view.dart';

class VerseOfTheDayCard extends ConsumerStatefulWidget {
  const VerseOfTheDayCard({Key? key}) : super(key: key);

  @override
  _VerseOfTheDayCardState createState() => _VerseOfTheDayCardState();
}

class _VerseOfTheDayCardState extends ConsumerState<VerseOfTheDayCard> {
  var _isFavorite = false;
  List<Verse>? _verses = [];

  @override
  void initState() {
    super.initState();
    _checkIfVerseIsFavorite();
  }

  void _checkIfVerseIsFavorite() {
    _isFavorite = ref.read(studyToolsRepositoryProvider).favoriteVerses.where((e) {
      return _verses!.any((element) => e.text == element.text);
    }).isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    const elementSpacing = 17.0;
    Color bgColor() {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return CantonDarkColors.gray[800]!;
      }
      return CantonColors.gray[300]!;
    }

    final votdRepo = ref.watch(verseOfTheDayFutureProvider);

    return votdRepo.when(
      error: (e, s) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: const ErrorCard(),
          ),
        );
      },
      loading: () {
        return const LoadingCard();
      },
      data: (verses) {
        _verses = verses;
        _checkIfVerseIsFavorite();

        return GestureDetector(
          onTap: () {
            CantonMethods.viewTransition(context, VerseOfTheDayView(verses: _verses!));
          },
          child: Container(
            padding: const EdgeInsets.all(17.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: CantonMethods.alternateCanvasColorType3(context),
            ),
            child: Column(
              children: [
                _buildImage(context),
                const SizedBox(height: elementSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _header(context, bgColor()),
                          const SizedBox(height: elementSpacing),
                          _body(context, bgColor()),
                          const SizedBox(height: elementSpacing),
                          _bookChapterVerse(context),
                        ],
                      ),
                    ),
                    _favoriteButton(context, bgColor(), _verses!),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(BuildContext context) {
    var imagePath = ref.watch(localUserRepositoryProvider).getNatureImage;

    final imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Image.asset(
        imagePath,
        fit: BoxFit.fitWidth,
        height: 140,
        width: MediaQuery.of(context).size.width,
        errorBuilder: (_, __, ___) {
          return Container();
        },
      ),
    );

    return imageWidget;
  }

  Widget _header(BuildContext context, Color bgColor) {
    return Text(
      'Verse of the Day',
      style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _favoriteButton(BuildContext context, Color bgColor, List<Verse> verses) {
    Color heartColor() {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return CantonDarkColors.red[400]!;
      }
      return CantonColors.red[400]!;
    }

    Icon icon() {
      if (ref.watch(studyToolsRepositoryProvider).favoriteVerses.where((e) {
        return _verses!.any((element) => e.id == element.id);
      }).isNotEmpty) {
        return Icon(LineAwesomeIcons.heart_1, size: 24, color: heartColor());
      }
      return Icon(LineAwesomeIcons.heart, size: 24, color: Theme.of(context).colorScheme.primary);
    }

    return GestureDetector(
      onTap: () async {
        HapticFeedback.mediumImpact();

        setState(() {
          _isFavorite = !_isFavorite;
        });

        for (Verse item in verses) {
          if (_isFavorite) {
            await ref.read(studyToolsRepositoryProvider).addFavoriteVerse(item);
          } else {
            await ref.read(studyToolsRepositoryProvider).removeFavoriteVerse(item);
          }
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: icon(),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, Color bgColor) {
    String verseText() {
      var str = '';
      for (Verse item in _verses!) {
        str += item.text + ' ';
      }
      return str.substring(0, str.length);
    }

    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 17),
          Expanded(
            child: Text(
              verseText(),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: _verses == null ? Theme.of(context).colorScheme.error : null,
                    fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
                    fontSize: ref.watch(readerSettingsRepositoryProvider).bodyTextSize * 1.3,
                    height: ref.watch(readerSettingsRepositoryProvider).bodyTextHeight * 0.8,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookChapterVerse(BuildContext context) {
    String versesString() {
      if (_verses != null) {
        var str = '';
        if (_verses!.length > 1) {
          str = _verses!.first.verseId.toString() + ' - ' + _verses!.last.verseId.toString();
        } else {
          str = _verses![0].verseId.toString();
        }

        return str;
      }
      return '';
    }

    return Text(
      _verses == null
          ? 'Matthew 28:20'
          : _verses![0].book.name! + ' ' + _verses![0].chapterId.toString() + ':' + versesString(),
      style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}
