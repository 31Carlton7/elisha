import 'package:canton_design_system/canton_design_system.dart';

import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/ui/views/bookmarked_chapter_view/bookmarked_chapter_view.dart';

class BookmarkedChapterCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
