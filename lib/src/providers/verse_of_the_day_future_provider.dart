import 'package:elisha/src/models/verse.dart';
import 'package:elisha/src/providers/verse_of_the_day_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final verseOfTheDayFutureProvider = FutureProvider.autoDispose<List<Verse>>((ref) {
  ref.maintainState = true;
  return ref.read(verseOfTheDayServiceProvider).getVerseOfTheDay;
});
