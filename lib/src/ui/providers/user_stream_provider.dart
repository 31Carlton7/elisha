import 'package:elisha/src/models/user.dart';
import 'package:elisha/src/ui/providers/user_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStreamProvider = StreamProvider<User>((ref) {
  return ref.read(userRepositoryProvider).user;
});
