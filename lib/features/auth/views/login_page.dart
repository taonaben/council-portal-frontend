import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/components/widgets/custom_textfield.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/auth/model/user_model.dart';
import 'package:portal/features/auth/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/features/auth/providers/auth_providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = false;
  bool rememberMe = false;
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _tryAutoLogin();
  // }

  // Future<void> _tryAutoLogin() async {
  //   final encodedUsername = await getSP('saved_username');
  //   final encodedPassword = await getSP('saved_password');
  //   final expiryString = await getSP('credentials_expiry');

  //   try {
  //     if (encodedUsername.isEmpty ||
  //         encodedPassword.isEmpty ||
  //         expiryString.isEmpty) {
  //       return;
  //     }

  //     if (encodedUsername != null &&
  //         encodedPassword != null &&
  //         expiryString != null) {
  //       final expiry = DateTime.tryParse(expiryString);
  //       if (expiry != null && expiry.isAfter(DateTime.now())) {
  //         final username = utf8.decode(base64.decode(encodedUsername));
  //         final password = utf8.decode(base64.decode(encodedPassword));
  //         setState(() => isLoading = true);
  //         final AuthServices authServices = AuthServices();
  //         final User? user = await authServices.login(username, password);
  //         if (user != null || user != User.empty()) {
  //           context.go('/home/0');
  //         } else {
  //           const CustomSnackbar(
  //                   message: 'Invalid credentials', color: redColor)
  //               .showSnackBar(context);
  //           setState(() {
  //             isLoading = false;
  //           });
  //         }
  //         setState(() => isLoading = false);
  //       }
  //     }
  //   } catch (e) {
  //     DevLogs.logError('Error in auto-login: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: background2,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth > 800
                ? constraints.maxWidth * 0.4 // Wider for larger screens
                : constraints.maxWidth * 0.9; // Narrower for mobile

            return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: width,
                  minHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: loginForm());
          },
        ),
      ),
    );
  }

  Widget loginForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        // Prevents overflow
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Ensures the form only takes needed space
            children: [
              Text(
                'Welcome, Login',
                style: TextStyle(
                  fontFamily: GoogleFonts.staatliches().fontFamily,
                  color: textColor1,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const Gap(24),
              CustomTextfield(
                labelText: 'Username',
                hintText: "enter your username or Email",
                validator: (p0) => p0!.isEmpty ? '*required' : null,
                textInputType: TextInputType.emailAddress,
                onSubmit: (p0) {
                  FocusScope.of(context).nextFocus();
                },
                controller: usernameController,
              ),
              const Gap(16),
              CustomTextfield(
                labelText: 'Password',
                validator: (p0) => p0!.isEmpty ? '*required' : null,
                textInputType: showPassword
                    ? TextInputType.text
                    : TextInputType.visiblePassword,
                hintText: 'enter your password',
                controller: passwordController,
                obscureText: !showPassword,
                onSubmit: (p0) {
                  FocusScope.of(context).nextFocus();
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash,
                    color: textColor1,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        activeColor: primaryColor,
                        checkColor: textColor2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: const BorderSide(
                          color: textColor1,
                          width: 1.5,
                        ),
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(color: textColor1),
                      ),
                    ],
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Forgot Password?',
                      style: const TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.go('/forgot-password'),
                    ),
                  ),
                ],
              ),
              const Gap(8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: textColor1,
                    fontSize: 12,
                  ),
                  children: [
                    const TextSpan(text: 'By signing in, you agree to our '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.go('/terms-of-service'),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.go('/privacy-policy'),
                    ),
                  ],
                ),
              ),
              const Gap(24),
              isLoading
                  ? const CustomCircularProgressIndicator(color: primaryColor)
                  : CustomFilledButton(
                      btnLabel: 'Login',
                      onTap: () async {
                        if (_formKey.currentState!.validate() &&
                            !areControllersEmpty()) {
                          if (isLoading) return; // Prevent multiple taps
                          login();
                        } else {
                          const CustomSnackbar(
                            message: 'Please fill in all fields',
                            color: redColor,
                          ).showSnackBar(context);
                        }
                      },
                    ),
              const Gap(16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: textColor1,
                    fontSize: 12,
                  ),
                  children: [
                    const TextSpan(text: 'Don\'t have an account? '),
                    TextSpan(
                      text: 'Register',
                      style: const TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.go('/register'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    setState(() {
      isLoading = true;
    });

    final AuthServices authServices = AuthServices();
    final User? user = await authServices.login(
      usernameController.text.trim(),
      passwordController.text.trim(),
    );

    if (user != null || user != User.empty()) {
      if (rememberMe) {
        await saveCredentials(
            usernameController.text.trim(), passwordController.text.trim());
      }
      context.go('/home/0');
      setState(() {
        isLoading = false;
      });
    } else {
      const CustomSnackbar(message: 'Invalid credentials', color: redColor)
          .showSnackBar(context);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveCredentials(String username, String password) async {
    // Simple encryption - you may want to use a more secure method
    final encodedUsername = base64.encode(utf8.encode(username));
    final encodedPassword = base64.encode(utf8.encode(password));

    await saveSP('saved_username', encodedUsername);
    await saveSP('saved_password', encodedPassword);
    await saveSP('credentials_expiry',
        DateTime.now().add(const Duration(days: 7)).toIso8601String());
  }

  bool areControllersEmpty() {
    return usernameController.text.isEmpty || passwordController.text.isEmpty;
  }
}
