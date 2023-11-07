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
import 'package:elisha/src/ui/views/bookmarked_chapter_view/bookmarked_chapter_view.dart';

class BookmarkedChapterCard extends ConsumerWidget {
  const BookmarkedChapterCard({
    Key? key,
    required this.chapter,
    required this.setState,
    required this.showBookmarkedChapterOptionsBottomSheet,
  }) : super(key: key);

  final Chapter chapter;
  final void Function(void Function()) setState;
  final Future<void> Function(Chapter) showBookmarkedChapterOptionsBottomSheet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String cardTitle() {
      return chapter.verses![0].book.name! + ' ' + chapter.number!.toString();
    }

    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, BookmarkedChapterView(chapter)).then((value) => setState(() {}));
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 17),
        leading: Text(
          cardTitle(),
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: GestureDetector(
          onTap: () async {
            await showBookmarkedChapterOptionsBottomSheet(chapter);
          },
          child: Icon(
            Iconsax.more,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
