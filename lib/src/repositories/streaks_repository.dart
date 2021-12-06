import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

    var lastVisitDate = box.get('visitKey', defaultValue: DateTime.now().toString());
    var todayDate = DateTime.now().toString();

    if (todayDate == lastVisitDate) {
      DoNothingAction();
    } else if (DateTime.parse(lastVisitDate).isBefore(DateTime.now())) {
      await _resetCurrentStreak();
    } else {
      await _incrementStreak();

      if (_currentStreak > _bestStreak) {
        await _incrementBestStreak();
      }

      if (_currentStreak % 7 == 0) {
        await _incrementPerfectWeeks();
      }

      await box.put('visitKey', todayDate);
    }
  }
}
