import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/components/widgets/custom_textfield.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/shared/features/auth/model/user_model.dart';
import 'package:portal/shared/features/auth/provider/user_provider.dart';
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
              const Gap(24),
              CustomFilledButton(
                btnLabel: 'Login',
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await authNotifier.login(
                      usernameEmailController.text,
                      passwordController.text,
                    );
                    if (success) {
                      if (authNotifier.state.user!.isStaff) {
                        context.go('/admin/dashboard');
                      } else {
                        context.go('/client/dashboard');
                      }
                    } else {
                      const CustomSnackbar(
                              message: 'Invalid credentials', color: redColor)
                          .showSnackBar(context);
                    }
                  }
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

  User? login(String emailUser, String password) {
    for (var user in users) {
      if ((emailUser == user['email_address'] ||
              emailUser == user['username']) &&
          password == user['password']) {
        return User(
          id: user['id'],
          username: user['username'],
          firstName: user['first_name'],
          lastName: user['last_name'],
          emailAddress: user['email_address'],
          phoneNumber: user['phone_number'],
          city: user['city'],
          isAdmin: user['isAdmin'],
          isStaff: user['isStaff'],
          isActive: user['isActive'],
        );
      }
    }
    return null;
  }
}
