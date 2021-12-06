import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_in_view/sign_in_view.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInWithEmailButton extends StatelessWidget {
  const SignInWithEmailButton({Key? key, required this.toggleView}) : super(key: key);

  final void Function() toggleView;

  @override
  Widget build(BuildContext context) {
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
        HapticFeedback.lightImpact();
        CantonMethods.viewTransition(context, SignInView(toggleView));
      },
    );
  }
}
