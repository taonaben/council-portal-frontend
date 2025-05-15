import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/auth/model/user_model.dart';
import 'package:portal/features/auth/services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _tryAutoLogin();
  }

  Future<void> _tryAutoLogin() async {
    final encodedUsername = await getSP('saved_username');
    final encodedPassword = await getSP('saved_password');
    final expiryString = await getSP('credentials_expiry');

    try {
      if (encodedUsername.isEmpty ||
          encodedPassword.isEmpty ||
          expiryString.isEmpty) {
        context.go("/login");
        return;
      }

      final expiry = DateTime.tryParse(expiryString);
      if (expiry != null && expiry.isAfter(DateTime.now())) {
        final username = utf8.decode(base64.decode(encodedUsername));
        final password = utf8.decode(base64.decode(encodedPassword));

        final AuthServices authServices = AuthServices();
        final User user = await authServices.login(username, password);
        if (user.id != null || user != User.empty()) {
          context.go('/home/0');
        } else {
          context.go("/login");
          const CustomSnackbar(message: 'Invalid credentials', color: redColor)
              .showSnackBar(context);
        }
      }
    } catch (e) {
      DevLogs.logError('Error in auto-login: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 👇 This widget creates a moving glare effect
  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Use sine wave for seamless looping
        final double t = _controller.value * 2 * math.pi;
        final double offset = math.sin(t); // oscillates between -1 and 1

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor.withOpacity(1),
                accentColor.withOpacity(0.9),
                background2.withOpacity(1),
              ],
              begin: Alignment(-1.0 + offset, -1),
              end: Alignment(1.0 - offset, 1),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    "lib/assets/images/portal_splash-removebg.png",
                    width: MediaQuery.of(context).size.width * 0.8,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  children: [
                    const Text(
                      "from",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Image.asset(
                      "lib/assets/images/company_logo-removebg.png",
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
