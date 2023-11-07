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

import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:elisha/src/ui/views/sunday_mass_view/sunday_mass_view.dart';

class SundayMassCard extends ConsumerWidget {
  const SundayMassCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, const SundayMassView());
      },
      child: Card(
        color: CantonMethods.alternateCanvasColorType3(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildImage(context, ref),
              const SizedBox(height: 15),
              Text(
                'Sunday Mass',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 7),
              Text(
                'ONLINE CHURCH SERVICE',
                style: Theme.of(context).textTheme.overline?.copyWith(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Join in on Sunday Mass today by watching today\'s service online.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, WidgetRef ref) {
    final churchImage = ref.watch(localUserRepositoryProvider).getChurchImage;

    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.asset(
            churchImage,
            fit: BoxFit.fitWidth,
            height: 140,
            width: MediaQuery.of(context).size.width,
            errorBuilder: (_, __, ___) {
              return Container();
            },
          ),
        ),
        Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.play_arrow,
              color: Theme.of(context).colorScheme.onBackground,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
