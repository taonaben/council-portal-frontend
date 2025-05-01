import 'package:flutter/material.dart';
import 'package:portal/constants/colors.dart';

import 'package:password_strength_checker/password_strength_checker.dart';

enum CustomPassStrength implements PasswordStrengthItem {
  weak,
  medium,
  strong,
  secure;

  @override
  Color get statusColor {
    switch (this) {
      case CustomPassStrength.weak:
        return redColor;
      case CustomPassStrength.medium:
        return Colors.deepOrangeAccent;
      case CustomPassStrength.strong:
        return primaryColor.withOpacity(.8);
      case CustomPassStrength.secure:
        return const Color(0xFF0B6C0E);
    }
  }

  @override
  Widget? get statusWidget {
    switch (this) {
      case CustomPassStrength.weak:
        return const Text('Weak',
            style: TextStyle(
              color: textColor1,
            ));
      case CustomPassStrength.medium:
        return const Text('Medium',
            style: TextStyle(
              color: textColor1,
            ));
      case CustomPassStrength.strong:
        return const Text('Strong',
            style: TextStyle(
              color: textColor1,
            ));
      case CustomPassStrength.secure:
        return const Text('Secure',
            style: TextStyle(
              color: textColor1,
            ));
    }
  }

  @override
  double get widthPerc {
    switch (this) {
      case CustomPassStrength.weak:
        return 0.15;
      case CustomPassStrength.medium:
        return 0.4;
      case CustomPassStrength.strong:
        return 0.75;
      case CustomPassStrength.secure:
        return 1.0;
    }
  }

  static CustomPassStrength? calculate({required String text}) {
    if (text.isEmpty) {
      return null;
    }

    // Check common dictionary first
    if (commonDictionary[text] == true) {
      return CustomPassStrength.weak;
    }

    // Check minimum length requirement
    if (text.length < kDefaultStrengthLength) {
      return CustomPassStrength.weak;
    }

    var counter = 0;
    if (text.contains(RegExp(r'[a-z]'))) counter++;
    if (text.contains(RegExp(r'[A-Z]'))) counter++;
    if (text.contains(RegExp(r'[0-9]'))) counter++;
    if (text.contains(RegExp(r'[!@#\$%&*()?£\-_=]'))) counter++;

    // Return strength based on criteria met and length
    if (counter >= 4 && text.length >= kDefaultStrengthLength) {
      return CustomPassStrength.secure;
    } else if (counter >= 3) {
      return CustomPassStrength.strong;
    } else if (counter >= 2) {
      return CustomPassStrength.medium;
    } else {
      return CustomPassStrength.weak;
    }
  }
}
