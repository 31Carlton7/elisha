import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/ui/providers/bookmarked_chapters_provider.dart';
import 'package:elisha/src/ui/views/bookmarked_chapter_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkedChaptersView extends StatefulWidget {
  const BookmarkedChaptersView();

  @override
  _BookmarkedChaptersViewState createState() => _BookmarkedChaptersViewState();
}

class _BookmarkedChaptersViewState extends State<BookmarkedChaptersView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      padding: EdgeInsets.zero,
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        _header(),
        _bookmarkedChapters(context),
      ],
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.only(top: 17, left: 17, right: 17),
      child: ViewHeaderTwo(
        title: 'Bookmarks',
        backButton: true,
      ),
    );
  }

  Widget _bookmarkedChapters(BuildContext context) {
    return Expanded(
      child: context.read(bookmarkedChaptersProvider).length > 0
          ? ListView.separated(
              itemCount: context.read(bookmarkedChaptersProvider).length,
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    if (index == 0) Divider(),
                    _bookmarkedChapterCard(
                      context,
                      context.read(bookmarkedChaptersProvider)[index],
                    ),
                    if (index ==
                        context.read(bookmarkedChaptersProvider).length - 1)
                      Divider(),
                  ],
                );
              },
            )
          : Text(
              'No Bookmarked Chapters',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
            ),
    );
  }

  Widget _bookmarkedChapterCard(BuildContext context, Chapter chapter) {
    String cardTitle() {
      return chapter.verses![0].book!.name! +
          ' ' +
          chapter.number!.toString() +
          ' ' +
          chapter.translation!.toUpperCase();
    }

    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, BookmarkedChapterView(chapter))
            .then((value) => setState(() {}));
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 27),
        leading: Text(
          cardTitle(),
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: GestureDetector(
          onTap: () {
            _showBookmarkedChapterOptionsBottomSheet(chapter);
          },
          child: Container(
            child: IconlyIcon(
              IconlyBold.MoreCircle,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showBookmarkedChapterOptionsBottomSheet(Chapter chapter) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 15),
          child: FractionallySizedBox(
            heightFactor: 0.35,
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 27, right: 27),
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
                      Spacer(flex: 7),
                      Text(
                        'Options',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Spacer(flex: 10),
                    ],
                  ),
                ),
                Divider(height: 30),
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 27, right: 27),
                  child: Column(
                    children: [
                      CantonPrimaryButton(
                        buttonText: 'Remove',
                        containerColor: Theme.of(context).colorScheme.onError,
                        textColor: Theme.of(context).colorScheme.error,
                        onPressed: () {
                          context
                              .read(bookmarkedChaptersProvider.notifier)
                              .removeChapter(chapter);
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ],
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
