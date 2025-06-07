import 'package:Embark_mobile/feature/auth/auth_service/firebase_auth_method.dart';
import 'package:Embark_mobile/widget/login_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:Embark_mobile/components/buttons/gradient_button.dart';
import 'package:Embark_mobile/feature/auth/views/login_modal.dart';
import 'package:Embark_mobile/routes.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInState();
}

class _LogInState extends State<LogInView> {
  // bool _isTapped = false;
  bool isVisible = true;

  void togglePasswordVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const Gap(25),
            // Logo
            Center(
                child: Image.asset(
              'assets/images/others/embark_logo.png',
              height: 180,
              fit: BoxFit.cover,
            )),
            //  Embark
            // Gap(10.h),
            Text(
              'EMBARK!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 4,
                  fontSize: 30),
            ),
            // const Gap(20),
            // animation
            Container(
              color: Colors.transparent,
              height: 170,
              child: Lottie.asset(
                'assets/animations/browsing.json',
                reverse: true,
                repeat: true,
                fit: BoxFit.cover,
              ),
            ),
            // const Gap(10),
            // Info text
            Column(
              children: [
                Text(
                  'Welcome!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                Gap(10.h),
                Text(
                  'Discover products you\'ll love, \nwith personalized suggestions.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 15),
                ),
              ],
            ),
            Gap(10.h),
            GradientButton(
              text: 'Login',
              width: 300,
              onTap: () {
                setState(() {
                  showLoginModal(context);
                });
              },
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Divider(
                      // height: 5
                      thickness: .5,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'Or login with',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 15),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Divider(
                      // height: 5,
                      thickness: .5,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RoundBox(
                  imagePath: 'assets/images/others/apple.png',
                ),
                const Gap(50),
                RoundBox(
                  onTap: () => FirebaseAuthMethods(FirebaseAuth.instance)
                      .signInWithGoogle(),
                  imagePath: 'assets/images/others/google.png',
                ),
                const Gap(50),
                RoundBox(
                  onTap: () => FirebaseAuthMethods(FirebaseAuth.instance)
                      .signInWithFacebook(context),
                  imagePath: 'assets/images/others/facebook.png',
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 17)),
                const Gap(5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // _isTapped = true;
                    });
                    Navigator.pushNamed(context, PageRoutes.signUp.name);
                  },
                  child: Text(
                    'Sign Up.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
