import 'package:elisha/src/models/local_user.dart';
import 'package:elisha/src/repositories/local_user_repository.dart';
import 'package:elisha/src/services/authentication_handlers/apple_sign_in.dart';
import 'package:elisha/src/services/authentication_handlers/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:elisha/src/config/authentication_exceptions.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  AuthenticationRepository(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> _updateLocalUser(LocalUser user) async {
    await LocalUserRepository().updateUser(user);
  }

  Future<String> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return 'success';
    } catch (e) {
      if (e is FirebaseAuthException) {
        return AuthenticationExceptions.fromFirebaseAuthError(e).toString();
      }
      return 'failed';
    }
  }

  Future<String> signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();

      return 'success';
    } catch (e) {
      if (e is FirebaseAuthException) {
        return AuthenticationExceptions.fromFirebaseAuthError(e).toString();
      }
      return 'failed';
    }
  }

  Future<String> signInWithApple() async {
    return await handleAppleSignIn(_firebaseAuth);
  }

  Future<String> signInWithGoogle() async {
    return handleGoogleSignIn(_firebaseAuth);
  }

  Future<String> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required DateTime birthDate,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = LocalUser(firstName: firstName, lastName: lastName, email: email, birthDate: birthDate);

      await _updateLocalUser(user);

      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();

      return 'success';
    } catch (e) {
      if (e is FirebaseAuthException) {
        return AuthenticationExceptions.fromFirebaseAuthError(e).toString();
      }
      return 'failed';
    }
  }
}