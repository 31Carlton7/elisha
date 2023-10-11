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
import 'package:url_launcher/url_launcher.dart';

class AboutCard extends ConsumerWidget {
  const AboutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        const link = 'https://31carlton7.github.io/elisha';

        if (await canLaunch(link)) {
          await launch(link);
        } else {
          DoNothingAction();
        }
      },
      child: Card(
        color: CantonMethods.alternateCanvasColorType3(context),
        margin: const EdgeInsets.symmetric(horizontal: 17),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 21),
          alignment: Alignment.centerLeft,
          child: Text(
            'About',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
