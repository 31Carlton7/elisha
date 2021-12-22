import 'package:dio/dio.dart';
import 'package:elisha/src/services/verse_of_the_day_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final verseOfTheDayServiceProvider = Provider<VerseOfTheDayService>((ref) {
  return VerseOfTheDayService(Dio());
});
