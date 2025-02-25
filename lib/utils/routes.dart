import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/main_nav/main_navigation.dart';
import 'package:portal/features/announcements/views/announcements_add.dart';
import 'package:portal/features/notifications/notifications_main.dart';
import 'package:portal/features/profile/profile_main.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainNavigation();
      },
    ),
    GoRoute(
      path: '/announcements_add',
      builder: (BuildContext context, GoRouterState state) {
        return const AnnouncementsAdd();
      },
    ),
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
  ],
);
