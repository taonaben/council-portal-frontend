import 'package:flutter/material.dart';

class CustomSnackbar {
  final String message;
  final Color color;
  final SnackBarAction? action;

  const CustomSnackbar({
    required this.message,
    required this.color,
    this.action,
  });

  void showSnackBar(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: color,
          duration: const Duration(seconds: 3),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          dismissDirection: DismissDirection.down,
          action: action,
        ),
      );
    });
  }
}
