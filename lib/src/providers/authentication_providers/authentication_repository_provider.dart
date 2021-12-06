import 'package:elisha/src/services/authentication_services/authentication_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/providers/authentication_providers/firebase_auth_provider.dart';

final authenticationRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepository(ref.read(firebaseAuthProvider));
});
