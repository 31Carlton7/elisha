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
