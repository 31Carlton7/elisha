import 'package:elisha/src/repositories/study_tools_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final studyToolsRepositoryProvider = ChangeNotifierProvider<StudyToolsRepository>((ref) {
  return StudyToolsRepository();
});
