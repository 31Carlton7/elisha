import 'package:elisha/src/models/translation.dart';
import 'package:elisha/src/ui/providers/bible_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String translationID = '';

final bibleTranslationsProvider =
    FutureProvider.autoDispose<List<Translation>>((ref) async {
  ref.maintainState = true;

  final bibleService = ref.read(bibleServiceProvider);
  final versions = bibleService.getTranslations();

  return versions;
});
