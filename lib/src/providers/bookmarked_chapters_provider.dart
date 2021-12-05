import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/repositories/bookmarked_chapters_repository.dart';

final bookmarkedChaptersProvider =
    StateNotifierProvider<BookmarkedChaptersRepository, List<Chapter>>((ref) {
  return BookmarkedChaptersRepository();
});
