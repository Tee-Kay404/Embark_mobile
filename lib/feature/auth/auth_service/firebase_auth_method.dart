import 'package:Embark_mobile/feature/util/show_dialog.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  //  SignUp METHOD

  Future<void> emailSignUp({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save username locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('saved_username', username);

      await sendEmailVerification(context);
      showFirebaseDialog(context,
          '📩 Verification email sent. Please check your inbox to verify your email.');

      // Poll until verified
      bool isVerified = false;
      while (!isVerified) {
        await Future.delayed(const Duration(seconds: 3));
        await _auth.currentUser?.reload();
        isVerified = _auth.currentUser?.emailVerified ?? false;
      }

      showFirebaseDialog(
          context, '✅ Account successfully created. You can now sign in.');
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, PageRoutes.login.name);
    } on FirebaseAuthException catch (e) {
      showFirebaseDialog(context, e.message ?? 'Something went wrong');
    }
  }

  // LOGIN METHOD
  Future<void> emailSignIn({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Validate username locally
      final prefs = await SharedPreferences.getInstance();
      final savedUsername = prefs.getString('saved_username') ?? '';

      if (savedUsername != username) {
        showFirebaseDialog(context, '❌ Incorrect username');
        await _auth.signOut(); // sign out invalid login
        return;
      }

      if (userCred.user!.emailVerified) {
        showFirebaseDialog(context, '✅ Login Successful').then((value) {
          Navigator.pushReplacementNamed(context, PageRoutes.dashBoard.name);
        });
      } else {
        showFirebaseDialog(context, 'Email not verified');
      }
    } on FirebaseAuthException catch (e) {
      showFirebaseDialog(context, e.message ?? 'Something went wrong');
    }
  }

  // EMAIL VERIFICATION MESSAGE
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      showFirebaseDialog(context,
          'Please check your inbox to verify your email before logging in');
    } on FirebaseAuthException catch (e) {
      (context, e.message!);
    }
  }

  void signOut(BuildContext context) {
    try {
      _auth.signOut();
    } on FirebaseException catch (e) {
      showFirebaseDialog(context, e.message!);
    }
  }

  // Password Reset Method
  Future<void> passwordReset(
      {required String email, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showFirebaseDialog(context, 'Reset link sent! Check your email.');
    } on FirebaseException catch (e) {
      String errorMessage = 'Something went wrong';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email';
      }
      showFirebaseDialog(context, errorMessage);
    }
  }

  //  Google SignIn
  signInWithGoogle() async {
    // sighn Out
    await GoogleSignIn().signOut();
    // lets begin the interactive process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // request user auth details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // create new user credentials
    final credentials = GoogleAuthProvider.credential(
        idToken: gAuth.idToken, accessToken: gAuth.accessToken);
    // finally let's sign In
    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }
}
