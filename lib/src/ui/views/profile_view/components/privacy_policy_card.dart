import 'package:canton_design_system/canton_design_system.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyCard extends StatelessWidget {
  const PrivacyPolicyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        const link = 'https://31carlton7.github.io/elisha/privacy_policy';

        if (await canLaunch(link)) {
          await launch(link);
        } else {
          throw 'Could not launch $link';
        }
      },
      child: Card(
        color: CantonMethods.alternateCanvasColorType3(context),
        margin: const EdgeInsets.symmetric(horizontal: 17),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 21),
          alignment: Alignment.centerLeft,
          child: Text(
            'Privacy Policy',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
