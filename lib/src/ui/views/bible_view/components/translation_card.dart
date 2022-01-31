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

import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/translation.dart';
import 'package:elisha/src/providers/bible_chapters_provider.dart';
import 'package:elisha/src/providers/last_translation_book_chapter_provider.dart';

class TranslationCard extends StatelessWidget {
  const TranslationCard({Key? key, required this.setState, required this.index, required this.translation})
      : super(key: key);

  final void Function(void Function()) setState;
  final int index;
  final Translation translation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          context.read(localRepositoryProvider.notifier).changeBibleTranslation(
                index - 1,
                translation.abbreviation!,
              );

          context.refresh(bibleChaptersProvider);
        });

        Navigator.of(context, rootNavigator: true).pop();
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 17),
        title: Text(
          translation.name!,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontSize: Responsive.isTablet(context) ? 21 : null,
              ),
        ),
        trailing: Text(
          translation.abbreviation!.toUpperCase(),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
                fontSize: Responsive.isTablet(context) ? 18 : null,
              ),
        ),
      ),
    );
  }
}
