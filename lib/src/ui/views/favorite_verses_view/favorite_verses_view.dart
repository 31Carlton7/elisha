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

import 'package:elisha/src/providers/study_tools_repository_provider.dart';
import 'package:elisha/src/ui/views/favorite_verses_view/components/favorite_verse_card.dart';
import 'package:elisha/src/ui/views/favorite_verses_view/components/favorite_verses_view_header.dart';

class FavoriteVersesView extends ConsumerStatefulWidget {
  const FavoriteVersesView({Key? key}) : super(key: key);

  @override
  ConsumerState<FavoriteVersesView> createState() => _FavoriteVersesViewState();
}

class _FavoriteVersesViewState extends ConsumerState<FavoriteVersesView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        const FavoriteVersesViewHeader(),
        _favoriteVerses(context),
      ],
    );
  }

  Widget _favoriteVerses(BuildContext context) {
    final list = ref.watch(studyToolsRepositoryProvider).favoriteVerses.reversed.toList();

    return Expanded(
      child: list.isNotEmpty
          ? ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: ListView.separated(
                itemCount: list.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      FavoriteVerseCard(verse: list[index]),
                      if (index == list.length - 1) const Divider(),
                    ],
                  );
                },
              ),
            )
          : Center(
              child: Text(
                'No Favorite Verses',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
              ),
            ),
    );
  }
}
