import 'package:elisha/src/models/book.dart';
import 'package:elisha/src/ui/providers/bible_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String bookID = '';

final bibleBooksProvider = FutureProvider.autoDispose<List<Book>>((ref) async {
  ref.maintainState = true;

  final bibleService = ref.read(bibleServiceProvider);
  final books = bibleService.getBooks(bookID);

  return books;
});
