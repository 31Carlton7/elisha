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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:elisha/src/providers/authentication_providers/authentication_repository_provider.dart';

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
