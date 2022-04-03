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

import 'package:dio/dio.dart';

import 'package:elisha/src/models/book.dart';
import 'package:elisha/src/models/verse.dart';
import 'package:elisha/src/services/bible_service.dart';

class VerseOfTheDayService {
  const VerseOfTheDayService(this._dio);
  final Dio _dio;
  final _rootUrl = 'https://devotionalium.com/api/v2';

  Future<List<Verse>> get getVerseOfTheDay async {
    try {
      final response = await _dio.get(_rootUrl);

      final result = response.data;

      var verses = <Verse>[];

      for (int item in result['1']['verses']) {
        var verse = Verse.fromMapFromVOTD(result, item);
        var newVerse = await BibleService().getVerses(
          verse.book.id.toString(),
          verse.chapterId.toString(),
          verse.verseId.toString(),
        );

        verses.add(newVerse[0]);
      }

      return verses;
    } catch (e) {
      return [
        Verse(
          id: 40028020,
          chapterId: 28,
          verseId: 20,
          text:
              'teaching them to observe all things whatsoever I have commanded you: and, lo, I am with you alway, even unto the end of the world. Amen.',
          book: Book(
            id: 40,
            name: 'Matthew',
            testament: 'New',
            chapters: [],
          ),
          favorite: false,
        ),
      ];
    }
  }
}
