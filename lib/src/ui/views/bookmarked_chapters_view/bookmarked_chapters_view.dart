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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/providers/study_tools_repository_provider.dart';
import 'package:elisha/src/ui/views/bookmarked_chapters_view/components/bookmarked_chapter_card.dart';
import 'package:elisha/src/ui/views/bookmarked_chapters_view/components/bookmarked_chapters_view_header.dart';

class BookmarkedChaptersView extends ConsumerStatefulWidget {
  const BookmarkedChaptersView({Key? key}) : super(key: key);

  @override
  _BookmarkedChaptersViewState createState() => _BookmarkedChaptersViewState();
}

class _BookmarkedChaptersViewState extends ConsumerState<BookmarkedChaptersView> {
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
        const BookmarkedChaptersViewHeader(),
        _bookmarkedChapters(context),
      ],
    );
  }

  Widget _bookmarkedChapters(BuildContext context) {
    return Expanded(
      child: ref.watch(studyToolsRepositoryProvider).bookmarkedChapters.isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: ListView.separated(
                  itemCount: ref.watch(studyToolsRepositoryProvider).bookmarkedChapters.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        BookmarkedChapterCard(
                          chapter: ref.watch(studyToolsRepositoryProvider).bookmarkedChapters[index],
                          setState: setState,
                          showBookmarkedChapterOptionsBottomSheet: _showBookmarkedChapterOptionsBottomSheet,
                        ),
                        if (index == ref.watch(studyToolsRepositoryProvider).bookmarkedChapters.length - 1)
                          const Divider(),
                      ],
                    );
                  },
                ),
              ),
            )
          : Center(
              child: Text(
                'No Bookmarked Chapters',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.secondaryContainer,
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 15),
          child: FractionallySizedBox(
            heightFactor: 0.35,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 27, right: 27),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Options',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 27, right: 27),
                  child: Column(
                    children: [
                      CantonPrimaryButton(
                        buttonText: 'Remove Bookmark',
                        color: Theme.of(context).colorScheme.secondary,
                        textColor: Theme.of(context).colorScheme.error,
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          await ref.read(studyToolsRepositoryProvider.notifier).removeBookmarkChapter(chapter);
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
