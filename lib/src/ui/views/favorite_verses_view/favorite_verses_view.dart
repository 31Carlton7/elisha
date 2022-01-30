import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/study_tools_repository_provider.dart';
import 'package:elisha/src/ui/views/favorite_verses_view/components/favorite_verse_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elisha/src/ui/views/favorite_verses_view/components/favorite_verses_view_header.dart';

class FavoriteVersesView extends StatefulWidget {
  const FavoriteVersesView({Key? key}) : super(key: key);

  @override
  State<FavoriteVersesView> createState() => _FavoriteVersesViewState();
}

class _FavoriteVersesViewState extends State<FavoriteVersesView> {
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
    return Consumer(
      builder: (context, watch, child) {
        final list = watch(studyToolsRepositoryProvider).favoriteVerses.reversed.toList();

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
                          color: Theme.of(context).colorScheme.secondaryVariant,
                        ),
                  ),
                ),
        );
      },
    );
  }
}
