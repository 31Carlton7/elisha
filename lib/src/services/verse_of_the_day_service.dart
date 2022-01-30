import 'package:dio/dio.dart';
import 'package:elisha/src/config/exceptions.dart';
import 'package:elisha/src/models/verse.dart';
import 'package:elisha/src/services/bible_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

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
        var newVerse = await BibleService(_dio).getVerses(
          verse.book.id.toString(),
          verse.chapterId.toString(),
          verse.verseId.toString(),
        );
        verses.add(newVerse[0]);
      }

      return verses;
    } on DioError catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
      throw Exceptions.fromDioError(e);
    }
  }
}
