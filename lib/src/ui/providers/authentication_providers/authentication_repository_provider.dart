import 'package:elisha/src/services/authentication/authentication_repository.dart';
import 'package:elisha/src/ui/providers/authentication_providers/firebase_auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepository(ref.read(firebaseAuthProvider));
});