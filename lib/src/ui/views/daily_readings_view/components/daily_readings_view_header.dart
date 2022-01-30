import 'package:canton_design_system/canton_design_system.dart';

class DailyReadingsViewHeader extends StatelessWidget {
  const DailyReadingsViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const ViewHeaderTwo(
        backButton: true,
        title: 'Daily Readings',
      ),
    );
  }
}
