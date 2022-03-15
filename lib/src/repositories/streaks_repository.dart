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

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:elisha/src/repositories/local_user_repository.dart';

class StreaksRepository extends ChangeNotifier {
  var _currentStreak = 1;
  var _bestStreak = 1;
  var _perfectWeeks = 0;

  int get currentStreak => _currentStreak;
  int get bestStreak => _bestStreak;
  int get perfectWeeks => _perfectWeeks;

  Future<void> _incrementStreak() async {
    final box = Hive.box('elisha');
    _currentStreak++;
    await box.put('current_streak', _currentStreak);
    notifyListeners();
  }

  Future<void> _incrementBestStreak() async {
    final box = Hive.box('elisha');
    _bestStreak++;
    await box.put('best_streak', _bestStreak);
    notifyListeners();
  }

  Future<void> _incrementPerfectWeeks() async {
    final box = Hive.box('elisha');
    _perfectWeeks++;
    await box.put('perfect_weeks', _perfectWeeks);
    notifyListeners();
  }

  Future<void> _resetCurrentStreak() async {
    final box = Hive.box('elisha');

    _currentStreak = 1;
    await box.put('current_streak', _currentStreak);
    notifyListeners();
  }

  void _loadData() {
    final box = Hive.box('elisha');

    _currentStreak = box.get('current_streak', defaultValue: 1);
    _bestStreak = box.get('best_streak', defaultValue: 1);
    _perfectWeeks = box.get('perfect_weeks', defaultValue: 0);
  }

  Future<void> updateStreaks() async {
    _loadData();

    final box = Hive.box('elisha');

    final now = DateTime.now();

    var lastVisitDate = DateTime.parse(box.get('visitKey', defaultValue: now.toString()));
    var startDayDate = DateTime(now.year, now.month, now.day);

    if (startDayDate.day == lastVisitDate.day &&
        startDayDate.month == lastVisitDate.month &&
        startDayDate.year == lastVisitDate.year) {
      DoNothingAction();
    } else if (lastVisitDate.day == startDayDate.day - 1) {
      await LocalUserRepository().updateNatureImage();
      await LocalUserRepository().updateChurchImage();

      await _incrementStreak();

      if (_currentStreak > _bestStreak) {
        await _incrementBestStreak();
      }

      if (_currentStreak % 7 == 0) {
        await _incrementPerfectWeeks();
      }
    } else {
      await LocalUserRepository().updateNatureImage();
      await LocalUserRepository().updateChurchImage();

      await _resetCurrentStreak();
    }

    await box.put('visitKey', DateTime.now().toString());
  }
}
