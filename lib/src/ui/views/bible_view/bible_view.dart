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

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:canton_ui/canton_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'package:elisha/src/config/exceptions.dart';
import 'package:elisha/src/models/book.dart';
import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/models/translation.dart';
import 'package:elisha/src/providers/bible_books_provider.dart';
import 'package:elisha/src/providers/bible_chapters_provider.dart';
import 'package:elisha/src/providers/bible_repository_provider.dart';
import 'package:elisha/src/providers/bible_translations_provider.dart';
import 'package:elisha/src/providers/last_translation_book_chapter_provider.dart';
import 'package:elisha/src/providers/reader_settings_repository_provider.dart';
import 'package:elisha/src/providers/study_tools_repository_provider.dart';
import 'package:elisha/src/services/bible_service.dart';
import 'package:elisha/src/ui/components/bible_reader.dart';
import 'package:elisha/src/ui/components/error_body.dart';
import 'package:elisha/src/ui/components/unexpected_error.dart';
import 'package:elisha/src/repositories/bible_repository.dart';

class BibleView extends ConsumerStatefulWidget {
  const BibleView({Key? key}) : super(key: key);

  @override
  _BibleViewState createState() => _BibleViewState();
}

class _BibleViewState extends ConsumerState<BibleView> {
  var _isBookmarked = false;
  final _scrollController = ScrollController();
  final _autoScrollController = AutoScrollController();

  @override
  Widget build(BuildContext context) {
    final translations = ref.watch(bibleTranslationsProvider);
    final booksRepo = ref.watch(bibleBooksProvider);
    final chaptersRepo = ref.watch(bibleChaptersProvider);

    translations.sort((a, b) => a.id!.compareTo(b.id!));

    return booksRepo.when(
      error: (e, s) {
        if (e is Exceptions) {
          return ErrorBody(e.message, bibleBooksProvider);
        }
        return UnexpectedError(bibleBooksProvider);
      },
      loading: () => Container(),
      data: (books) {
        return chaptersRepo.when(
          error: (e, s) {
            if (e is Exceptions) {
              return ErrorBody(e.message, bibleChaptersProvider);
            }
            return UnexpectedError(bibleChaptersProvider);
          },
          loading: () => Container(),
          data: (chapter) {
            _isBookmarked = _isBookmarked = ref
                .watch(studyToolsRepositoryProvider)
                .bookmarkedChapters
                .where((e) => e.id == chapter.id && e.verses![0].book.id == chapter.verses![0].book.id)
                .isNotEmpty;

            final kChapter = chapter.copyWith(verses: [
              for (var item in chapter.verses!) item.copyWith(text: item.text.replaceAll('\\"', '"')),
            ]);

            return Responsive(
              tablet: _buildTabletContent(context, ref, translations, books, kChapter),
              mobile: _buildMobileContent(context, ref, translations, books, kChapter),
            );
          },
        );
      },
    );
  }

