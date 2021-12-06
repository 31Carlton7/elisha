import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/chapter.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    var box = Hive.box('elisha');

    List<String> chapters = state.map((e) => json.encode(e.toMap())).toList();

    box.put('bookmarked_chapters', chapters);
  }

  void loadData() {
    var box = Hive.box('elisha');

    /// Removes all [Chapters] (s) from device.
    // box.remove('bookmarked_chapters');

    List<String> savedChapters = box.get('bookmarked_chapters', defaultValue: <String>[]);
    state = savedChapters.map((e) => Chapter.fromMap(json.decode(e))).toList();
  }
}
