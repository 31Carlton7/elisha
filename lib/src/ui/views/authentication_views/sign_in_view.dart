import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/providers/authentication_providers/authentication_repository_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInView extends StatefulWidget {
  const SignInView(this.toggleView);

  final Function? toggleView;

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
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 27),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _header(context),
            _emailInput(context),
            _passwordTextInput(context),
            _hasError ? SizedBox(height: 15) : Container(),
            _hasError ? _errorText(context, _errorMessage) : Container(),
            _signInButton(context),
            SizedBox(height: 15),
            Text(
              'Or sign in with',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
            ),
            SizedBox(height: 15),
            _signInWithGoogleButton(context),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                ),
                GestureDetector(
                  onTap: () => widget.toggleView!(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Image.asset(
            'assets/images/store_icon.png',
            height: 70,
          ),
        ),
        Container(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In to Elisha',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _emailInput(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: CantonTextInput(
        labelText: 'Email',
        hintText: '',
        isTextFormField: true,
        obscureText: false,
        controller: _emailController,
        textInputType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _passwordTextInput(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: CantonTextInput(
        labelText: 'Password',
        hintText: '',
        isTextFormField: true,
        obscureText: true,
        controller: _passwordController,
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      child: CantonPrimaryButton(
        buttonText: 'Sign In',
        textColor: CantonColors.white,
        containerColor: Theme.of(context).primaryColor,
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

  Widget _signInWithGoogleButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      child: CantonPrimaryButton(
        buttonText: 'Google',
        prefixIcon: Image.asset('assets/images/google_icon.png', height: 24),
        textColor: Theme.of(context).colorScheme.secondaryVariant,
        containerColor: Theme.of(context).canvasColor,
        border: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 1.5,
        ),
        onPressed: () async {
          HapticFeedback.lightImpact();

          await context
              .read(authenticationRepositoryProvider)
              .signInWithGoogle()
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
