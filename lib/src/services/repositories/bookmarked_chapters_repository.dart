import 'dart:convert';

import 'package:elisha/src/models/chapter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkedChaptersRepository extends StateNotifier<List<Chapter>> {
  BookmarkedChaptersRepository() : super([]);

  Future<void> bookmarkChapter(Chapter chapter) async {
    state = [...state, chapter];
    await _saveChapters();
  }

  Future<void> removeChapter(Chapter chapter) async {
    state = [
      for (final item in state)
        if (item != chapter) item,
    ];

    await _saveChapters();
  }

  Future<void> _saveChapters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> chapters = state.map((e) => json.encode(e.toMap())).toList();

    prefs.setStringList('bookmarked_chapters', chapters);
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// Removes all [Chapters] (s) from device.
    // prefs.remove('bookmarked_chapters');

    List<String> savedChapters =
        prefs.getStringList('bookmarked_chapters') ?? [];
    state = savedChapters.map((e) => Chapter.fromMap(json.decode(e))).toList();
  }
}
