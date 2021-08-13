import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationExceptions implements Exception {
  AuthenticationExceptions.fromFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        message = "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        message = "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        message = "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        message = "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        message = "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        message = "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        message = "Email address is invalid.";
        break;
      default:
        message = "Login failed. Please try again.";
        break;
    }
  }

  String message = '';

  @override
  String toString() => message;
}
