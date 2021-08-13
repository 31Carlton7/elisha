import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/account_view.dart';
import 'package:elisha/src/ui/views/bookmarked_chapters_view.dart';

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
    return Container(
      child: ViewHeaderTwo(
        title: 'Profile',
        textColor: Theme.of(context).colorScheme.primary,
        backButton: false,
        buttonOne: CantonHeaderButton(),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: 65,
            backgroundColor: Theme.of(context).primaryColor,
            child: Container(
              child: IconlyIcon(
                IconlyBold.Profile,
                size: 40,
                color: CantonColors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Name',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 10),
          ..._statCards(context),
          SizedBox(height: 10),
          ..._viewCards(context),
          SizedBox(height: 10),
          ..._applicationCards(context),
        ],
      ),
    );
  }

  List<Widget> _statCards(BuildContext context) {
    return [
      Card(
        margin: EdgeInsets.only(top: 5),
        shape: SquircleBorder(
          radius: BorderRadius.vertical(
            top: Radius.circular(37),
          ),
          side: BorderSide(
            width: 1.5,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Streak',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'Num',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
        ),
      ),
      Card(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Perfect Weeks',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'Num',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
        ),
      ),
      Card(
        margin: EdgeInsets.only(bottom: 5),
        shape: SquircleBorder(
          radius: BorderRadius.vertical(
            bottom: Radius.circular(37),
          ),
          side: BorderSide(
            width: 1.5,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Best Streak',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'Num',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> _viewCards(BuildContext context) {
    return [
      GestureDetector(
        onTap: () {
          CantonMethods.viewTransition(context, BookmarkedChaptersView());
        },
        child: Card(
          margin: EdgeInsets.only(bottom: 5),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bookmarks',
                  style: Theme.of(context).textTheme.headline6,
                ),
                IconlyIcon(
                  IconlyBold.ArrowRight1,
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
          CantonMethods.viewTransition(context, AccountView());
        },
        child: Card(
          margin: EdgeInsets.zero,
          shape: SquircleBorder(
            radius: BorderRadius.vertical(
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
            radius: BorderRadius.vertical(
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
