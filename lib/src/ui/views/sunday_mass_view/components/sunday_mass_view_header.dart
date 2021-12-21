import 'package:canton_design_system/canton_design_system.dart';

class SundayMassViewHeader extends StatelessWidget {
  const SundayMassViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ViewHeaderTwo(
      title: 'Mass',
      backButton: true,
    );
  }
}
