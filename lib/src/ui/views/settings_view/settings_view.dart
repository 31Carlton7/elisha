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
import 'package:elisha/src/ui/views/settings_view/components/reader_settings_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/config/constants.dart';
import 'package:elisha/src/ui/views/settings_view/components/change_birth_date_card.dart';
import 'package:elisha/src/ui/views/settings_view/components/change_first_name_card.dart';
import 'package:elisha/src/ui/views/settings_view/components/change_last_name_card.dart';
import 'package:elisha/src/ui/views/settings_view/components/settings_view_header.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CantonScaffoldType2(
      backgroundColor: Theme.of(context).canvasColor,
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SettingsViewHeader(),
          const SizedBox(height: 17),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const ChangeFirstNameCard(),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const Padding(padding: EdgeInsets.symmetric(horizontal: 17), child: Divider()),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const ChangeLastNameCard(),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const Padding(padding: EdgeInsets.symmetric(horizontal: 17), child: Divider()),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const ChangeBirthDateCard(),
          ),
          const SizedBox(height: kDefaultPadding),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const ReaderSettingsCard(),
          ),
          const SizedBox(height: kSmallPadding),
          Text(
            kVersionNumber,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
