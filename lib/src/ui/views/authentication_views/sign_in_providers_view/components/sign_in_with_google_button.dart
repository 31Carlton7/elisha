import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/authentication_providers/authentication_repository_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
