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

import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChangeBirthDateCard extends StatelessWidget {
  const ChangeBirthDateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = DateTime.now();
    final initialDate = DateTime.now();
    final maximumYear = DateTime.now().year;
    final firstDate = DateTime(1900);
    final lastDate = DateTime.now();
    String currentBirthdayStr() {
      return 'Current Birthday: ' +
          DateFormat('yMMMd').format((context.read(localUserRepositoryProvider).getUser.birthDate));
    }

    return CantonExpansionTile(
      title: Text(
        'Change Birthday',
        style: Theme.of(context).textTheme.headline6,
      ),
      decoration: BoxDecoration(
        color: CantonMethods.alternateCanvasColorType2(context),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      iconColor: Theme.of(context).colorScheme.primary,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentBirthdayStr(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 10),
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
                            _controller = date;
                          },
                        ),
                      )
                    : DatePickerDialog(
                        initialDate: initialDate,
                        firstDate: firstDate,
                        lastDate: lastDate,
                        initialCalendarMode: DatePickerMode.day,
                        selectableDayPredicate: (date) {
                          _controller = date;
                          return true;
                        },
                      ),
              ),
              const SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CantonPrimaryButton(
                    buttonText: 'Confirm',
                    color: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).colorScheme.onBackground,
                    containerWidth: 100,
                    containerHeight: 30,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      final updatedUser =
                          context.read(localUserRepositoryProvider).getUser.copyWith(birthDate: _controller);
                      context.read(localUserRepositoryProvider).updateUser(updatedUser);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
