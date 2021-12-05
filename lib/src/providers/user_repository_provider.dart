import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});
