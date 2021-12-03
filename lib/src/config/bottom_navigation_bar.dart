import 'package:flutter/cupertino.dart';

import 'package:canton_design_system/canton_design_system.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onTabTapped;

  const BottomNavBar(this.currentIndex, this.onTabTapped, {Key? key}) : super(key: key);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static const _iconSize = 27.0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTabTapped,
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.secondaryVariant,
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
          label: 'Profile',
          tooltip: '',
          activeIcon: Icon(LineAwesomeIcons.user, size: _iconSize),
          icon: Icon(LineAwesomeIcons.user, size: _iconSize),
        ),
      ],
    );
  }
}
