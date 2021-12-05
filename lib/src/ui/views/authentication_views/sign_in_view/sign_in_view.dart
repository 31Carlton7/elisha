import 'package:elisha/src/ui/components/terms_and_privacy_policy_text.dart';
import 'package:elisha/src/ui/views/authentication_views/components/dont_have_an_account_text.dart';
import 'package:flutter/services.dart';

import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/providers/authentication_providers/authentication_repository_provider.dart';
import 'package:elisha/src/ui/views/authentication_views/components/email_text_input.dart';
import 'package:elisha/src/ui/views/authentication_views/components/password_text_input.dart';
import 'package:elisha/src/ui/views/authentication_views/components/sign_in_view_header.dart';

class SignInView extends StatefulWidget {
  const SignInView(this.toggleView, {Key? key}) : super(key: key);

  final void Function() toggleView;

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _errorMessage = '';
  bool _hasError = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      resizeToAvoidBottomInset: true,
      padding: const EdgeInsets.symmetric(horizontal: 27),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: const [
                CantonBackButton(isClear: true),
              ],
            ),
            const SizedBox(height: 50),
            const SignInViewHeader(),
            EmailTextInput(emailController: _emailController),
            PasswordTextInput(passwordController: _passwordController),
            _hasError ? const SizedBox(height: 15) : Container(),
            _hasError ? _errorText(context, _errorMessage) : Container(),
            _signInButton(context),
            DontHaveAnAccountText(toggleView: widget.toggleView),
            const Expanded(child: Align(alignment: FractionalOffset.bottomCenter, child: TermsAndPrivacyPolicyText())),
          ],
        ),
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      child: CantonPrimaryButton(
        containerWidth: 120,
        containerHeight: 40,
        borderRadius: const SmoothBorderRadius.all(
          SmoothRadius(cornerRadius: 12, cornerSmoothing: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        buttonText: 'Sign In',
        textColor: CantonColors.white,
        color: Theme.of(context).primaryColor,
        onPressed: () async {
          HapticFeedback.lightImpact();

          await context
              .read(authenticationRepositoryProvider)
              .signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
              )
              .then((value) {
            if (value != 'success') {
              setState(() {
                _hasError = true;
                _errorMessage = value;
              });
            }
          });
        },
      ),
    );
  }

  Widget _errorText(BuildContext context, String error) {
    return Text(
      error,
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Theme.of(context).errorColor,
          ),
    );
  }
}
