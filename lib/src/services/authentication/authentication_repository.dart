import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elisha/src/config/authentication_exceptions.dart';
import 'package:elisha/src/models/user.dart' as elisha;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  AuthenticationRepository(this._firebaseAuth);

  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('users');

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> _createUserInDatabase(elisha.User user) async {
    await userRef.doc(user.id).set(user.toDocumentSnapshot());
  }

  Future<String> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return 'success';
    } catch (e) {
      if (e is FirebaseAuthException) {
        return AuthenticationExceptions.fromFirebaseAuthError(e).toString();
      }
      return 'failed';
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return '';

      final googleAuth = await googleUser.authentication;

      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(googleCredential);

      return 'success';
    } catch (e) {
      if (e is FirebaseAuthException) {
        return AuthenticationExceptions.fromFirebaseAuthError(e).toString();
      } else if (e is RangeError) {
        print(e);
        return '';
      }
      return 'failed';
    }
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

      final uid = FirebaseAuth.instance.currentUser?.uid;

      var user = elisha.User(
        id: uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        birthDate: birthDate,
        imageUrl: '',
        currentStreak: 1,
        bestStreak: 1,
        perfectWeeks: 0,
      );

      await _createUserInDatabase(user);

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
