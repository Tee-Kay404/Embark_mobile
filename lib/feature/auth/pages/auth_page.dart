import 'package:Embark_mobile/feature/auth/views/log_in_view.dart';
import 'package:Embark_mobile/pages/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  final Map<String, dynamic> products;
  const AuthPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        // if user is logged In
        if (snapshot.hasData) {
          return Dashboard();
        } else {
          return LogInView();
        }
      },
    ));
  }
}
