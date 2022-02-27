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

import 'package:hive/hive.dart';

enum ReaderColors {
  dyn,
  white,
  gray,
  black,
  cream,
}

class ReaderSettingsRepository extends ChangeNotifier {
  var _bodyTextSize = 17.0;
  var _bodyTextHeight = 1.97;
  var _verseNumberSize = 14.0;
  var _verseNumberHeight = 1.5;
  var _typeFace = 'New York';
  var _readerColor = ReaderColors.dyn;

  double get bodyTextSize => _bodyTextSize;
  double get bodyTextHeight => _bodyTextHeight;
  double get verseNumberSize => _verseNumberSize;
  double get verseNumberHeight => _verseNumberHeight;
  String get typeFace => _typeFace;
  ReaderColors get readerColor => _readerColor;

  Future<void> incrementBodyTextSize() async {
    if (_bodyTextSize <= 23) _bodyTextSize++;
    notifyListeners();
    await _saveData();
  }

  Future<void> incrementBodyTextHeight() async {
    if (_bodyTextHeight <= 3.2) _bodyTextHeight += 0.25;
    notifyListeners();
    await _saveData();
  }

  Future<void> incrementVerseNumberSize() async {
    if (_bodyTextSize <= 23) _verseNumberSize++;
    notifyListeners();
    await _saveData();
  }

  Future<void> incrementVerseNumberHeight() async {
    if (_bodyTextHeight <= 3.2) _verseNumberHeight += 0.25;
    notifyListeners();
    await _saveData();
  }

  Future<void> decrementBodyTextSize() async {
    if (bodyTextSize >= 13) _bodyTextSize--;
    notifyListeners();
    await _saveData();
  }

  Future<void> decrementBodyTextHeight() async {
    if (_bodyTextHeight >= 1.7) _bodyTextHeight -= 0.25;
    notifyListeners();
    await _saveData();
  }

  Future<void> decrementVerseNumberSize() async {
    if (_bodyTextSize >= 13) _verseNumberSize--;
    notifyListeners();
    await _saveData();
  }

  Future<void> decrementVerseNumberHeight() async {
    if (_bodyTextHeight >= 1.7) _verseNumberHeight -= 0.25;
    notifyListeners();
    await _saveData();
  }

  Future<void> setTypeFace(String newTypeFace) async {
    _typeFace = newTypeFace;
    notifyListeners();
    await _saveData();
  }

  Future<void> setReaderColor(ReaderColors newReaderColor) async {
    _readerColor = newReaderColor;
    notifyListeners();
    await _saveData();
  }

  Future<void> _saveData() async {
    final box = Hive.box('elisha');

    final settings = <String, dynamic>{
      'bodyTextSize': _bodyTextSize,
      'bodyTextHeight': _bodyTextHeight,
      'verseNumberSize': _verseNumberSize,
      'verseNumberHeight': _verseNumberHeight,
      'typeFace': _typeFace,
      'readerColor': _readerColor.toString(),
    };

    await box.put('reader_settings', settings);
  }

  void loadData() {
    final box = Hive.box('elisha');

    /// Removes user from device.
    // box.delete('reader_settings');

    var settings = box.get('reader_settings', defaultValue: {
      'bodyTextSize': 17.0,
      'bodyTextHeight': 1.97,
      'verseNumberSize': 14.0,
      'verseNumberHeight': 1.5,
      'typeFace': 'New York',
      // 'readerColor': ReaderColors.dyn,
    });

    _bodyTextSize = settings['bodyTextSize'];
    _bodyTextHeight = settings['bodyTextHeight'];
    _verseNumberSize = settings['verseNumberSize'];
    _verseNumberHeight = settings['verseNumberHeight'];
    _typeFace = settings['typeFace'];
    //   _readerColor = settings['readerColor'];
  }
}
