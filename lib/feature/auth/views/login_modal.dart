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
  bool _isTapped = false;
  bool isVisible = false;

  showModalBottomSheet(
    barrierColor: Colors.transparent.withOpacity(0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    isDismissible: true,
    enableDrag: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          void togglePasswordVisibility() {
            setState(() {
              isVisible = !isVisible;
            });
          }

          void signIn() async {
            await FirebaseAuthMethods(FirebaseAuth.instance).emailSignIn(
                username: _nameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                context: context);
          }

          String? validateEmail(String? email) {
            RegExp emailRegex =
                RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
            final isEmailValid = emailRegex.hasMatch(email ?? '');
            if (email!.isEmpty) {
              return 'This field is required';
            } else if (!isEmailValid) {
              return 'Invalid Email address';
            } else {
              return null;
            }
          }

          return SizedBox(
            height: 700,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
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
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Please enter your details to continue',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        Gap(8.h),
                        EmbarkTextfield(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return 'This field is required';
                            } else {
                              return null;
                            }
                          },
                          controller: _nameController,
                          labelText: 'Name',
                          hintText: 'Enter name',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                          prefixIcon: Icon(
                            Icons.person_outline_outlined,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const Gap(10),
                        EmbarkTextfield(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) => validateEmail(email),
                          controller: _emailController,
                          labelText: 'E-mail',
                          hintText: 'Enter email adress',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                          prefixIcon: Icon(
                            Icons.person_outline_outlined,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const Gap(10),
                        EmbarkTextfield(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return 'This field is required';
                            } else if (value.length < 7) {
                              return 'Enter atleast 6 characters';
                            } else {
                              return null;
                            }
                          },
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: 'Enter password',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                          obscureText: !isVisible,
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color: Colors.grey.shade600,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => togglePasswordVisibility(),
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
                          text: 'Login',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              signIn();
                            }
                          },
                          width: 200,
                        ),
                        Gap(10.h),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isTapped = true;
                            });
                            Navigator.pushNamed(
                                context, PageRoutes.forgotPassword.name);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                                decoration: _isTapped
                                    ? TextDecoration.underline
                                    : null),
                          ),
                        ),
                      ],
                    ),
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
