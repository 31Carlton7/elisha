import 'dart:convert';

import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/models/verse.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StudyToolsRepository extends ChangeNotifier {
  var _favoritedVerses = <Verse>[];
  var _bookmarkedChapters = <Chapter>[];

  List<Verse> get favoriteVerses => _favoritedVerses;
  List<Chapter> get bookmarkedChapters => _bookmarkedChapters;

  Future<void> addFavoriteVerse(Verse verse) async {
    _favoritedVerses.add(verse.copyWith(favorite: true));
    await _saveData();
    notifyListeners();
  }

  Future<void> addBookmarkChapter(Chapter chapter) async {
    _bookmarkedChapters.add(chapter.copyWith(bookmarked: true));
    await _saveData();
    notifyListeners();
  }

  Future<void> removeFavoriteVerse(Verse verse) async {
    _favoritedVerses = [
      for (final item in _favoritedVerses)
        if (item.id != verse.id) item,
    ];

    await _saveData();
    notifyListeners();
  }

  Future<void> removeBookmarkChapter(Chapter chapter) async {
    _bookmarkedChapters = [
      for (final item in _bookmarkedChapters)
        if (item.verses![0].text != chapter.verses![0].text) item,
    ];

    await _saveData();
    notifyListeners();
  }

  Future<void> _saveData() async {
    final box = Hive.box('elisha');

    List<String> favChapters = _favoritedVerses.map((e) => json.encode(e.toMap())).toList();
    List<String> bkChapters = _bookmarkedChapters.map((e) => json.encode(e.toMap())).toList();

    List<String> studiedChapters = <String>{...favChapters, ...bkChapters}.toList();

    await box.put('studied_chapters', studiedChapters);
  }

  void loadData() {
    var box = Hive.box('elisha');

    /// Removes all [Chapters] (s) from device.
    // box.delete('studied_chapters');

    List<String> savedChapters = box.get('studied_chapters', defaultValue: <String>[]);
    var maps = <Map<String, dynamic>>[];

    for (String item in savedChapters) {
      maps.add(json.decode(item) as Map<String, dynamic>);
    }

    for (Map<String, dynamic> item in maps) {
      if (item.containsKey('verseId')) {
        if (item['favorite']) {
          _favoritedVerses.add(Verse.fromMap(item));
        }
      } else {
        if (item['bookmarked']) {
          _bookmarkedChapters.add(Chapter.fromMap(item));
        }
      }
    }
  }
}
