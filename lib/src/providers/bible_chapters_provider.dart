import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/providers/bible_books_provider.dart';
import 'package:elisha/src/providers/bible_service_provider.dart';

String chapterID = '';
String translationAbb = '';

final bibleChaptersProvider = FutureProvider.autoDispose<Chapter>((ref) async {
  ref.maintainState = true;

  final bibleService = ref.read(bibleServiceProvider);
  final chapters = bibleService.getChapter(bookID, chapterID, translationAbb);

  return chapters;
});