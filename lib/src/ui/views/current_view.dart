import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/config/bottom_navigation_bar.dart';
import 'package:elisha/src/config/exceptions.dart';
import 'package:elisha/src/ui/components/error_body.dart';
import 'package:elisha/src/ui/components/unexpected_error.dart';
import 'package:elisha/src/ui/providers/bookmarked_chapters_provider.dart';
import 'package:elisha/src/ui/providers/daily_readings_provider.dart';
import 'package:elisha/src/ui/providers/last_translation_book_chapter_provider.dart';
import 'package:elisha/src/ui/views/bible_view.dart';
import 'package:elisha/src/ui/views/church_view.dart';
import 'package:elisha/src/ui/views/home_view.dart';
import 'package:elisha/src/ui/views/profile_view.dart';

class CurrentView extends StatefulWidget {
  @override
  _CurrentViewState createState() => _CurrentViewState();
}

class _CurrentViewState extends State<CurrentView> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await context
        .read(localRepositoryProvider.notifier)
        .loadLastChapterAndTranslation();

    await context.read(bookmarkedChaptersProvider.notifier).loadData();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final dailyReadingsRepo = watch(dailyReadingsProvider);

        return dailyReadingsRepo.when(
          error: (e, s) {
            if (e is Exceptions) {
              return ErrorBody(e.message, dailyReadingsProvider);
            }
            return UnexpectedError(dailyReadingsProvider);
          },
          loading: () => CantonScaffold(
            bottomNavBar: BottomNavBar(
              _currentIndex,
              onTabTapped,
            ),
            body: Container(),
          ),
          data: (readings) {
            final List<Widget> _views = [
              HomeView(),
              BibleView(),
              ChurchView(readings),
              ProfileView(),
            ];

            return CantonScaffold(
              bottomNavBar: BottomNavBar(_currentIndex, onTabTapped),
              body: _views[_currentIndex],
            );
          },
        );
      },
    );
  }
}
