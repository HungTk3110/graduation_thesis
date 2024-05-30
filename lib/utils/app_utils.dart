import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppUtils {

  void handleFirebaseAuthException(BuildContext context, FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'invalid-email':
        message = 'The email address is not valid.';
        break;
      case 'user-disabled':
        message = 'The user has been disabled.';
        break;
      case 'user-not-found':
        message = 'No user found with this email.';
        break;
      case 'wrong-password':
        message = 'Wrong password provided.';
        break;
      case 'email-already-in-use':
        message = 'The email address is already in use by another account.';
        break;
      case 'operation-not-allowed':
        message = 'Email/password accounts are not enabled.';
        break;
      case 'weak-password':
        message = 'The password is too weak.';
        break;
      default:
        message = 'An unknown error occurred.';
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}