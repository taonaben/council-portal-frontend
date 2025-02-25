import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/main_nav/main_navigation.dart';
import 'package:portal/features/alida_ai/alida_ai_main.dart';
import 'package:portal/features/notifications/notifications_main.dart';
import 'package:portal/features/profile/profile_main.dart';

final GoRouter router = GoRouter(
  routes: [
    // Main route of the app
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainNavigation();
      },
    ),
    // Add more routes here
    GoRoute(
      path: '/notifications',
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationsMain();
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileMain();
      },
    ),
    GoRoute(
      path: '/alida_ai',
      builder: (BuildContext context, GoRouterState state) {
        return const AlidaAiMain();
      },
    ),
  ],
);
