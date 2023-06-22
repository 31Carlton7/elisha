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
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  final int currentIndex;
  final void Function(int) onTabTapped;

  const BottomNavBar(this.currentIndex, this.onTabTapped, {Key? key}) : super(key: key);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  static const _iconSize = 27.0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTabTapped,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.secondaryContainer,
      selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor, size: 24),
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          tooltip: '',
          activeIcon: Icon(LineAwesomeIcons.home, size: _iconSize),
          icon: Icon(LineAwesomeIcons.home, size: _iconSize),
        ),
        BottomNavigationBarItem(
          label: 'Bible',
          tooltip: '',
          activeIcon: Icon(LineAwesomeIcons.bible, size: _iconSize),
          icon: Icon(LineAwesomeIcons.bible, size: _iconSize),
        ),
        BottomNavigationBarItem(
          label: 'Church',
          tooltip: '',
          activeIcon: Icon(LineAwesomeIcons.church, size: _iconSize),
          icon: Icon(LineAwesomeIcons.church, size: _iconSize),
        ),
        BottomNavigationBarItem(
          label: 'Me',
          tooltip: '',
          activeIcon: Icon(LineAwesomeIcons.user, size: _iconSize),
          icon: Icon(LineAwesomeIcons.user, size: _iconSize),
        ),
      ],
    );
  }
}
