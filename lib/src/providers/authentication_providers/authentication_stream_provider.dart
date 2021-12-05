import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/providers/authentication_providers/authentication_repository_provider.dart';

final authenticationStreamProvider = StreamProvider<User?>((ref) {
  return ref.watch(authenticationRepositoryProvider).authStateChanges;
});
