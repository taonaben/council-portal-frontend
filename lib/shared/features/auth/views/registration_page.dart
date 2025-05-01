import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/components/widgets/custom_textfield.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';

import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:portal/core/utils/enums.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool showConfirmPassword = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: registrationForm());
          },
        ),
      ),
    );
  }

  Widget registrationForm() {
    final passNotifier = ValueNotifier<CustomPassStrength?>(null);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontFamily: GoogleFonts.staatliches().fontFamily,
                color: textColor1,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            const Text(
              'Register to new account',
              style: TextStyle(
                color: textColor1,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            const Gap(24),
            buildRow(
              CustomTextfield(
                labelText: 'First Name',
                hintText: "enter your first name",
                validator: (p0) => p0!.isEmpty ? '*required' : null,
                textInputType: TextInputType.name,
                onSubmit: (p0) {
                  FocusScope.of(context).nextFocus();
                },
                controller: firstNameController,
              ),
              CustomTextfield(
                labelText: 'Last Name',
                hintText: "enter your last name",
                validator: (p0) => p0!.isEmpty ? '*required' : null,
                textInputType: TextInputType.name,
                onSubmit: (p0) {
                  FocusScope.of(context).nextFocus();
                },
                controller: lastNameController,
              ),
            ),
            buildRow(
              CustomTextfield(
                labelText: 'Username',
                hintText: "enter your username",
                validator: (p0) => p0!.isEmpty ? '*required' : null,
                textInputType: TextInputType.name,
                onSubmit: (p0) {
                  FocusScope.of(context).nextFocus();
                },
                controller: usernameController,
              ),
              CustomTextfield(
                labelText: 'Email',
                hintText: "enter your email",
                validator: (p0) => p0!.isEmpty ? '*required' : null,
                textInputType: TextInputType.emailAddress,
                onSubmit: (p0) {
                  FocusScope.of(context).nextFocus();
                },
                controller: emailController,
              ),
            ),
            CustomTextfield(
              labelText: 'Password',
              hintText: "enter your password",
              validator: (p0) => p0!.isEmpty ? '*required' : null,
              textInputType: TextInputType.visiblePassword,
              obscureText: !showPassword,
              onSubmit: (p0) {
                FocusScope.of(context).nextFocus();
              },
              onChanged: (value) {
                passNotifier.value = CustomPassStrength.calculate(text: value);
              },
              controller: passwordController,
              suffixIcon: IconButton(
                icon: Icon(
                  showPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                  color: textColor1,
                ),
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              ),
            ),
            CustomTextfield(
              labelText: 'Confirm Password',
              hintText: "confirm your password",
              validator: (p0) => p0!.isEmpty ? '*required' : null,
              textInputType: TextInputType.visiblePassword,
              obscureText: !showConfirmPassword,
              onSubmit: (p0) {
                FocusScope.of(context).nextFocus();
              },
              controller: confirmPasswordController,
              suffixIcon: IconButton(
                icon: Icon(
                  showConfirmPassword
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash,
                  color: textColor1,
                ),
                onPressed: () {
                  setState(() {
                    showConfirmPassword = !showConfirmPassword;
                  });
                },
              ),
            ),
            const Gap(8),
            PasswordStrengthChecker(
              strength: passNotifier,
              configuration: PasswordStrengthCheckerConfiguration(
                hasBorder: true,
                borderColor: primaryColor,
                inactiveBorderColor: textColor1,
                externalBorderRadius: BorderRadius.circular(uniBorderRadius),
                internalBorderRadius: BorderRadius.circular(uniBorderRadius),
                animationDuration: const Duration(milliseconds: 300),
                animationCurve: Curves.easeInOut,
                borderWidth: 1,
                showStatusWidget: true,
                // height: 8,
                statusWidgetAlignment: MainAxisAlignment.end,

                // height: 8s,
                width: double.infinity,
              ),
            ),
            buildRow(
              CustomTextfield(
                labelText: 'Phone Number',
                hintText: "enter your phone number",
                validator: (p0) => p0!.isEmpty ? '*required' : null,
                textInputType: TextInputType.phone,
                onSubmit: (p0) {
                  FocusScope.of(context).nextFocus();
                },
                controller: phoneNumberController,
              ),
              CustomTextfield(
                labelText: 'Country',
                hintText: "enter your country",
                validator: (p0) => p0!.isEmpty ? '*required' : null,
                textInputType: TextInputType.emailAddress,
                onSubmit: (p0) {
                  FocusScope.of(context).nextFocus();
                },
                controller: countryController,
              ),
            ),
            const Gap(30),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  color: textColor1,
                  fontSize: 12,
                ),
                children: [
                  const TextSpan(text: 'By signing up, you agree to our '),
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
                    text: 'Privacy Policy.',
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
            CustomFilledButton(
                btnLabel: "Register",
                onTap: () {
                  if (!checkFormValidity() || areControllersEmpty()) {
                    const CustomSnackbar(
                      message: "Please ensure all fields are filled correctly",
                      color: redColor,
                    ).showSnackBar(context);
                    return;
                  }

                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    const CustomSnackbar(
                      message: "Passwords do not match",
                      color: redColor,
                    ).showSnackBar(context);
                    return;
                  }

                  const CustomSnackbar(
                    message: "Successfully registered",
                    color: primaryColor,
                  ).showSnackBar(context);
                }),
            const Gap(16),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  color: textColor1,
                  fontSize: 12,
                ),
                children: [
                  const TextSpan(text: 'Already have an account? '),
                  TextSpan(
                    text: 'Login',
                    style: const TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.go('/login'),
                  ),
                ],
              ),
            ),
            const Gap(24),
            weakPasswordWarning()
          ],
        ),
      ),
    );
  }

  Widget buildRow(Widget left, Widget right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: left),
        const Gap(8),
        Expanded(child: right),
      ],
    );
  }

  bool areControllersEmpty() {
    return firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        countryController.text.isEmpty;
  }

  bool checkPasswordStrength(String password) {
    final strength = CustomPassStrength.calculate(text: password);
    if (strength == CustomPassStrength.weak) {
      return false; // Weak password
    } else if (strength == CustomPassStrength.medium) {
      return false; // Medium password
    } else {
      return true; // Strong password
    }
  }

  Widget weakPasswordWarning() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: orangeColor,
        borderRadius: BorderRadius.circular(uniBorderRadius),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Please choose a strong password that meets these requirements:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor1,
            ),
          ),
          Gap(8),
          Text(
            "• At least 8 characters long\n"
            "• Contains at least one uppercase letter\n"
            "• Contains at least one lowercase letter\n"
            "• Contains at least one number\n"
            "• Contains at least one special character",
            style: TextStyle(color: textColor1),
          ),
        ],
      ),
    );
  }

  bool checkFormValidity() {
    return _formKey.currentState!.validate() &&
        !areControllersEmpty() &&
        passwordController.text == confirmPasswordController.text &&
        checkPasswordStrength(passwordController.text);
  }
}
