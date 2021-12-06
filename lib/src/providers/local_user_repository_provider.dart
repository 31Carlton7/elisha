import 'package:elisha/src/models/local_user.dart';
import 'package:elisha/src/providers/authentication_providers/authentication_stream_provider.dart';
import 'package:elisha/src/repositories/local_user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localUserRepositoryProvider = StateNotifierProvider.autoDispose<LocalUserRepository, LocalUser>((ref) {
  ref.watch(authenticationStreamProvider).whenData((value) {
    if (value == null) {
      ref.maintainState = false;
    } else {
      ref.maintainState = true;
    }
  });
  return LocalUserRepository();
});
