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

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:elisha/src/models/translation_book_chapter.dart';
import 'package:elisha/src/providers/bible_books_provider.dart';
import 'package:elisha/src/providers/bible_chapters_provider.dart';
import 'package:elisha/src/providers/bible_translations_provider.dart';

class LastTranslationBookChapterRepository extends StateNotifier<TranslationBookChapter> {
  LastTranslationBookChapterRepository()
      : super(TranslationBookChapter(translationAbb: 'kjv', translation: 2, book: 1, chapter: 1));

  String get getCurrentTranslationAbb => state.translationAbb ?? 'kjv';
  int get getCurrentTranslationId => state.translation ?? 2;
  int get getCurrentBookId => state.book ?? 1;
  int get getCurrentChapterId => state.chapter ?? 1;

  Future<void> changeBibleTranslation(int number, String abb) async {
    state.translation = number;
    state.translationAbb = abb;
    translationID = number.toString();
    translationAbb = abb;
    await _saveLastChapterAndTranslation();
  }

  Future<void> changeBibleBook(int number) async {
    state.book = number;
    await _saveLastChapterAndTranslation();
  }

  Future<void> changeBibleChapter(int number) async {
    state.chapter = number;
    await _saveLastChapterAndTranslation();
  }

  /// Saves last Bible Chapter and version the user was on
  Future<void> _saveLastChapterAndTranslation() async {
    var box = Hive.box('elisha');

    List<String> savedBibleChapterAndTranslation = [];

    savedBibleChapterAndTranslation.add(json.encode(state.translation));
    savedBibleChapterAndTranslation.add(json.encode(state.translationAbb));
    savedBibleChapterAndTranslation.add(json.encode(state.book));
    savedBibleChapterAndTranslation.add(json.encode(state.chapter));

    box.put('bible_chapter_translation', savedBibleChapterAndTranslation);
  }

  void loadLastChapterAndTranslation() {
    var box = Hive.box('elisha');

    // Removes all info
    // box.delete('bible_chapter_translation');

    List<String> savedBibleChapterAndTranslation =
        box.get('bible_chapter_translation', defaultValue: ['2', 'kjv', '1', '1']);

    var savedList = savedBibleChapterAndTranslation.map((element) => element.toString()).toList();

    state.translation = int.parse(savedList[0]);
    state.translationAbb = savedList[1].replaceAll('"', '');
    state.book = int.parse(savedList[2]);
    state.chapter = int.parse(savedList[3]);

    translationID = state.translation.toString();
    translationAbb = state.translationAbb!;
    bookID = state.book.toString();
    chapterID = state.chapter.toString();
  }
}
