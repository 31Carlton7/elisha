import 'package:dio/dio.dart';
import 'package:elisha/src/config/exceptions.dart';
import 'package:elisha/src/models/verse.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class VerseOfTheDayService {
  const VerseOfTheDayService(this._dio);
  final Dio _dio;
  final _rootUrl = 'https://beta.ourmanna.com/api/v1';

  Future<Verse> get getVerseOfTheDay async {
    try {
      final response = await _dio.get(_rootUrl + '/get?format=json&order=daily');

      final result = response.data;

      final verse = Verse.fromMapFromVOTD(result);

      return verse;
    } on DioError catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
      throw Exceptions.fromDioError(e);
    }
  }
}
