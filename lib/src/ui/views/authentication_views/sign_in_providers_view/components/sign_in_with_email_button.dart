/*
Elisha iOS & Android App
Copyright (C) 2021 Elisha

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
 any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/services.dart';

import 'package:canton_design_system/canton_design_system.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:elisha/src/ui/views/authentication_views/sign_in_view/sign_in_view.dart';

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
