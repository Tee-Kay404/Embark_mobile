import 'package:Embark_mobile/components/buttons/gradient_button.dart';
import 'package:Embark_mobile/components/textfields/embark_textfield.dart';
import 'package:Embark_mobile/feature/auth/auth_service/firebase_auth_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _color = Colors.grey.shade600;
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        );

    String? validateEmail(String? email) {
      RegExp emailRegex =
          RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      final isEmailValid = emailRegex.hasMatch(email ?? '');
      if (email!.isEmpty) {
        return 'This field is required';
      } else if (!isEmailValid) {
        return 'Invalid email';
      } else {
        return null;
      }
    }

    Future<void> resetPassword() async {
      await FirebaseAuthMethods(FirebaseAuth.instance)
          .passwordReset(email: _emailController.text.trim(), context: context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password!'),
        titleTextStyle:
            textStyle?.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 22.sp),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(30.h),
                const Icon(
                  Icons.lock,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 24),
                Text(
                  'Reset your password',
                  style: textStyle,
                ),
                const SizedBox(height: 12),
                Text(
                  'Enter your registered email and we’ll send you instructions to reset your password.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 32),
                EmbarkTextfield(
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(10)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) => validateEmail(email),
                  borderRadius: BorderRadius.circular(12),
                  hintText: 'Enter your email',
                  controller: _emailController,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: _color,
                  ),
                ),
                Gap(15.h),
                GradientButton(
                  onTap: () async {
                    final email = _emailController.text.trim();
                    final validationMessage = validateEmail(email);

                    if (validationMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(validationMessage)),
                      );
                      return;
                    }

                    setState(() {
                      _isLoading = true;
                    });

                    await resetPassword();

                    setState(() {
                      _isLoading = false;
                    });
                  },
                  width: double.infinity,
                  height: 50,
                  borderRadius: BorderRadius.circular(10),
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Send Reset Link',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                ),
                Gap(12.h),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(17)),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.grey.shade300),
                      splashFactory: NoSplash.splashFactory,
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)))),
                  child: Text(
                    'Back to Login',
                    style: textStyle?.copyWith(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
