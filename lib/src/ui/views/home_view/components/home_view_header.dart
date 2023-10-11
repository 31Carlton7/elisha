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

class HomeViewHeader extends ConsumerWidget {
  const HomeViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Morning';
      }
      if (hour < 17) {
        return 'Afternoon';
      }
      return 'Evening';
    }

    String name(String source) {
      if (source.length > 18) {
        return source.substring(0, 15) + '...';
      }
      return source;
    }

    String? dbName = ref.watch(localUserRepositoryProvider).getUser.firstName;

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: Text(
          'Good ' + greeting() + ', ' + (dbName != '' ? name(dbName) : ''),
          style: Theme.of(context).textTheme.headline2?.copyWith(letterSpacing: 0.1),
        ),
      ),
    );
  }
}
