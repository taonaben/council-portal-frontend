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
import 'package:portal/shared/features/auth/model/user_model.dart';
import 'package:portal/shared/features/auth/services/auth_services.dart';
import 'package:portal/shared/features/auth/users_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/shared/features/auth/providers/auth_providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = false;
  bool rememberMe = false;
  bool isLoading = false;

  @override
  void dispose() {
    usernameEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: background2,
      appBar: AppBar(
        backgroundColor: background2,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => context.go('/register'),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(color: textColor1, fontSize: 14),
                  ),
                  Gap(8),
                  Icon(
                    CupertinoIcons.arrow_right,
                    color: textColor1,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
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
                child: loginForm(authNotifier));
          },
        ),
      ),
    );
  }

  Widget loginForm(AuthNotifier authNotifier) {
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
                controller: usernameEmailController,
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
                        if (_formKey.currentState!.validate()) {
                          if (isLoading) return; // Prevent multiple taps
                          login();
                        } else {
                          const CustomSnackbar(
                            message: 'Please fill in all fields',
                            color: redColor,
                          ).showSnackBar(context);
                        }
                        DevLogs.logInfo(
                            'Login button pressed with username: ${usernameEmailController.text} and password: ${passwordController.text}');
                      },
                    ),
              const Gap(16),
              TextButton(
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: textColor1),
                ),
                onPressed: () {
                  context.go('/forgot-password');
                },
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
      usernameEmailController.text.trim(),
      passwordController.text.trim(),
    );

    if (user != null && user != User.empty()) {
      if (rememberMe) {
        await saveCredentials(usernameEmailController.text.trim(),
            passwordController.text.trim());
      }
      if (user.is_staff!) {
        context.go('/admin/dashboard');
      } else {
        context.go('/client/dashboard');
      }
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

  Future<void> saveCredentials(String email, String password) async {
    // Simple encryption - you may want to use a more secure method
    final encodedEmail = base64.encode(utf8.encode(email));
    final encodedPassword = base64.encode(utf8.encode(password));

    await saveSP('saved_email', encodedEmail);
    await saveSP('saved_password', encodedPassword);
    await saveSP('credentials_expiry',
        DateTime.now().add(const Duration(days: 7)).toIso8601String());
  }
}
