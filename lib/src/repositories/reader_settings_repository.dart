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
  var _bodyTextSize = 21.0;
  var _bodyTextHeight = 1.97;
  var _verseNumberSize = 14.0;
  var _verseNumberHeight = 1.5;
  var _typeFace = 'Inter';
  var _readerColor = ReaderColors.dyn;

  double get bodyTextSize => _bodyTextSize;
  double get bodyTextHeight => _bodyTextHeight;
  double get verseNumberSize => _verseNumberSize;
  double get verseNumberHeight => _verseNumberHeight;
  String get typeFace => _typeFace;
  ReaderColors get readerColor => _readerColor;

  Future<void> incrementBodyTextSize() async {
    _bodyTextSize++;
    notifyListeners();
    await _saveData();
  }

  Future<void> incrementBodyTextHeight() async {
    _bodyTextHeight += 0.25;
    notifyListeners();
    await _saveData();
  }

  Future<void> incrementVerseNumberSize() async {
    _verseNumberSize++;
    notifyListeners();
    await _saveData();
  }

  Future<void> incrementVerseNumberHeight() async {
    _verseNumberHeight += 0.25;
    notifyListeners();
    await _saveData();
  }

  Future<void> decrementBodyTextSize() async {
    _bodyTextSize--;
    notifyListeners();
    await _saveData();
  }

  Future<void> decrementBodyTextHeight() async {
    _bodyTextHeight -= 0.25;
    notifyListeners();
    await _saveData();
  }

  Future<void> decrementVerseNumberSize() async {
    _verseNumberSize--;
    notifyListeners();
    await _saveData();
  }

  Future<void> decrementVerseNumberHeight() async {
    _verseNumberHeight -= 0.25;
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
      'bodyTextSize': 21.0,
      'bodyTextHeight': 1.97,
      'verseNumberSize': 14.0,
      'verseNumberHeight': 1.5,
      'typeFace': 'Inter',
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
