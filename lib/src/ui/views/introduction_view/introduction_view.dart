/*
Elisha iOS & Android App
Copyright (C) 2022 Carlton Aikins

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

import 'package:flutter/cupertino.dart';

import 'package:canton_ui/canton_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:elisha/src/models/local_user.dart';
import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:elisha/src/ui/views/current_view.dart';
import 'package:elisha/src/ui/views/introduction_view/components/birth_date_input.dart';
import 'package:elisha/src/ui/views/introduction_view/components/first_name_input.dart';
import 'package:elisha/src/ui/views/introduction_view/components/last_name_input.dart';

class IntroductionView extends ConsumerStatefulWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  _IntroductionViewState createState() => _IntroductionViewState();
}

class _IntroductionViewState extends ConsumerState<IntroductionView> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WelcomeView(),
      ),
      (route) => false,
    );
  }

  Widget _buildImage(IconData icon) {
    return Center(
      child: Icon(
        icon,
        color: Theme.of(context).primaryColor,
        size: 80,
      ),
    );
  }

  PageDecoration _pageDecoration() {
    return PageDecoration(
      titleTextStyle: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
      bodyTextStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      // descriptionPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: CantonMethods.alternateCanvasColorType2(context),
      imagePadding: EdgeInsets.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: CantonMethods.alternateCanvasColorType2(context),
        // skipColor: CantonColors.transparent,
        // nextColor: CantonColors.transparent,
        // isTopSafeArea: true,
        // isBottomSafeArea: true,
        showDoneButton: true,
        showNextButton: true,
        onSkip: () => _onIntroEnd(context),
        onDone: () => _onIntroEnd(context),
        nextFlex: 0,
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        dotsDecorator: DotsDecorator(
          size: const Size(10.0, 10.0),
          color: const Color(0xFFBDBDBD),
          activeColor: Theme.of(context).primaryColor,
          activeSize: const Size(22.0, 10.0),
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        next: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'Next',
            style: Theme.of(context).textTheme.button?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
        done: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'Next',
            style: Theme.of(context).textTheme.button?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
        pages: [
          PageViewModel(
            title: 'Read the Bible',
            body: 'Read 5 versions of the Bible, Bookmark chapters and Favorite verses.',
            image: _buildImage(LineAwesomeIcons.bible),
            decoration: _pageDecoration(),
          ),
          PageViewModel(
            title: 'Church',
            body: 'Go to Church with Sunday Mass and Daily Readings.',
            image: _buildImage(LineAwesomeIcons.church),
            decoration: _pageDecoration(),
          ),
          PageViewModel(
            title: 'Interactive Features',
            body: 'Streaks, Verse of the Day, and more!',
            image: _buildImage(LineAwesomeIcons.hand_pointing_up),
            decoration: _pageDecoration(),
          ),
        ],
      ),
    );
  }
}

class WelcomeView extends ConsumerStatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends ConsumerState<WelcomeView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  var birthDateText = '';
  var _birthDateController = DateTime.now();

  var _validate = false;

  Future<void> _onDoneBtnPressed(BuildContext context, LocalUser user) async {
    await ref.read(localUserRepositoryProvider.notifier).updateUser(user);
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const CurrentView(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColorType2(context),
      resizeToAvoidBottomInset: true,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Responsive(
        mobile: _buildMobileBody(context),
        tablet: _buildTabletBody(context),
      ),
    );
  }

  Widget _buildMobileBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 9),
        Image.asset('assets/app_icons/store_icon.png', height: 70),
        const SizedBox(height: 20),
        Column(
          children: [
            Text(
              'Welcome to Elisha',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 10),
            Text(
              'Please fill out the following fields.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FirstNameInput(firstNameController: _firstNameController),
            LastNameInput(lastNameController: _lastNameController),
          ],
        ),
        BirthDateInput(birthDateText: birthDateText, showBirthDatePicker: _showBirthDatePicker),
        _doneButton(),
        const SizedBox(height: 30),
        _validate
            ? Text(
                'Please fill out the remaining fields',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              )
            : Container(),
      ],
    );
  }

  Widget _buildTabletBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 9),
        Image.asset('assets/app_icons/store_icon.png', height: MediaQuery.of(context).size.height / 17),
        const SizedBox(height: 20),
        Column(
          children: [
            Text(
              'Welcome to Elisha',
              style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 27),
            ),
            const SizedBox(height: 10),
            Text(
              'Please fill out the following fields.',
              style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 24),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 325),
              child: FirstNameInput(firstNameController: _firstNameController),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 325),
              child: LastNameInput(lastNameController: _lastNameController),
            ),
          ],
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: BirthDateInput(birthDateText: birthDateText, showBirthDatePicker: _showBirthDatePicker),
        ),
        _doneButton(),
        const SizedBox(height: 30),
        _validate
            ? Text(
                'Please fill out the remaining fields',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              )
            : Container(),
      ],
    );
  }

  Future<void> _showBirthDatePicker() async {
    final initialDate = DateTime.now();
    final maximumYear = DateTime.now().year;
    final firstDate = DateTime(1900);
    final lastDate = DateTime.now();

    if (Platform.isIOS) {
      return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                  child: Text(
                    'Select Your Birthday',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: CupertinoTheme(
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
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CantonPrimaryButton(
                    buttonText: 'Confirm',
                    color: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).colorScheme.onBackground,
                    containerWidth: 100,
                    containerHeight: 30,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          builder: (context, child) {
            final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

            return Theme(
              data: Theme.of(context).copyWith(
                brightness: Brightness.light,
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: isDarkMode ? CantonColors.black : CantonColors.white,
                  onSurface: isDarkMode ? CantonColors.white : CantonColors.black,
                ),
              ),
              child: child!,
            );
          }).then((date) {
        _birthDateController = date!;
        setState(() {
          birthDateText = DateFormat.yMMMd().format(date);
        });
      });
    }
  }

  Widget _doneButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      child: CantonPrimaryButton(
        buttonText: 'Done',
        color: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.onBackground,
        containerWidth: 120,
        containerHeight: 50,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(25),
        onPressed: () async {
          if ([_firstNameController.text, _lastNameController.text].contains('')) {
            setState(() {
              _validate = true;
            });
          } else {
            await _onDoneBtnPressed(
              context,
              LocalUser(
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                birthDate: _birthDateController,
              ),
            );
          }
        },
      ),
    );
  }
}
