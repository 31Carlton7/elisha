import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndPrivacyPolicyText extends StatelessWidget {
  const TermsAndPrivacyPolicyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'We prioritize your privacy',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Linkify(
          onOpen: (link) async {
            if (await canLaunch(link.url)) {
              await launch(link.url);
            } else {
              throw 'Could not launch $link';
            }
          },
          text: 'By signing up, you agree to our Terms and Privacy Policy.',
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
          linkStyle: Theme.of(context).textTheme.bodyText2?.copyWith(decoration: TextDecoration.underline),
        )
      ],
    );
  }
}
