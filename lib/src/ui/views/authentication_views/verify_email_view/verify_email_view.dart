import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/authentication_views/verify_email_view/components/verify_email_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  void initState() {
    super.initState();
    _initDynamicLinks();
  }

  ///Retreive dynamic link firebase.
  void _initDynamicLinks() async {
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    final deepLink = data?.link;

    if (deepLink != null) {
      await _handleDynamicLink(deepLink);
    }

    FirebaseDynamicLinks.instance.onLink.listen((event) async {
      final Uri? deepLink = event.link;

      if (deepLink != null) {
        await _handleDynamicLink(deepLink);
      }
    }, onError: (e) async {
      await FirebaseCrashlytics.instance.recordError(e, null);
    });
  }

  Future<void> _handleDynamicLink(Uri url) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    //Get actionCode from the dynamicLink
    final actionCode = url.queryParameters['oobCode']!;

    try {
      await auth.checkActionCode(actionCode);
      await auth.applyActionCode(actionCode);

      Navigator.pop(context);

      // If successful, reload the user:
      auth.currentUser!.reload();
    } on FirebaseAuthException catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, null);
    }
    // List<String> separatedString = [];
    // separatedString.addAll(url.path.split('/'));
    // if (separatedString[1] == "post") {
    //   // Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(separatedString[2])));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const VerifyEmailHeader(),
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/store_icon.png',
              height: 70,
            ),
            const SizedBox(width: 10),
            Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
            ),
            const SizedBox(width: 10),
            FaIcon(
              FontAwesomeIcons.solidEnvelope,
              size: 40,
              color: Theme.of(context).colorScheme.secondaryVariant,
            )
          ],
        ),
        const SizedBox(height: 40),
        Text(
          'An email has been sent to ${user!.email}. Please click the link in the email to verify your email address.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
