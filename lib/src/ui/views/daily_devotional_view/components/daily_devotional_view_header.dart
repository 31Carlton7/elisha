import 'package:canton_design_system/canton_design_system.dart';

class DailyDevotionalViewHeader extends StatelessWidget {
  const DailyDevotionalViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [CantonBackButton(isClear: true)],
    );
  }
}
