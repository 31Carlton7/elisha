import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/models/chapter.dart';

class BookmarkedChapterViewHeader extends StatelessWidget {
  const BookmarkedChapterViewHeader({required this.chapter, required this.showBottomSheet, Key? key}) : super(key: key);

  final void Function(Chapter) showBottomSheet;
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    String name() {
      return chapter.verses![0].book!.name! + ' ' + chapter.number!;
    }

    return ViewHeaderTwo(
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
    );
  }
}
