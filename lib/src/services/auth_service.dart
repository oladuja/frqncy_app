import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:frqncy_app/src/utils/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // User cancelled sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      logger.e('FirebaseAuthException (Google): ${e.message}');
      rethrow;
    } catch (e) {
      logger.e('Google sign-in error: $e');
      rethrow;
    }
  }

  Future<UserCredential> signInWithApple() async {
    try {
      if (!Platform.isIOS && !Platform.isMacOS) {
        throw UnsupportedError(
          'Apple Sign-In is only supported on iOS and macOS.',
        );
      }

      final rawNonce = generateNonce();

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );

      return await _auth.signInWithCredential(oauthCredential);
    } on FirebaseAuthException catch (e) {
      logger.e('FirebaseAuthException (Apple): ${e.message}');
      rethrow;
    } catch (e) {
      logger.e('Apple sign-in error: $e');
      rethrow;
    }
  }

  Future<UserCredential?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      logger.e('FirebaseAuthException: ${e.message}');
      rethrow;
    } catch (e) {
      logger.e('Email sign-in error: $e');
      rethrow;
    }
  }

  Future<UserCredential?> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      logger.e('FirebaseAuthException (Register): ${e.message}');
      rethrow;
    } catch (e) {
      logger.e('Email registration error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      logger.e('Sign out error: $e');
      rethrow;
    }
  }
}
