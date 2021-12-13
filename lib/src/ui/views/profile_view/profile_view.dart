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

import 'package:elisha/src/ui/views/account_view/account_view.dart';
import 'package:elisha/src/ui/views/bookmarked_chapters_view/bookmarked_chapters_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [_header(context), _body(context)],
    );
  }

  Widget _header(BuildContext context) {
    return ViewHeaderTwo(
      title: 'Profile',
      textColor: Theme.of(context).colorScheme.primary,
      backButton: false,
      buttonOne: const CantonHeaderButton(),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 65,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Iconsax.user,
            size: 40,
            color: CantonColors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Name',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 10),
        // ..._statCards(context),
        const SizedBox(height: 10),
        ..._viewCards(context),
        const SizedBox(height: 10),
        ..._applicationCards(context),
      ],
    );
  }

  List<Widget> _viewCards(BuildContext context) {
    return [
      GestureDetector(
        onTap: () {
          CantonMethods.viewTransition(context, const BookmarkedChaptersView());
        },
        child: Card(
          margin: const EdgeInsets.only(bottom: 5),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bookmarks',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Icon(
                  Iconsax.arrow_right_3,
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _applicationCards(BuildContext context) {
    return [
      GestureDetector(
        onTap: () {
          CantonMethods.viewTransition(context, const AccountView());
        },
        child: Card(
          margin: EdgeInsets.zero,
          shape: SquircleBorder(
            radius: const BorderRadius.vertical(
              top: Radius.circular(37),
            ),
            side: BorderSide(
              color: Theme.of(context).colorScheme.onSecondary,
              width: 1.5,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: Text(
              'Account',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          // CantonMethods.viewTransition(context, BookmarkedChaptersView());
        },
        child: Card(
          margin: EdgeInsets.zero,
          shape: Border(
            left: BorderSide(
              width: 1.5,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            right: BorderSide(
              width: 1.5,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: Text(
              'About',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          // CantonMethods.viewTransition(context, BookmarkedChaptersView());
        },
        child: Card(
          margin: EdgeInsets.zero,
          shape: SquircleBorder(
            radius: const BorderRadius.vertical(
              bottom: Radius.circular(37),
            ),
            side: BorderSide(
              color: Theme.of(context).colorScheme.onSecondary,
              width: 1.5,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: Text(
              'FAQ',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
    ];
  }
}
