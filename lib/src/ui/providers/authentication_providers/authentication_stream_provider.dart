import 'package:elisha/src/ui/providers/authentication_providers/authentication_repository_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationStreamProvider = StreamProvider<User?>((ref) {
  return ref.watch(authenticationRepositoryProvider).authStateChanges;
});
