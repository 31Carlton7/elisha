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

const String kAppTitle = 'Elisha';

const String kVersionNumber = 'Elisha v1.1.4 (14)';

const natureImages = <String>[
  'assets/images/nature_1.jpg',
  'assets/images/nature_2.jpg',
  'assets/images/nature_3.jpg',
  'assets/images/nature_4.jpg',
  'assets/images/nature_5.jpg',
  'assets/images/nature_6.jpg',
  'assets/images/nature_7.jpg',
  'assets/images/nature_8.jpg',
  'assets/images/nature_9.jpg',
  'assets/images/nature_10.jpg',
];

const churchImages = <String>[
  'assets/images/church_1.jpg',
  'assets/images/church_2.jpg',
  'assets/images/church_3.jpg',
];

Color heartColor(BuildContext context) {
  if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
    return CantonDarkColors.red[400]!;
  }
  return CantonColors.red[400]!;
}
