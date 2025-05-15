import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portal/constants/dimensions.dart';

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
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 30,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(uniBorderRadius),
                  // border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Center(
                  child: Text(
                    message,
                    // style: const TextStyle(
                    //   color: Colors.white,
                    //   fontWeight: FontWeight.w500,
                    // ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Auto-dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
