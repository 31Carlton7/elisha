import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elisha/src/models/user.dart' as elisha;
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  var userRef = FirebaseFirestore.instance.collection('users');
  var uid = FirebaseAuth.instance.currentUser?.uid;

  Stream<elisha.User> get user {
    try {
      var user = userRef.doc(uid).snapshots().map((event) {
        return elisha.User.fromDocumentSnapshot(event);
      });

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
