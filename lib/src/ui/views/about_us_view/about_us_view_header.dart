import 'package:canton_design_system/canton_design_system.dart';

class AboutUsHeaderView extends StatelessWidget {
  const AboutUsHeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(children: [Text('About Us', style: Theme.of(context).textTheme.headline2)]),
    );
  }
}
