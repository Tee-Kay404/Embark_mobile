import 'package:Embark_mobile/feature/auth/auth_service/firebase_auth_method.dart';
import 'package:Embark_mobile/feature/core/country_field.dart';
import 'package:Embark_mobile/widget/login_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:Embark_mobile/components/buttons/gradient_button.dart';
import 'package:Embark_mobile/components/textfields/embark_textfield.dart';
import 'package:Embark_mobile/feature/auth/views/login_modal.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();
final _formKey = GlobalKey<FormState>();
final _color = Colors.grey.shade600;

class _SignUpState extends State<SignUp> {
  bool obscuredPassword = true;
  bool _isTapped = false;
  bool _checked = false;
  String? selectedCountry;

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
  }

  String? validateUserName(String? userName) {
    RegExp userNameRegex = RegExp(r'^[A-Z][a-zA-Z]*$');
    final validUserName = userNameRegex.hasMatch(userName ?? '');
    if (userName!.isEmpty) {
      return 'This Field is required';
    } else if (!validUserName) {
      return 'Username should start with an uppercase';
    } else {
      return null;
    }
  }

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (email!.isEmpty) {
      return 'This field is required';
    } else if (!isEmailValid) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  void signUp() async {
    await FirebaseAuthMethods(FirebaseAuth.instance).emailSignUp(
        username: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  void togglePasswordVisibility() {
    setState(() {
      obscuredPassword = !obscuredPassword;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      obscuredPassword = !obscuredPassword;
    });
  }

  void checkbox(bool value) {
    setState(() {
      _checked = !_checked;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(28),
                  Text(
                    'Create an account',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                  const Gap(5),
                  Text(
                    'Welcome! Please enter your details.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey.shade500,
                    ),
                  ),
                  const Gap(17),
                  Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                  const Gap(8),
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
                    validator: (userName) => validateUserName(userName),
                    borderRadius: BorderRadius.circular(12),
                    hintText: 'Enter your name',
                    controller: _nameController,
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      color: _color,
                    ),
                  ),
                  const Gap(17),
                  Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                  const Gap(8),
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
                  Gap(17.h),
                  Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                  const Gap(8),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (value.length < 6) {
                        return 'Enter atleast 6 alpha-numeric characters';
                      }
                      return null;
                    },
                    borderRadius: BorderRadius.circular(12),
                    hintText: 'Enter your password',
                    obscureText: obscuredPassword,
                    controller: _passwordController,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: _color,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () => togglePasswordVisibility(),
                        icon: Icon(
                          obscuredPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade600,
                        )),
                  ),
                  Gap(17.h),
                  Text(
                    'Confirm Password',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                  const Gap(8),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required!';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match!';
                      }
                      return null;
                    },
                    borderRadius: BorderRadius.circular(12),
                    hintText: 'Confirm password',
                    obscureText: obscuredPassword,
                    controller: _confirmPasswordController,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: _color,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () => toggleConfirmPasswordVisibility(),
                        icon: Icon(
                          obscuredPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade600,
                        )),
                  ),
                  Gap(17.h),
                  Text(
                    'Location',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                  const Gap(8),
                  CountryField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select a country to sign up';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      selectedCountry = value;
                    },
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Theme.of(context).colorScheme.surface,
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                        value: _checked,
                        onChanged: (bool? value) {
                          setState(() {
                            _checked = value!;
                          });
                        },
                      ),
                      Gap(4.h),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 15.h,
                                  color: Colors.blueGrey.shade500,
                                  fontWeight: FontWeight.w500),
                              children: [
                            const TextSpan(
                              text: 'I agree to the',
                            ),
                            const WidgetSpan(
                                child: SizedBox(
                              width: 5,
                            )),
                            TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            const WidgetSpan(
                                child: SizedBox(
                              width: 5,
                            )),
                            const TextSpan(
                              text: 'and',
                            ),
                            const WidgetSpan(
                                child: SizedBox(
                              width: 5,
                            )),
                            TextSpan(
                                text: 'Privacy\n Policy',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ])),
                    ],
                  ),
                  const Gap(17),
                  GradientButton(
                    text: 'Sign Up',
                    onTap: () {
                      if (_formKey.currentState!.validate() &&
                          FirebaseAuth.instance.currentUser != null) {
                        _formKey.currentState!.save();
                        signUp();
                      } else {
                        return null;
                      }
                    },
                    width: double.infinity,
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Divider(
                            // height: 5,
                            thickness: .5,
                            color: Colors.grey.shade900),
                      ),
                      const Gap(10),
                      const Text(
                        'Or SignUp with',
                        style: TextStyle(fontSize: 15),
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
                      const RoundBox(
                        imagePath: 'assets/images/others/facebook.png',
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?',
                          style: TextStyle(
                            fontSize: 17,
                          )),
                      const Gap(5),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isTapped = true;
                          });
                          showLoginModal(context);
                        },
                        child: Text(
                          'Login.',
                          style: TextStyle(
                            fontSize: 17,
                            // fontWeight: FontWeight.bold,
                            decoration:
                                _isTapped ? TextDecoration.underline : null,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
