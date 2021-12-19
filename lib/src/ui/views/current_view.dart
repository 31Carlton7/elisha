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
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/config/bottom_navigation_bar.dart';
import 'package:elisha/src/config/exceptions.dart';
import 'package:elisha/src/providers/bookmarked_chapters_provider.dart';
import 'package:elisha/src/providers/daily_readings_provider.dart';
import 'package:elisha/src/providers/last_translation_book_chapter_provider.dart';
import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:elisha/src/providers/streaks_repository_provider.dart';
import 'package:elisha/src/ui/components/error_body.dart';
import 'package:elisha/src/ui/components/unexpected_error.dart';
import 'package:elisha/src/ui/views/bible_view/bible_view.dart';
import 'package:elisha/src/ui/views/church_view/church_view.dart';
import 'package:elisha/src/ui/views/home_view/home_view.dart';
import 'package:elisha/src/ui/views/profile_view/profile_view.dart';

final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _bibleNavigatorKey = GlobalKey<NavigatorState>();
final _churchNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

class CurrentView extends StatefulWidget {
  const CurrentView({Key? key}) : super(key: key);

  @override
  _CurrentViewState createState() => _CurrentViewState();
}

class _CurrentViewState extends State<CurrentView> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex && _currentIndex == 0 && _homeNavigatorKey.currentState!.canPop()) {
      _homeNavigatorKey.currentState!.pop();
    }
    if (index == _currentIndex && _currentIndex == 1 && _bibleNavigatorKey.currentState!.canPop()) {
      _bibleNavigatorKey.currentState!.pop();
    }
    if (index == _currentIndex && _currentIndex == 2 && _churchNavigatorKey.currentState!.canPop()) {
      _churchNavigatorKey.currentState!.pop();
    }
    if (index == _currentIndex && _currentIndex == 3 && _profileNavigatorKey.currentState!.canPop()) {
      _profileNavigatorKey.currentState!.pop();
    }

    setState(() {
      _currentIndex = index;
    });
  }

  void _loadData() async {
    await context.read(streaksRepositoryProvider).updateStreaks();
    context.read(localRepositoryProvider.notifier).loadLastChapterAndTranslation();
    context.read(bookmarkedChaptersProvider.notifier).loadData();
    context.read(localUserRepositoryProvider.notifier).loadUser();
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
          loading: () {
            return CantonScaffold(
              bottomNavBar: BottomNavBar(_currentIndex, _onTabTapped),
              body: Container(),
            );
          },
          data: (readings) {
            final _views = <Widget>[
              const HomeView(),
              const BibleView(),
              ChurchView(readings),
              const ProfileView(),
            ];

            return CantonScaffold(
              safeArea: false,
              bottomNavBar: BottomNavBar(_currentIndex, _onTabTapped),
              padding: EdgeInsets.zero,
              backgroundColor: CantonMethods.alternateCanvasColor(context, index: _currentIndex, targetIndexes: [1]),
              body: IndexedStack(
                index: _currentIndex,
                children: [
                  Navigator(
                    key: _homeNavigatorKey,
                    observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())],
                    onGenerateRoute: (settings) {
                      return MaterialPageRoute(
                        settings: settings,
                        fullscreenDialog: true,
                        builder: (context) => SafeArea(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: _views[_currentIndex],
                          ),
                        ),
                      );
                    },
                  ),
                  Navigator(
                    key: _bibleNavigatorKey,
                    observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())],
                    onGenerateRoute: (settings) {
                      return MaterialPageRoute(
                        settings: settings,
                        fullscreenDialog: true,
                        builder: (context) => SafeArea(child: _views[_currentIndex]),
                      );
                    },
                  ),
                  Navigator(
                    key: _churchNavigatorKey,
                    observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())],
                    onGenerateRoute: (settings) {
                      return MaterialPageRoute(
                        settings: settings,
                        fullscreenDialog: true,
                        builder: (context) => SafeArea(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: _views[_currentIndex],
                          ),
                        ),
                      );
                    },
                  ),
                  Navigator(
                    key: _profileNavigatorKey,
                    observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())],
                    onGenerateRoute: (settings) {
                      return MaterialPageRoute(
                        settings: settings,
                        fullscreenDialog: true,
                        builder: (context) => SafeArea(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: _views[_currentIndex],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
