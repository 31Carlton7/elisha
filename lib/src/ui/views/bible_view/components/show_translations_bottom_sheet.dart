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

import 'package:elisha/src/models/translation.dart';
import 'package:elisha/src/ui/views/bible_view/components/translation_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showTranslationsBottomSheet(
  BuildContext context,
  WidgetRef ref,
  List<Translation> translations,
  void Function(void Function()) setState,
) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    elevation: 0,
    useRootNavigator: true,
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
                  return Responsive.isTablet(context) ? const SizedBox(height: 10) : Container();
                },
                itemBuilder: (context, index) {
                  return TranslationCard(
                    translation: translations[index],
                    index: index + 1,
                    setState: setState,
                    ref: ref,
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
