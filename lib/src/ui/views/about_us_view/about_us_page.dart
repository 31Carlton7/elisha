import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/about_us_view/about_us_view_header.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const AboutUsHeaderView(),
          const SizedBox(height: 10),
          Card(
            color: CantonMethods.alternateCanvasColorType2(context),
            shape: CantonSmoothBorder.defaultBorder(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'CPAI is a project-based learning initiative to equip the CACAF with the relevant skills and exposure necessary to thrive in our ever-changing digital age.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Secret Place attempts to create a virtual digital private environment for young people to have their morning devotions undisturbed and thus build a vibrant relationship with God',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
