import 'package:canton_design_system/canton_design_system.dart';

class BookmarkedChaptersViewHeader extends StatelessWidget {
  const BookmarkedChaptersViewHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 17, left: 17, right: 17),
      child: Column(
        children: [
          const ViewHeaderTwo(
            title: 'Bookmarks',
            backButton: true,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: const Divider(),
          ),
        ],
      ),
    );
  }
}
