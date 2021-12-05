import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/models/user.dart';
import 'package:elisha/src/providers/authentication_providers/authentication_stream_provider.dart';
import 'package:elisha/src/repositories/user_repository.dart';

final userStreamProvider = StreamProvider.autoDispose<User>((ref) {
  ref.watch(authenticationStreamProvider).whenData((value) {
    if (value == null) {
      ref.maintainState = false;
    } else {
      ref.maintainState = true;
    }
  });
  return UserRepository().user;
});
