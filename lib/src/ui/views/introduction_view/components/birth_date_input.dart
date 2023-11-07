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

import 'package:canton_ui/canton_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BirthDateInput extends ConsumerWidget {
  const BirthDateInput({
    Key? key,
    required this.birthDateText,
    required this.showBirthDatePicker,
  }) : super(key: key);

  final String birthDateText;
  final Future<void> Function() showBirthDatePicker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        showBirthDatePicker();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(
              'Birthday (Optional)',
              style: Theme.of(context).inputDecorationTheme.labelStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.all(13),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.circular(kSmallBorderRadius),
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
}
