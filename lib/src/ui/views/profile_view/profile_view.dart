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
import 'package:elisha/src/ui/views/profile_view/components/support_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/ui/components/streaks_card.dart';
import 'package:elisha/src/ui/views/profile_view/components/about_card.dart';
import 'package:elisha/src/ui/views/profile_view/components/bookmarks_card.dart';
import 'package:elisha/src/ui/views/profile_view/components/favorite_verses_card.dart';
import 'package:elisha/src/ui/views/profile_view/components/privacy_policy_card.dart';
import 'package:elisha/src/ui/views/profile_view/components/profile_view_header.dart';
import 'package:elisha/src/ui/views/profile_view/components/settings_card.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _body(context),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileViewHeader(),
        const SizedBox(height: 17),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const StreaksCard(marginalPadding: true),
        ),
        const SizedBox(height: 17),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const BookmarksCard(),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const FavoriteVersesCard(),
        ),
        const SizedBox(height: 17),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const SettingsCard(),
        ),
        const SizedBox(height: 17),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const AboutCard(),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const SupportCard(),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const PrivacyPolicyCard(),
        ),
        const SizedBox(height: kDefaultPadding)
      ],
    );
  }
}
