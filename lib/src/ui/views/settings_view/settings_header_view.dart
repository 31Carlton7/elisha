import 'package:canton_design_system/canton_design_system.dart';

class SettingsHeaderView extends StatelessWidget {
  const SettingsHeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(children: [Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Text('Settings', style: Theme.of(context).textTheme.headline3),
      )]),
    );
  }
}
