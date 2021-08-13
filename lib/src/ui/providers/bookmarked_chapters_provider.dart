import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/services/repositories/bookmarked_chapters_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookmarkedChaptersProvider =
    StateNotifierProvider<BookmarkedChaptersRepository, List<Chapter>>((ref) {
  return BookmarkedChaptersRepository();
});
