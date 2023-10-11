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

import 'package:elisha/src/models/verse.dart';
import 'package:elisha/src/providers/study_tools_repository_provider.dart';

class FavoriteVerseCard extends ConsumerStatefulWidget {
  const FavoriteVerseCard({Key? key, required this.verse}) : super(key: key);

  final Verse verse;

  @override
  _FavoriteVerseCardState createState() => _FavoriteVerseCardState();
}

class _FavoriteVerseCardState extends ConsumerState<FavoriteVerseCard> {
  String cardTitle() {
    final str =
        widget.verse.book.name! + ' ' + widget.verse.chapterId.toString() + ':' + widget.verse.verseId.toString();

    return str;
  }

  Widget _favoriteButton(BuildContext context, Verse verse) {
    var _isFavorite = verse.favorite;
    Color bgColor() {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return CantonDarkColors.gray[800]!;
      }
      return CantonColors.gray[300]!;
    }

    Color heartColor() {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return CantonDarkColors.red[400]!;
      }
      return CantonColors.red[400]!;
    }

    Icon icon() {
      if (verse.favorite) {
        return Icon(LineAwesomeIcons.heart_1, size: 20, color: heartColor());
      }
      return Icon(LineAwesomeIcons.heart, size: 20, color: Theme.of(context).colorScheme.secondaryContainer);
    }

    return GestureDetector(
      onTap: () async {
        HapticFeedback.mediumImpact();

        setState(() {
          _isFavorite = !_isFavorite;
        });

        if (_isFavorite) {
          await ref.read(studyToolsRepositoryProvider).addFavoriteVerse(verse);
        } else {
          await ref.read(studyToolsRepositoryProvider).removeFavoriteVerse(verse);
        }
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor()),
        child: Center(
          child: icon(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: const EdgeInsets.symmetric(vertical: 17),
      color: CantonMethods.alternateCanvasColor(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardTitle(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 7),
                Text(
                  widget.verse.text,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          _favoriteButton(context, widget.verse),
        ],
      ),
    );
  }
}
