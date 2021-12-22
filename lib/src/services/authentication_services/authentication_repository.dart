/*
Elisha iOS & Android App
Copyright (C) 2021 Elisha

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
 any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/authentication_views/verify_email_view/verify_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:elisha/src/config/authentication_exceptions.dart';
import 'package:elisha/src/models/local_user.dart';
import 'package:elisha/src/repositories/local_user_repository.dart';
import 'package:elisha/src/services/authentication_handlers/apple_sign_in.dart';
import 'package:elisha/src/services/authentication_handlers/google_sign_in.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

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

      // final localUser = LocalUser(firstName: firstName, lastName: lastName, email: email, birthDate: birthDate);

      // await _updateLocalUser(localUser);

      return 'success';
    } catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, null);

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
      await FirebaseCrashlytics.instance.recordError(e, null);

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
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required DateTime birthDate,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      final user = FirebaseAuth.instance.currentUser;

      if (user != null && !user.emailVerified) {
        CantonMethods.viewTransition(context, const VerifyEmailView());

        var actionCodeSettings = ActionCodeSettings(
          url: 'https://elishaapp.page.link/?email=${user.email}',
          dynamicLinkDomain: 'elishaapp.page.link',
          androidPackageName: 'com.elisha.app',
          androidInstallApp: true,
          androidMinimumVersion: '12',
          iOSBundleId: 'com.elisha.app',
          handleCodeInApp: true,
        );

        await user.sendEmailVerification(actionCodeSettings);
      }

      final localUser = LocalUser(firstName: firstName, lastName: lastName, email: email, birthDate: birthDate);

      await _updateLocalUser(localUser);

      return 'success';
    } on FirebaseAuthException catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, e.stackTrace);

      return e.message!;
    }
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();

      return 'success';
    } catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, null);

      if (e is FirebaseAuthException) {
        return AuthenticationExceptions.fromFirebaseAuthError(e).toString();
      }
      return 'failed';
    }
  }
}
