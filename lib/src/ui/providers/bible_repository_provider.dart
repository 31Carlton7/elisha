import 'package:elisha/src/services/repositories/bible_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bibleRepositoryProvider = Provider<BibleRepository>((ref) {
  return BibleRepository();
});
