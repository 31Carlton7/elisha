import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/authentication_providers/authentication_repository_provider.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInWithAppleButton extends StatelessWidget {
  const SignInWithAppleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      onPressed: () async {
        HapticFeedback.lightImpact();
        await context.read(authenticationRepositoryProvider).signInWithApple();
      },
    );
  }
}
