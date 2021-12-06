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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:elisha/src/config/authentication_exceptions.dart';

Future<String> handleGoogleSignIn(FirebaseAuth firebaseAuth) async {
  try {
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return '';

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await firebaseAuth.signInWithCredential(credential);

    return 'success';
  } catch (e) {
    if (e is FirebaseAuthException) {
      return AuthenticationExceptions.fromFirebaseAuthError(e).toString();
    } else if (e is RangeError) {
      return '';
    }
    return 'failed';
  }
}
