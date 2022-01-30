import 'package:canton_design_system/canton_design_system.dart';

class SettingsViewHeader extends StatelessWidget {
  const SettingsViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ViewHeaderTwo(
      title: 'Settings',
      backButton: true,
    );
  }
}
