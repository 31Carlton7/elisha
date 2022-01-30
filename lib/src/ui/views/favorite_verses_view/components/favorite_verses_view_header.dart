import 'package:canton_design_system/canton_design_system.dart';

class FavoriteVersesViewHeader extends StatelessWidget {
  const FavoriteVersesViewHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: const ViewHeaderTwo(
            title: 'Favorite Verses',
            backButton: true,
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: const Divider(),
        ),
      ],
    );
  }
}
