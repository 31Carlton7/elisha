import 'package:elisha/src/repositories/streaks_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streaksRepositoryProvider = ChangeNotifierProvider<StreaksRepository>((ref) {
  return StreaksRepository();
});
