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
import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:elisha/src/providers/reader_settings_repository_provider.dart';
import 'package:elisha/src/providers/study_tools_repository_provider.dart';

class VerseOfTheDayView extends ConsumerStatefulWidget {
  const VerseOfTheDayView({Key? key, required this.verses}) : super(key: key);

  final List<Verse> verses;

  @override
  ConsumerState<VerseOfTheDayView> createState() => _VerseOfTheDayViewState();
}

class _VerseOfTheDayViewState extends ConsumerState<VerseOfTheDayView> {
  var _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = ref.read(studyToolsRepositoryProvider).favoriteVerses.where((e) {
      return widget.verses.any((element) => e.id == element.id);
    }).isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      padding: EdgeInsets.zero,
      safeArea: false,
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _header(context),
        _body(context),
      ],
    );
  }

  Widget _header(BuildContext context) {
    Widget _favoriteButton(BuildContext context) {
      Color heartColor() {
        if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
          return CantonDarkColors.red[400]!;
        }
        return CantonColors.red[400]!;
      }

      Icon icon() {
        if (ref.watch(studyToolsRepositoryProvider).favoriteVerses.where((e) {
          return widget.verses.any((element) => e.id == element.id);
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

          for (Verse item in widget.verses) {
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
          margin: const EdgeInsets.symmetric(horizontal: 17),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          child: Center(
            child: icon(),
          ),
        ),
      );
    }

    return SliverAppBar(
      expandedHeight: 250,
      stretch: true,
      floating: false,
      pinned: true,
      automaticallyImplyLeading: false,
      leadingWidth: 56 + kDefaultPadding,
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      leading: Container(
        padding: const EdgeInsets.all(7),
        child: CantonPrimaryButton(
          color: Theme.of(context).colorScheme.onBackground,
          containerHeight: 45.0,
          containerWidth: 45.0,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          iconPadding: 0,
          prefixIcon: Icon(
            FeatherIcons.arrowLeft,
            color: Theme.of(context).colorScheme.primary,
          ),
          alignment: MainAxisAlignment.center,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      actions: [
        _favoriteButton(context),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: _buildImage(context),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
          child: Text(
            'Verse of the Day',
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: CantonColors.white,
                  fontSize: 17,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Image.asset(
      ref.watch(localUserRepositoryProvider).getNatureImage,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }

  Widget _body(BuildContext context) {
    Widget _bookChapterVerse(BuildContext context) {
      String versesString() {
        var str = '';
        if (widget.verses.length > 1) {
          str = widget.verses.first.verseId.toString() + ' - ' + widget.verses.last.verseId.toString();
        } else {
          str = widget.verses[0].verseId.toString();
        }

        return str;
      }

      return SelectableText(
        widget.verses[0].book.name! + ' ' + widget.verses[0].chapterId.toString() + ':' + versesString(),
        style: Theme.of(context).textTheme.headline6?.copyWith(
              fontWeight: FontWeight.w500,
              height: ref.watch(readerSettingsRepositoryProvider.notifier).bodyTextHeight,
              fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
            ),
      );
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27.0),
        child: Column(
          children: [
            const SizedBox(height: kDefaultPadding),
            for (var verse in widget.verses)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: SelectableText.rich(
                  TextSpan(
                    text: verse.verseId.toString() + ' ',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          fontSize: ref.watch(readerSettingsRepositoryProvider).verseNumberSize * 1.5,
                          height: ref.watch(readerSettingsRepositoryProvider).verseNumberHeight,
                          fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
                        ),
                    children: [
                      TextSpan(
                        text: (verse.text + (widget.verses.last == verse ? '' : ' ')),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: ref.watch(readerSettingsRepositoryProvider.notifier).bodyTextSize * 1.5,
                              height: ref.watch(readerSettingsRepositoryProvider.notifier).bodyTextHeight,
                              fontFamily: ref.watch(readerSettingsRepositoryProvider).typeFace,
                            ),
                      ),
                    ],
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                ),
              ),
            const SizedBox(height: kDefaultPadding),
            _bookChapterVerse(context),
            const SizedBox(height: kDefaultPadding * 3),
            Container(
              padding: const EdgeInsets.only(bottom: 10)
            ),
          ],
        ),
      ),
    );
  }
}
