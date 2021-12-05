import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/providers/authentication_providers/firebase_auth_provider.dart';
import 'package:elisha/src/services/authentication/authentication_repository.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepository(ref.read(firebaseAuthProvider));
});
