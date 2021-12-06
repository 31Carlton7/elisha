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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/providers/authentication_providers/authentication_repository_provider.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        _header(context),
        _signOutButton(context),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return const ViewHeaderTwo(
      title: 'Account',
      backButton: true,
    );
  }

  Widget _signOutButton(BuildContext context) {
    return CantonPrimaryButton(
      buttonText: 'Sign Out',
      color: Theme.of(context).colorScheme.onError,
      textColor: Theme.of(context).colorScheme.error,
      containerWidth: MediaQuery.of(context).size.width / 2 - 34,
      onPressed: () {
        context.read(authenticationRepositoryProvider).signOut();
        Navigator.pop(context);
      },
    );
  }
}
