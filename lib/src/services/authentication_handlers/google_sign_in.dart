import 'package:elisha/src/config/authentication_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
