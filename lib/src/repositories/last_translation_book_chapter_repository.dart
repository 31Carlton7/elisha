import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:elisha/src/models/translation_book_chapter.dart';
import 'package:elisha/src/providers/bible_books_provider.dart';
import 'package:elisha/src/providers/bible_chapters_provider.dart';
import 'package:elisha/src/providers/bible_translations_provider.dart';

class LastTranslationBookChapterRepository extends StateNotifier<TranslationBookChapter> {
  LastTranslationBookChapterRepository()
      : super(
          TranslationBookChapter(
            translationAbb: 'asv',
            translation: 0,
            book: 1,
            chapter: 1,
          ),
        );

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
    // box.remove('bible_chapter_translation');

    List<String> savedBibleChapterAndTranslation =
        box.get('bible_chapter_translation', defaultValue: ['0', 'asv', '1', '1']);

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
