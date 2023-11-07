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

class BookmarkedChapterViewHeader extends ConsumerWidget {
  const BookmarkedChapterViewHeader({required this.chapter, required this.showBottomSheet, Key? key}) : super(key: key);

  final void Function(Chapter) showBottomSheet;
  final Chapter chapter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String name() {
      return chapter.verses![0].book.name! + ' ' + chapter.number!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ViewHeaderTwo(
        title: name(),
        backButton: true,
        buttonTwo: CantonHeaderButton(
          onPressed: () {
            showBottomSheet(chapter);
          },
          icon: Icon(
            Iconsax.more,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
