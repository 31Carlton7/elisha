import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

import 'package:elisha/src/services/bible_service.dart';

final bibleServiceProvider = Provider<BibleService>((ref) {
  return BibleService(Dio());
});
