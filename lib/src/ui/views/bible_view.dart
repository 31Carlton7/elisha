import 'package:canton_design_system/canton_design_system.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/config/exceptions.dart';
import 'package:elisha/src/models/book.dart';
import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/models/translation.dart';
import 'package:elisha/src/services/bible_service.dart';
import 'package:elisha/src/ui/components/error_body.dart';
import 'package:elisha/src/ui/components/unexpected_error.dart';
import 'package:elisha/src/ui/providers/bible_books_provider.dart';
import 'package:elisha/src/ui/providers/bible_chapters_provider.dart';
import 'package:elisha/src/ui/providers/bible_repository_provider.dart';
import 'package:elisha/src/ui/providers/bible_translations_provider.dart';
import 'package:elisha/src/ui/providers/bookmarked_chapters_provider.dart';
import 'package:elisha/src/ui/providers/last_translation_book_chapter_provider.dart';

class BibleView extends StatefulWidget {
  const BibleView();

  @override
  _BibleViewState createState() => _BibleViewState();
}

class _BibleViewState extends State<BibleView> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final translationRepo = watch(bibleTranslationsProvider);
        final booksRepo = watch(bibleBooksProvider);
        final chaptersRepo = watch(bibleChaptersProvider);

        return translationRepo.when(
          error: (e, s) {
            if (e is Exceptions) {
              return ErrorBody(e.message, bibleTranslationsProvider);
            }
            return UnexpectedError(bibleTranslationsProvider);
          },
          loading: () => Container(),
          data: (translations) {
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
                    isBookmarked = context
                        .read(bookmarkedChaptersProvider)
                        .contains(chapter);
                    return _content(
                      context,
                      translations,
                      books,
                      chapter,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _content(BuildContext context, List<Translation> translations,
      List<Book> books, Chapter chapter) {
    List<Widget> children = [];
    List<InlineSpan> spans = [];
    children.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Text.rich(
          TextSpan(
            children: spans,
          ),
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w400,
                height: 1.85,
              ),
        ),
      ),
    );
    for (int i = 0; i < chapter.verses!.length; i++) {
      var item = chapter.verses![i];

      spans.add(
        TextSpan(
          text: item.verseId!.toString() + ' ',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
      );

      spans.add(TextSpan(text: item.text!));

      if (!(i == chapter.verses!.length - 1)) {
        spans.add(TextSpan(text: ' '));
      }
    }
    return Column(
      children: [
        _header(context, translations, books, chapter),
        SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context, List<Translation> translations,
      List<Book> books, Chapter chapter) {
    Widget _quickChapterNavigationControls(BuildContext context) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              context
                  .read(bibleRepositoryProvider)
                  .goToNextPreviousChapter(context, true);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: IconlyIcon(
                IconlyBold.ArrowLeft1,
                size: 20,
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
            ),
          ),
          SizedBox(width: 7),
          GestureDetector(
            onTap: () {
              context
                  .read(bibleRepositoryProvider)
                  .goToNextPreviousChapter(context, false);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: IconlyIcon(
                IconlyBold.ArrowRight1,
                size: 20,
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
            ),
          ),
        ],
      );
    }

    Widget _chapterVerseTranslationControls(BuildContext context,
        List<Translation> translations, List<Book> books, Chapter chapter) {
      var bookChapterTitle =
          chapter.verses![0].book!.name! + ' ' + chapter.number!;
      return Row(
        children: [
          GestureDetector(
            onTap: () async {
              _showBookAndChapterBottomSheet();
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: ShapeDecoration(
                shape: SquircleBorder(
                  radius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                  ),
                ),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                bookChapterTitle,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          SizedBox(width: 2),
          GestureDetector(
            onTap: () {
              _showTranslationsBottomSheet(translations);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: ShapeDecoration(
                shape: SquircleBorder(
                  radius: const BorderRadius.horizontal(
                    right: const Radius.circular(20),
                  ),
                ),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                translations[int.parse(translationID)].abbreviation!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      );
    }

    Widget _bookmarkButton(BuildContext context) {
      return GestureDetector(
        onTap: () {
          if (isBookmarked == false) {
            context
                .read(bookmarkedChaptersProvider.notifier)
                .bookmarkChapter(chapter);
          } else {
            context
                .read(bookmarkedChaptersProvider.notifier)
                .removeChapter(chapter);
          }
          setState(() {
            isBookmarked = !isBookmarked;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            shape: BoxShape.circle,
          ),
          child: IconlyIcon(
            IconlyBold.Bookmark,
            size: 20,
            color: isBookmarked
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.secondaryVariant,
          ),
        ),
      );
    }

    return Row(
      children: [
        _bookmarkButton(context),
        Spacer(flex: 9),
        _chapterVerseTranslationControls(context, translations, books, chapter),
        Spacer(flex: 5),
        _quickChapterNavigationControls(context),
      ],
    );
  }

  Future<void> _showBookAndChapterBottomSheet() async {
    List<Book> books = await BibleService(Dio()).getBooks('');

    Widget _bookCard(Book book) {
      Widget _chapterCard(ChapterId chapter) {
        return GestureDetector(
          onTap: () {
            context
                .read(bibleRepositoryProvider)
                .changeChapter(context, book.id!, chapter.id!);

            Navigator.pop(context);
          },
          child: Container(
            decoration: ShapeDecoration(
              shape: SquircleBorder(
                radius: BorderRadius.circular(20),
                side: BorderSide(
                  width: 1.5,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            child: Center(
              child: Text(
                chapter.id.toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        );
      }

      return CantonExpansionTile(
        childrenPadding: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 17,
        ),
        title: Container(
          child: Text(
            book.name!,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: book.chapters!.length,
              itemBuilder: (context, index) {
                return _chapterCard(book.chapters![index]);
              },
            ),
          ),
        ],
      );
    }

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.95,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15, left: 27, right: 27),
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 27),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryVariant,
                            ),
                      ),
                    ),
                    Spacer(flex: 6),
                    Text(
                      'Versions',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(flex: 9),
                  ],
                ),
              ),
              SizedBox(height: 7),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        _bookCard(books[index]),
                        Divider(),
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

  Future<void> _showTranslationsBottomSheet(
      List<Translation> translations) async {
    Widget _translationCard(Translation translation, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            context
                .read(localRepositoryProvider.notifier)
                .changeBibleTranslation(
                  index - 1,
                  translation.abbreviation!,
                );

            context.refresh(bibleChaptersProvider);
          });

          Navigator.pop(context);
        },
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 3, horizontal: 17),
          title: Text(
            translation.name!,
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: Text(
            translation.abbreviation!,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
          ),
        ),
      );
    }

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      builder: (context) {
        return Container(
          child: FractionallySizedBox(
            heightFactor: 0.95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 27, right: 27),
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 27),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant,
                                  ),
                        ),
                      ),
                      Spacer(flex: 6),
                      Text(
                        'Versions',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Spacer(flex: 9),
                    ],
                  ),
                ),
                SizedBox(height: 7),
                Expanded(
                  child: ListView.builder(
                    itemCount: translations.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (index == 0) Divider(),
                          _translationCard(translations[index], index + 1),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
