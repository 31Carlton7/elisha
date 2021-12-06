import 'dart:io';

import 'package:elisha/src/ui/components/terms_and_privacy_policy_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:elisha/src/providers/authentication_providers/authentication_repository_provider.dart';
import 'package:elisha/src/ui/views/authentication_views/components/email_text_input.dart';
import 'package:elisha/src/ui/views/authentication_views/components/password_text_input.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_up_view/components/birth_date_input.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_up_view/components/first_name_input.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_up_view/components/last_name_input.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_up_view/components/sign_up_view_header.dart';

class SignUpView extends StatefulWidget {
  const SignUpView(this.toggleView, {Key? key}) : super(key: key);

  final Function? toggleView;

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var _errorMessage = '';
  var _hasError = false;
  var birthDateText = '';
  var _birthDateController = DateTime.now();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      resizeToAvoidBottomInset: true,
      padding: const EdgeInsets.only(top: 40, left: 27, right: 27),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SignUpViewHeader(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FirstNameInput(firstNameController: _firstNameController),
                LastNameInput(lastNameController: _lastNameController),
              ],
            ),
            EmailTextInput(emailController: _emailController),
            PasswordTextInput(passwordController: _passwordController),
            BirthDateInput(birthDateText: birthDateText, showBirthDatePicker: _showBirthDatePicker),
            _hasError ? const SizedBox(height: 15) : Container(),
            _hasError ? _errorText(context, _errorMessage) : Container(),
            _signUpButton(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Or Sign In',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.toggleView!();
                  },
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
            const SizedBox(height: 15),
            const TermsAndPrivacyPolicyText(),
          ],
        ),
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      child: CantonPrimaryButton(
        buttonText: 'Sign Up',
        textColor: CantonColors.white,
        color: Theme.of(context).primaryColor,
        containerWidth: 120,
        containerHeight: 40,
        padding: EdgeInsets.zero,
        borderRadius: CantonSmoothBorder.smallBorder().borderRadius,
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
            var res = await context.read(authenticationRepositoryProvider).signUp(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                  firstName: _firstNameController.text.trim(),
                  lastName: _lastNameController.text.trim(),
                  birthDate: _birthDateController,
                );

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
    final initialDate = DateTime.now();
    final maximumYear = DateTime.now().year;
    final firstDate = DateTime(1900);
    final lastDate = DateTime.now();

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
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 27),
                child: Text(
                  'Select Your Birthday',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const Divider(),
              SizedBox(
                height: 200,
                child: Platform.isIOS
                    ? CupertinoTheme(
                        data: CupertinoThemeData(
                          brightness: MediaQuery.of(context).platformBrightness,
                        ),
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: initialDate,
                          minimumDate: firstDate,
                          minimumYear: firstDate.year,
                          maximumDate: initialDate,
                          maximumYear: maximumYear,
                          onDateTimeChanged: (date) {
                            _birthDateController = date;
                            setState(() {
                              birthDateText = DateFormat.yMMMd().format(date);
                            });
                          },
                        ),
                      )
                    : DatePickerDialog(
                        initialDate: initialDate,
                        firstDate: firstDate,
                        lastDate: lastDate,
                        initialCalendarMode: DatePickerMode.day,
                        selectableDayPredicate: (date) {
                          _birthDateController = date;
                          setState(() {
                            birthDateText = DateFormat.yMMMd().format(date);
                          });
                          return true;
                        },
                      ),
              ),
              const SizedBox(height: 20),
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
