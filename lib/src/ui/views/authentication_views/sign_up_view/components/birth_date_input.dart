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

class BirthDateInput extends StatelessWidget {
  const BirthDateInput({Key? key, required this.birthDateText, required this.showBirthDatePicker}) : super(key: key);

  final String birthDateText;
  final Future<void> Function() showBirthDatePicker;

  @override
  Widget build(BuildContext context) {
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
              'Birthday',
              style: Theme.of(context).inputDecorationTheme.labelStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.all(13),
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              shape: CantonSmoothBorder.smallBorder(),
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
