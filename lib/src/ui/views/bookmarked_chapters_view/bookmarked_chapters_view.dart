/*
Elisha iOS & Android App
Copyright (C) 2021 Elisha

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

import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/providers/bookmarked_chapters_provider.dart';
import 'package:elisha/src/ui/views/bookmarked_chapter_view/bookmarked_chapter_view.dart';

class BookmarkedChaptersView extends StatefulWidget {
  const BookmarkedChaptersView({Key? key}) : super(key: key);

  @override
  _BookmarkedChaptersViewState createState() => _BookmarkedChaptersViewState();
}

class _BookmarkedChaptersViewState extends State<BookmarkedChaptersView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
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
      padding: const EdgeInsets.only(top: 17, left: 17, right: 17),
      child: const ViewHeaderTwo(
        title: 'Bookmarks',
        backButton: true,
      ),
    );
  }

  Widget _bookmarkedChapters(BuildContext context) {
    return Expanded(
      child: context.read(bookmarkedChaptersProvider).isNotEmpty
          ? ListView.separated(
              itemCount: context.read(bookmarkedChaptersProvider).length,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    if (index == 0) const Divider(),
                    _bookmarkedChapterCard(
                      context,
                      context.read(bookmarkedChaptersProvider)[index],
                    ),
                    if (index == context.read(bookmarkedChaptersProvider).length - 1) const Divider(),
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
      return chapter.verses![0].book.name! +
          ' ' +
          chapter.number!.toString() +
          ' ' +
          chapter.translation!.toUpperCase();
    }

    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, BookmarkedChapterView(chapter)).then((value) => setState(() {}));
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
          child: Icon(
            Iconsax.more,
            color: Theme.of(context).colorScheme.primary,
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
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                                color: Theme.of(context).colorScheme.secondaryVariant,
                              ),
                        ),
                      ),
                      const Spacer(flex: 7),
                      Text(
                        'Options',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const Spacer(flex: 10),
                    ],
                  ),
                ),
                const Divider(height: 30),
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 27, right: 27),
                  child: Column(
                    children: [
                      CantonPrimaryButton(
                        buttonText: 'Remove',
                        color: Theme.of(context).colorScheme.onError,
                        textColor: Theme.of(context).colorScheme.error,
                        onPressed: () {
                          context.read(bookmarkedChaptersProvider.notifier).removeChapter(chapter);
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
