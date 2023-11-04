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
import 'package:elisha/src/ui/components/bible_reader.dart';
import 'package:elisha/src/ui/views/bookmarked_chapter_view/components/bookmarked_chapter_view_header.dart';

class BookmarkedChapterView extends ConsumerStatefulWidget {
  const BookmarkedChapterView(this.chapter, {Key? key}) : super(key: key);

  final Chapter chapter;

  @override
  _BookmarkedChapterViewState createState() => _BookmarkedChapterViewState();
}

class _BookmarkedChapterViewState extends ConsumerState<BookmarkedChapterView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      padding: EdgeInsets.zero,
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    var scrollController = ScrollController();
    return Column(
      children: [
        BookmarkedChapterViewHeader(chapter: widget.chapter, showBottomSheet: _showBookmarkedChapterOptionsBottomSheet),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: BibleReader(chapter: widget.chapter, scrollController: scrollController),
          ),
        ),
      ],
    );
  }

  void _showBookmarkedChapterOptionsBottomSheet(Chapter chapter) async {
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
                                color: Theme.of(context).colorScheme.secondaryContainer,
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
                        buttonText: 'Remove Bookmark',
                        color: Theme.of(context).colorScheme.secondary,
                        textColor: Theme.of(context).colorScheme.error,
                        onPressed: () async {
                          await ref.read(studyToolsRepositoryProvider.notifier).removeBookmarkChapter(chapter);
                          Navigator.pop(context);
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
