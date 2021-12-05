import 'package:elisha/src/models/verse.dart';
import 'package:elisha/src/ui/providers/bible_books_provider.dart';
import 'package:elisha/src/ui/providers/bible_chapters_provider.dart';
import 'package:elisha/src/ui/providers/bible_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String verseID = '';

final bibleVersesProvider =
    FutureProvider.autoDispose<List<Verse>>((ref) async {
  ref.maintainState = true;

  bool bookIDIsEmpty = ['', null].contains(verseID);

  final bibleService = ref.read(bibleServiceProvider);
  final verses =
      bibleService.getVerses(bookID, chapterID, bookIDIsEmpty ? null : verseID);

  return verses;
});