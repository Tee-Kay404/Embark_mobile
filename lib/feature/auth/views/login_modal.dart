import 'package:Embark_mobile/feature/auth/auth_service/firebase_auth_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:Embark_mobile/components/buttons/gradient_button.dart';
import 'package:Embark_mobile/components/textfields/embark_textfield.dart';
import 'package:Embark_mobile/routes.dart';

void showLoginModal(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  showModalBottomSheet(
    barrierColor: Colors.transparent.withOpacity(0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    isDismissible: true,
    enableDrag: true,
    context: context,
    builder: (BuildContext context) {
      bool isLoading = false;
      bool isVisible = false;
      bool isTapped = false;

      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          void togglePasswordVisibility() {
            setState(() {
              isVisible = !isVisible;
            });
          }

          Future<void> signIn() async {
            setState(() => isLoading = true);
            await FirebaseAuthMethods(FirebaseAuth.instance).emailSignIn(
              username: _nameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text,
              context: context,
            );
            setState(() => isLoading = false);
          }

          return SizedBox(
            height: 700,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Gap(18),
                      Text('Login to your account',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                      const Gap(10),
                      Text(
                        'We need to authenticate you before proceeding',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Please enter your details to continue',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Gap(8.h),
                      EmbarkTextfield(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (name) {
                          if (name == null || name.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        controller: _nameController,
                        labelText: 'Name',
                        hintText: 'Enter name',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w500),
                        prefixIcon: Icon(Icons.person_outline_outlined,
                            color: Colors.grey.shade600),
                      ),
                      const Gap(10),
                      EmbarkTextfield(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) {
                          RegExp emailRegex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                          final isValid = emailRegex.hasMatch(email ?? '');
                          if (email == null || email.isEmpty) {
                            return 'This field is required';
                          } else if (!isValid) {
                            return 'Invalid Email address';
                          }
                          return null;
                        },
                        controller: _emailController,
                        labelText: 'E-mail',
                        hintText: 'Enter email address',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w500),
                        prefixIcon: Icon(Icons.email_outlined,
                            color: Colors.grey.shade600),
                      ),
                      const Gap(10),
                      EmbarkTextfield(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          } else if (value.length < 6) {
                            return 'Enter at least 6 characters';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        labelText: 'Password',
                        hintText: 'Enter password',
                        obscureText: !isVisible,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w500),
                        prefixIcon: Icon(Icons.lock_outlined,
                            color: Colors.grey.shade600),
                        suffixIcon: IconButton(
                          onPressed: togglePasswordVisibility,
                          icon: Icon(
                            isVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const Gap(20),
                      GradientButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await signIn();
                          }
                        },
                        width: 200,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      Gap(10.h),
                      GestureDetector(
                        onTap: () {
                          setState(() => isTapped = true);
                          Navigator.pushNamed(
                              context, PageRoutes.forgotPassword.name);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                              decoration:
                                  isTapped ? TextDecoration.underline : null),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
