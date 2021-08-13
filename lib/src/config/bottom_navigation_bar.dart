import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter/cupertino.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onTabTapped;

  const BottomNavBar(this.currentIndex, this.onTabTapped);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTabTapped,
      selectedFontSize: 1,
      unselectedFontSize: 1,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).colorScheme.secondaryVariant,
      items: [
        BottomNavigationBarItem(
          label: '',
          tooltip: '',
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 4.0),
                child: IconlyIcon(
                  IconlyBold.Home,
                  size: 24,
                  color: widget.currentIndex == 0
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.secondaryVariant,
                ),
              ),
              Text(
                'Home',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: widget.currentIndex == 0
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.secondaryVariant,
                    ),
              ),
            ],
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          tooltip: '',
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 4.0),
                child: Icon(
                  CupertinoIcons.book_fill,
                  size: 24,
                  color: widget.currentIndex == 1
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.secondaryVariant,
                ),
              ),
              Text(
                'Read',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: widget.currentIndex == 1
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.secondaryVariant,
                    ),
              ),
            ],
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          tooltip: '',
          icon: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 4.0),
                child: IconlyIcon(
                  IconlyBold.Video,
                  size: 24,
                  color: widget.currentIndex == 2
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.secondaryVariant,
                ),
              ),
              Text(
                'Church',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: widget.currentIndex == 2
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.secondaryVariant,
                    ),
              ),
            ],
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          tooltip: '',
          icon: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 4.0),
                child: IconlyIcon(
                  IconlyBold.Profile,
                  size: 24,
                  color: widget.currentIndex == 3
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.secondaryVariant,
                ),
              ),
              Text(
                'Profile',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: widget.currentIndex == 3
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.secondaryVariant,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
