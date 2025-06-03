import 'package:Embark_mobile/feature/util/show_dialog.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  //  SignUp METHOD

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> emailSignUp({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save username to Firestore
      await _firestore.collection('users').doc(userCred.user!.uid).set({
        'email': email,
        'username': username,
      });

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
      Navigator.pop(context);
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

      final userDoc =
          await _firestore.collection('users').doc(userCred.user!.uid).get();

      if (!userDoc.exists || userDoc['username'] != username) {
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
      showFirebaseDialog(context, e.message!);
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

  // Phone Method
  // Future<void> phoneSignIn({
  //   required BuildContext context,
  //   required String phoneNumber,
  // }) async {
  //   final codeController = TextEditingController();
  //   if (kIsWeb) {
  //     ConfirmationResult result = await _auth.signInWithPhoneNumber(
  //       phoneNumber,
  //     );
  //   } else {
  //     // for Android nd Ios
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await _auth.signInWithCredential(credential);
  //       },
  //       verificationFailed: (e) {
  //         showFirebaseDialog(context, e.message!);
  //       },
  //       codeSent: (String verificationId, int? resendToken) async {
  //         showOTPDialog(
  //           context: context,
  //           codeController: codeController,
  //           onPressed: () async {
  //             PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //               verificationId: verificationId,
  //               smsCode: codeController.text.trim(),
  //             );
  //             await _auth.signInWithCredential(credential);
  //             Navigator.of(context).pop();
  //           },
  //         );
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //   }
  // }

  // FaceBook Login
  // Future<void> signInWithFacebook(BuildContext context) async {
  //   try {
  // final LoginResult loginResult = await FacebookAuth.instance.login();
  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //     await _auth.signInWithCredential(facebookAuthCredential);
  //   } on FirebaseAuthException catch (e) {
  //     showFirebaseDialog(context, e.message!);
  //   }
  // }

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
