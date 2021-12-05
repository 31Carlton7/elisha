import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/translation.dart';
import 'package:elisha/src/providers/bible_service_provider.dart';

String translationID = '';

final bibleTranslationsProvider = FutureProvider.autoDispose<List<Translation>>((ref) async {
  ref.maintainState = true;

  final bibleService = ref.read(bibleServiceProvider);
  final versions = bibleService.getTranslations();

  return versions;
});
