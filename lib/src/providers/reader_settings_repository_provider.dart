import 'package:elisha/src/repositories/reader_settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final readerSettingsRepositoryProvider = ChangeNotifierProvider<ReaderSettingsRepository>((ref) {
  return ReaderSettingsRepository();
});
