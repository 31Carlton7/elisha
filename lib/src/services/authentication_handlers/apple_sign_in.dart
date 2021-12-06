import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:elisha/src/config/authentication_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Future<String> handleAppleSignIn(FirebaseAuth firebaseAuth) async {
  try {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    await firebaseAuth.signInWithCredential(oauthCredential);

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