  Widget _buildMobileContent(
    BuildContext context,
    WidgetRef ref,
    List<Translation> translations,
    List<Book> books,
    Chapter chapter,
  ) {
    Widget reader() {
      return SliverToBoxAdapter(
        child: BibleReader(chapter: chapter, scrollController: _scrollController),
      );
    }

    return Scrollbar(
      controller: _scrollController,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [_buildMobileHeader(context, ref, translations, books, chapter), reader()],
      ),
    );
  }

  Widget _buildTabletContent(
    BuildContext context,
    WidgetRef ref,
    List<Translation> translations,
    List<Book> books,
    Chapter chapter,
  ) {
    Widget reader() {
      return SliverToBoxAdapter(
        child: BibleReader(chapter: chapter, scrollController: _scrollController),
      );
    }

    return Scrollbar(
      controller: _scrollController,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [_buildTabletHeader(context, ref, translations, books, chapter), reader()],
      ),
    );
  }

  Widget _buildMobileHeader(
    BuildContext context,
    WidgetRef ref,
    List<Translation> translations,
    List<Book> books,
    Chapter chapter,
  ) {
    Widget _previousChapterButton() {
      return GestureDetector(
        onTap: () async {
          HapticFeedback.lightImpact();

          await ref.read(bibleRepositoryProvider).goToNextPreviousChapter(ref, true);
          _scrollController.jumpTo(0.0);
        },
        child: Icon(
          FeatherIcons.chevronLeft,
          size: 27,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    Widget _nextChapterButton() {
      return GestureDetector(
        onTap: () async {
          HapticFeedback.lightImpact();

          await ref.read(bibleRepositoryProvider).goToNextPreviousChapter(ref, false);
          _scrollController.jumpTo(0.0);
        },
        child: Icon(
          FeatherIcons.chevronRight,
          size: 27,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    Widget _bookmarkButton(Chapter chapter) {
      return CantonActionButton(
        onPressed: () async {
          HapticFeedback.lightImpact();

          setState(() {
            _isBookmarked = !_isBookmarked;
          });

          if (_isBookmarked) {
            await ref.read(studyToolsRepositoryProvider.notifier).addBookmarkChapter(chapter);
          } else {
            await ref.read(studyToolsRepositoryProvider.notifier).removeBookmarkChapter(chapter);
          }
        },
        icon: Icon(
          _isBookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
          size: 24,
          color: _isBookmarked ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.primary,
        ),
      );
    }

    Widget _readerSettingsButton() {
      return CantonActionButton(
        onPressed: () async {
          HapticFeedback.lightImpact();

          await _showReaderSettingsBottomSheet();
        },
        icon: Icon(
          FeatherIcons.settings,
          size: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    Widget _translationControls(String bookChapterTitle, List<Translation> translations) {
      return Row(
        children: [
          GestureDetector(
            onTap: () async {
              HapticFeedback.lightImpact();

              await _showBookAndChapterBottomSheet(BibleRepository().getBookId(bookChapterTitle));
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
                color: Theme.of(context).inputDecorationTheme.fillColor,
              ),
              child: Text(
                bookChapterTitle,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 2),
          GestureDetector(
            onTap: () async {
              HapticFeedback.lightImpact();

              await _showTranslationsBottomSheet(context, translations);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
                color: Theme.of(context).inputDecorationTheme.fillColor,
              ),
              child: Text(
                translations[int.parse(translationID)].abbreviation!.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      );
    }

    Widget _chapterVerseTranslationControls(List<Translation> translations, List<Book> books, Chapter chapter) {
      var bookChapterTitle = chapter.verses![0].book.name! + ' ' + chapter.number!;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _previousChapterButton(),
          const Spacer(),
          _readerSettingsButton(),
          const Spacer(),
          _translationControls(bookChapterTitle, translations),
          const Spacer(),
          _bookmarkButton(chapter),
          const Spacer(),
          _nextChapterButton(),
        ],
      );
    }

    return SliverAppBar(
      centerTitle: true,
      floating: true,
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      title: _chapterVerseTranslationControls(translations, books, chapter),
    );
  }

  Widget _buildTabletHeader(
    BuildContext context,
    WidgetRef ref,
    List<Translation> translations,
    List<Book> books,
    Chapter chapter,
  ) {
    Widget _previousChapterButton() {
      return GestureDetector(
        onTap: () async {
          HapticFeedback.lightImpact();

          await ref.read(bibleRepositoryProvider).goToNextPreviousChapter(ref, true);
          _scrollController.jumpTo(0.0);
        },
        child: Icon(
          FeatherIcons.chevronLeft,
          size: 34,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    Widget _nextChapterButton() {
      return GestureDetector(
        onTap: () async {
          HapticFeedback.lightImpact();

          await ref.read(bibleRepositoryProvider).goToNextPreviousChapter(ref, false);
          _scrollController.jumpTo(0.0);
        },
        child: Icon(
          FeatherIcons.chevronRight,
          size: 34,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    Widget _bookmarkButton(Chapter chapter) {
      return CantonActionButton(
        onPressed: () async {
          HapticFeedback.lightImpact();

          setState(() {
            _isBookmarked = !_isBookmarked;
          });

          if (_isBookmarked) {
            await ref.read(studyToolsRepositoryProvider.notifier).addBookmarkChapter(chapter);
          } else {
            await ref.read(studyToolsRepositoryProvider.notifier).removeBookmarkChapter(chapter);
          }
        },
        icon: Icon(
          _isBookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
          size: 28,
          color: _isBookmarked ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.primary,
        ),
      );
    }

    Widget _readerSettingsButton() {
      return CantonActionButton(
        onPressed: () async {
          HapticFeedback.lightImpact();

          await _showReaderSettingsBottomSheet();
        },
        icon: Icon(
          FeatherIcons.settings,
          size: 28,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    Widget _translationControls(String bookChapterTitle, List<Translation> translations) {
      return Row(
        children: [
          GestureDetector(
            onTap: () async {
              HapticFeedback.lightImpact();

              await _showBookAndChapterBottomSheet(BibleRepository().getBookId(bookChapterTitle));
            },
            child: Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
                color: Theme.of(context).inputDecorationTheme.fillColor,
              ),
              child: Text(
                bookChapterTitle,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      height: 1.3,
                    ),
              ),
            ),
          ),
          const SizedBox(width: 2),
          GestureDetector(
            onTap: () async {
              HapticFeedback.lightImpact();

              await _showTranslationsBottomSheet(context, translations);
            },
            child: Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
                color: Theme.of(context).inputDecorationTheme.fillColor,
              ),
              child: Text(
                translations[int.parse(translationID)].abbreviation!.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      height: 1.3,
                    ),
              ),
            ),
          ),
        ],
      );
    }

    Widget _chapterVerseTranslationControls(List<Translation> translations, List<Book> books, Chapter chapter) {
      var bookChapterTitle = chapter.verses![0].book.name! + ' ' + chapter.number!;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _previousChapterButton(),
          const Spacer(),
          _readerSettingsButton(),
          const Spacer(),
          _translationControls(bookChapterTitle, translations),
          const Spacer(),
          _bookmarkButton(chapter),
          const Spacer(),
          _nextChapterButton(),
        ],
      );
    }

    return SliverAppBar(
      centerTitle: true,
      floating: true,
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      title: _chapterVerseTranslationControls(translations, books, chapter),
    );
  }

  Future<void> _showReaderSettingsBottomSheet() async {
    var screenBrightness = await ScreenBrightness().system;

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
          heightFactor: 0.6,
          widthFactor: Responsive.isTablet(context) ? 0.75 : null,
          child: StatefulBuilder(
            builder: (context, setState) {
              Widget brightnessControls = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(CupertinoIcons.sun_min_fill, size: 27),
                    Expanded(
                      child: Slider(
                        value: screenBrightness,
                        onChanged: (val) async {
                          await ScreenBrightness().setScreenBrightness(val);
                          setState(() => screenBrightness = val);
                        },
                      ),
                    ),
                    const Icon(CupertinoIcons.sun_max_fill, size: 34),
                  ],
                ),
              );

              Widget textSizeControls = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Text Size', style: Theme.of(context).textTheme.headline5),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await ref.read(readerSettingsRepositoryProvider).decrementBodyTextSize();
                        await ref.read(readerSettingsRepositoryProvider).decrementVerseNumberSize();
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          'A',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                                fontSize: 16,
                                height: 1.25,
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        await ref.read(readerSettingsRepositoryProvider).incrementBodyTextSize();
                        await ref.read(readerSettingsRepositoryProvider).incrementVerseNumberSize();
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          'A',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                                fontSize: 24,
                                height: 1.25,
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              );

              Widget fontControls = CantonExpansionTile(
                childrenPadding: EdgeInsets.zero,
                iconColor: Theme.of(context).colorScheme.primary,
                title: Text(
                  ref.watch(readerSettingsRepositoryProvider).typeFace,
                  style: Theme.of(context).textTheme.headline5,
                ),
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await ref.read(readerSettingsRepositoryProvider).setTypeFace('New York');
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'New York',
                            style: Theme.of(context).textTheme.headline4?.copyWith(
                                  fontFamily: 'New York',
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 17),
                      GestureDetector(
                        onTap: () async {
                          await ref.read(readerSettingsRepositoryProvider).setTypeFace('Inter');
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Inter',
                            style: Theme.of(context).textTheme.headline4?.copyWith(
                                  fontFamily: 'Inter',
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );

              Widget lineHeightControls = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Line Spacing', style: Theme.of(context).textTheme.headline5),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await ref.read(readerSettingsRepositoryProvider).decrementBodyTextHeight();
                        await ref.read(readerSettingsRepositoryProvider).decrementVerseNumberHeight();
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.format_line_spacing,
                            color: Theme.of(context).colorScheme.onBackground, size: 16),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        await ref.read(readerSettingsRepositoryProvider).incrementBodyTextHeight();
                        await ref.read(readerSettingsRepositoryProvider).incrementVerseNumberHeight();
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.format_line_spacing,
                            color: Theme.of(context).colorScheme.onBackground, size: 26),
                      ),
                    ),
                  ],
                ),
              );

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    brightnessControls,
                    const Divider(height: 34),
                    textSizeControls,
                    const SizedBox(height: 17),
                    const Divider(),
                    const SizedBox(height: 5),
                    fontControls,
                    const Divider(height: 17),
                    const SizedBox(height: 8.5),
                    lineHeightControls,
                    const Divider(height: 34),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _showBookAndChapterBottomSheet(int bookId) async {
    List<Book> books = await BibleService().getBooks('');

    Widget _bookCard(Book book) {
      Widget _chapterCard(ChapterId chapter) {
        return GestureDetector(
          onTap: () async {
            HapticFeedback.lightImpact();
            await ref.read(bibleRepositoryProvider).changeChapter(ref, book.id!, chapter.id!);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.secondaryContainer, width: 0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                chapter.id.toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        );
      }

      return CantonExpansionTile(
        childrenPadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Text(book.name!, style: Theme.of(context).textTheme.headline6),
        iconColor: Theme.of(context).colorScheme.primary,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: book.chapters!.length,
              itemBuilder: (context, index) => _chapterCard(book.chapters![index]),
            ),
          ),
        ],
      );
    }

    _autoScrollController.scrollToIndex(bookId-1,
        duration: const Duration(milliseconds: 10),
        preferPosition: AutoScrollPosition.begin);

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
          heightFactor: 0.95,
          widthFactor: Responsive.isTablet(context) ? 0.75 : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Books',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 7),
              Expanded(
                child: ListView.separated(
                  itemCount: books.length,
                  controller: _autoScrollController,
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Divider(),
                    );
                  },
                  itemBuilder: (context, index) {
                    return AutoScrollTag(
                      controller: _autoScrollController,
                      index: index,
                      key: ValueKey(index),
                      child: Column(
                        children: [
                          if (index == 0)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Divider(),
                            ),
                          _bookCard(books[index]),
                          if (index == 0)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Divider(),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showTranslationsBottomSheet(BuildContext context, List<Translation> translations) async {
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
          heightFactor: 0.75,
          widthFactor: Responsive.isTablet(context) ? 0.75 : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Versions',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 7),
              Expanded(
                child: ListView.separated(
                  itemCount: translations.length,
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Responsive.isTablet(context) ? const Divider(height: 10) : const Divider(),
                    );
                  },
                  itemBuilder: (context, index) {
                    var translation = translations[index];
                    Widget _translationCard() {
                      return GestureDetector(
                        onTap: () async {
                          await ref.read(localRepositoryProvider.notifier).changeBibleTranslation(
                                index,
                                translation.abbreviation!.toLowerCase(),
                              );

                          ref.refresh(bibleChaptersProvider);
                          setState(() {});

                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 24),
                          title: Text(
                            translation.name!,
                            style: Theme.of(context).textTheme.headline6?.copyWith(
                                  fontSize: Responsive.isTablet(context) ? 21 : null,
                                ),
                          ),
                          trailing: Text(
                            translation.abbreviation!.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                  color: Theme.of(context).colorScheme.secondaryContainer,
                                  fontSize: Responsive.isTablet(context) ? 18 : null,
                                ),
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        if (index == 0)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Divider(),
                          ),
                        _translationCard(),
                        if (index == translations.length - 1)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Divider(),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
