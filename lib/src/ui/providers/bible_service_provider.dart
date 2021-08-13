import 'package:dio/dio.dart';
import 'package:elisha/src/services/bible_service.dart';
import 'package:riverpod/riverpod.dart';

final bibleServiceProvider = Provider<BibleService>((ref) {
  var dio = Dio();

  return BibleService(dio);
});
