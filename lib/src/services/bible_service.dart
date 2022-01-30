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

import 'package:dio/dio.dart';
import 'package:elisha/src/config/constants.dart';
import 'package:elisha/src/providers/bible_chapters_provider.dart';
import 'package:elisha/src/repositories/bible_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';

import 'package:elisha/src/config/exceptions.dart';
import 'package:elisha/src/models/book.dart';
import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/models/translation.dart';
import 'package:elisha/src/models/verse.dart';

class BibleService {
  BibleService(this._dio);
  final Dio _dio;
  final _rootUrl = isEmulator ? 'https://localhost:8084' : 'https://bible-go-api.rkeplin.com/v1';

  Future<List<Translation>> getTranslations() async {
    try {
      final response = await _dio.get(_rootUrl + '/translations');

      final results = List<Map<String, dynamic>>.from(response.data);

      final translations = results.map((version) => Translation.fromMap(version)).toList(growable: true);

      translations.removeWhere((element) {
        switch (element.abbreviation) {
          case 'NLT':
            return true;
          case 'NIV':
            return true;
          case 'ESV':
            return true;
          default:
            return false;
        }
      });

      return translations;
    } on DioError catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
      throw Exceptions.fromDioError(e);
    }
  }

  Future<List<Book>> getBooks(String? bookID) async {
    try {
      if (!['', null].contains(bookID)) {
        final response = await _dio.get(_rootUrl + '/books/$bookID');

        final chaptersReponse = await _dio.get(_rootUrl + '/books/$bookID/chapters');

        final result = Map<String, dynamic>.from(response.data);

        final chaptersResult = List<Map<String, dynamic>>.from(chaptersReponse.data);

        final book = Book.fromMap(result).copyWith(
          chapters: chaptersResult.map((chapter) => ChapterId.fromMap(chapter)).toList(
                growable: false,
              ),
        );

        return [book];
      } else {
        var trace = FirebasePerformance.instance.newTrace('book_chapter_bottom_sheet_open_time');
        trace.start();

        final books = BibleRepository().getBooks();

        trace.stop();

        return books;
      }
    } on DioError catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
      throw Exceptions.fromDioError(e);
    }
  }

  Future<Chapter> getChapter(String bookID, String chapterID, String translationID) async {
    try {
      final response = await _dio.get(
        _rootUrl + '/books/$bookID/chapters/$chapterID?translation=${translationID.replaceAll('"', '')}',
      );

      final results = List<Map<String, dynamic>>.from(response.data);

      final verses = results.map((verse) => Verse.fromMap(verse)).toList(growable: false);

      final chapter = Chapter(
        id: verses[0].book.id,
        number: verses[0].chapterId.toString(),
        translation: translationID,
        verses: verses,
        bookmarked: false,
      );

      return chapter;
    } on DioError catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
      throw Exceptions.fromDioError(e);
    }
  }

  Future<List<Chapter>> getChapters(String? bookID) async {
    try {
      final response = await _dio.get(_rootUrl + '/books/$bookID/chapters');

      final results = List<Map<String, dynamic>>.from(
        response.data,
      );

      final List<Chapter> chapters = results.map((chapter) => Chapter.fromMap(chapter)).toList(growable: false);

      return chapters;
    } on DioError catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
      throw Exceptions.fromDioError(e);
    }
  }

  Future<List<Verse>> getVerses(String bookID, String chapterID, String? verseID) async {
    try {
      if (!['', null].contains(verseID)) {
        var vId = bookID;

        switch (chapterID.length) {
          case 1:
            vId += '00' + chapterID;
            break;
          case 2:
            vId += '0' + chapterID;
            break;
          default:
            vId += chapterID;
        }

        switch (verseID!.length) {
          case 1:
            vId += '00' + verseID;
            break;
          case 2:
            vId += '0' + verseID;
            break;
          default:
            vId += verseID;
        }

        final response =
            await _dio.get(_rootUrl + '/books/$bookID/chapters/$chapterID/$vId?translation=$translationAbb');

        final result = Map<String, dynamic>.from(response.data);

        final verses = [Verse.fromMap(result)];

        return verses;
      } else {
        final response = await _dio.get(_rootUrl + '/books/$bookID/chapters/$chapterID');

        final results = List<Map<String, dynamic>>.from(response.data);

        final List<Verse> verses = results.map((verse) => Verse.fromMap(verse)).toList(growable: false);

        return verses;
      }
    } on DioError catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
      throw Exceptions.fromDioError(e);
    }
  }
}
