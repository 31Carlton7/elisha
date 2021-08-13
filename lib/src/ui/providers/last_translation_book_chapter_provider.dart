import 'package:elisha/src/models/translation_book_chapter.dart';
import 'package:elisha/src/services/repositories/last_translation_book_chapter_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localRepositoryProvider = StateNotifierProvider.autoDispose<
    LastTranslationBookChapterRepository, TranslationBookChapter>((ref) {
  ref.maintainState = true;
  return LastTranslationBookChapterRepository();
});
