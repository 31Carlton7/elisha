import 'package:elisha/src/ui/components/terms_and_privacy_policy_text.dart';
import 'package:elisha/src/ui/views/authentication_views/components/dont_have_an_account_text.dart';
import 'package:flutter/services.dart';

import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:elisha/src/providers/authentication_providers/authentication_repository_provider.dart';
import 'package:elisha/src/ui/views/authentication_views/components/sign_in_view_header.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_in_view/sign_in_view.dart';

class SignInProvidersView extends StatelessWidget {
  const SignInProvidersView(this.toggleView, {Key? key}) : super(key: key);

  final void Function() toggleView;

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(padding: const EdgeInsets.only(top: 100, left: 27, right: 27), body: _content(context));
  }

  Widget _content(BuildContext context) {
    const buttonSpacing = 12.0;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SignInViewHeader(),
            const SizedBox(height: 20),
            _signInWithGoogleButton(context),
            const SizedBox(height: buttonSpacing),
            _signInWithAppleButton(context),
            const SizedBox(height: buttonSpacing),
            _signInWithEmailButton(context),
            const SizedBox(height: 15),
            DontHaveAnAccountText(toggleView: toggleView),
            const Expanded(child: Align(alignment: FractionalOffset.bottomCenter, child: TermsAndPrivacyPolicyText())),
          ],
        ),
      ),
    );
  }

  Widget _signInWithGoogleButton(BuildContext context) {
    return CantonPrimaryButton(
      borderRadius: CantonSmoothBorder.smallBorder().borderRadius,
      buttonText: 'Continue with Google',
      alignment: MainAxisAlignment.spaceAround,
      prefixIcon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Image.asset(
          'assets/images/google_icon.png',
          height: 24,
        ),
      ),
      textColor: Theme.of(context).colorScheme.secondaryVariant,
      color: Theme.of(context).colorScheme.onSecondary,
      border: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 1.5,
      ),
      onPressed: () async {
        HapticFeedback.lightImpact();

        await context.read(authenticationRepositoryProvider).signInWithGoogle();
      },
    );
  }

  Widget _signInWithEmailButton(BuildContext context) {
    return CantonPrimaryButton(
      buttonText: 'Continue with Email',
      borderRadius: CantonSmoothBorder.smallBorder().borderRadius,
      prefixIcon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FaIcon(
          FontAwesomeIcons.solidEnvelope,
          color: Theme.of(context).colorScheme.secondaryVariant,
        ),
      ),
      alignment: MainAxisAlignment.spaceAround,
      textColor: Theme.of(context).colorScheme.secondaryVariant,
      color: Theme.of(context).colorScheme.onSecondary,
      border: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 1.5,
      ),
      onPressed: () {
        CantonMethods.viewTransition(context, SignInView(toggleView));
      },
    );
  }

  Widget _signInWithAppleButton(BuildContext context) {
    return CantonPrimaryButton(
      buttonText: 'Continue with Apple',
      borderRadius: CantonSmoothBorder.smallBorder().borderRadius,
      prefixIcon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: const FaIcon(FontAwesomeIcons.apple, size: 24),
      ),
      alignment: MainAxisAlignment.spaceAround,
      textColor: Theme.of(context).colorScheme.secondaryVariant,
      color: Theme.of(context).colorScheme.onSecondary,
      border: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 1.5,
      ),
      onPressed: () {
        CantonMethods.viewTransition(context, SignInView(toggleView));
      },
    );
  }
}
