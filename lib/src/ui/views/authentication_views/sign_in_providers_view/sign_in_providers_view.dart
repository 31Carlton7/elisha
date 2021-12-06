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

import 'dart:io';

import 'package:elisha/src/ui/components/terms_and_privacy_policy_text.dart';
import 'package:elisha/src/ui/views/authentication_views/components/dont_have_an_account_text.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_in_providers_view/components/sign_in_anonymously_button.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_in_providers_view/components/sign_in_with_apple_button.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_in_providers_view/components/sign_in_with_email_button.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_in_providers_view/components/sign_in_with_google_button.dart';

import 'package:canton_design_system/canton_design_system.dart';

import 'package:elisha/src/ui/views/authentication_views/components/sign_in_view_header.dart';

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
            SignInWithEmailButton(toggleView: toggleView),
            const SizedBox(height: buttonSpacing),
            const SignInAnonymouslyButton(),
            const SizedBox(height: buttonSpacing),
            const SignInWithGoogleButton(),
            Platform.isIOS ? const SizedBox(height: buttonSpacing) : Container(),
            Platform.isIOS ? const SignInWithAppleButton() : Container(),
            const SizedBox(height: 15),
            DontHaveAnAccountText(toggleView: toggleView),
            const Expanded(child: Align(alignment: FractionalOffset.bottomCenter, child: TermsAndPrivacyPolicyText())),
          ],
        ),
      ),
    );
  }
}
