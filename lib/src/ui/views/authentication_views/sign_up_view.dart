import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/ui/providers/authentication_providers/authentication_repository_provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView(this.toggleView);

  final Function? toggleView;

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String _errorMessage = '';
  bool _hasError = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  var _birthDateController = DateTime.now();
  String birthDateText = '';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child: _firstNameInput(context)),
                Container(child: _lastNameInput(context)),
              ],
            ),
            _emailInput(context),
            _passwordTextInput(context),
            _birthDateInput(context),
            _hasError ? SizedBox(height: 15) : Container(),
            _hasError ? _errorText(context, _errorMessage) : Container(),
            _signUpButton(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Or Sign In',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                ),
                GestureDetector(
                  onTap: () => widget.toggleView!(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Here',
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
                'Welcome to Elisha',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _firstNameInput(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      width: MediaQuery.of(context).size.width / 2 - 44,
      child: CantonTextInput(
        hintText: '',
        labelText: 'First Name',
        isTextFormField: true,
        obscureText: false,
        controller: _firstNameController,
        textInputType: TextInputType.name,
      ),
    );
  }

  Widget _lastNameInput(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      width: MediaQuery.of(context).size.width / 2 - 44,
      child: CantonTextInput(
        hintText: '',
        labelText: 'Last Name',
        isTextFormField: true,
        obscureText: false,
        controller: _lastNameController,
        textInputType: TextInputType.name,
      ),
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

  Widget _birthDateInput(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBirthDatePicker();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 7),
            child: Text(
              'Birthday',
              style: Theme.of(context).inputDecorationTheme.labelStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.all(13),
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: SquircleBorder(
                radius: BorderRadius.circular(37),
              ),
            ),
            child: Row(
              children: [
                Text(
                  birthDateText,
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      child: CantonPrimaryButton(
        buttonText: 'Sign Up',
        textColor: CantonColors.white,
        containerColor: Theme.of(context).primaryColor,
        onPressed: () async {
          HapticFeedback.lightImpact();

          if ([
            _emailController.text,
            _passwordController.text,
            _firstNameController.text,
            _lastNameController.text,
            birthDateText
          ].contains('')) {
            setState(() {
              _hasError = true;
              _errorMessage = 'Missing fields';
            });
          } else if (_birthDateController.isAtSameMomentAs(DateTime.now()) ||
              _birthDateController.isAfter(DateTime.now())) {
            setState(() {
              _hasError = true;
              _errorMessage = 'Invalid Birthday';
            });
          } else {
            var res =
                await context.read(authenticationRepositoryProvider).signUp(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      firstName: _firstNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                      birthDate: _birthDateController,
                    );

            print(res);

            if (res != 'success') {
              setState(() {
                _hasError = true;
                _errorMessage = res;
              });
            }
          }
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

  Future<void> _showBirthDatePicker() async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15, left: 27, right: 27),
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 27),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryVariant,
                            ),
                      ),
                    ),
                    Spacer(flex: 6),
                    Text(
                      'Select Your Birthday',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Spacer(flex: 9),
                  ],
                ),
              ),
              Divider(),
              Container(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (date) {
                    _birthDateController = date;
                    setState(() {
                      birthDateText = date.toLocal().toString().split(' ')[0];
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
