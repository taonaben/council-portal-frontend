import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/main_nav/main_navigation.dart';
import 'package:portal/features/alida_ai/alida_ai_main.dart';
import 'package:portal/features/announcements/views/announcement_detail.dart';
import 'package:portal/features/announcements/views/announcements_add.dart';
import 'package:portal/features/announcements/views/announcements_main.dart';
import 'package:portal/features/business_management/businesses_main.dart';
import 'package:portal/features/dashboard/dashboard_main.dart';
import 'package:portal/features/issues/issues_main.dart';
import 'package:portal/features/notifications/notifications_main.dart';
import 'package:portal/features/parking_management/parking_main.dart';
import 'package:portal/features/profile/profile_main.dart';
import 'package:portal/features/properties_management/properties_main.dart';
import 'package:portal/features/settings/settings_main.dart';
import 'package:portal/features/water_management/water_main.dart';

final GoRouter router = GoRouter(
  initialLocation: '/dashboard', // Move this here
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainNavigation(child: child); // Pass child as content
      },
      routes: [
        GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardMain()),
        GoRoute(
            path: '/announcements',
            builder: (context, state) => const AnnouncementsMain()),
        GoRoute(
            path: '/issues', builder: (context, state) =>  IssuesMain()),
        GoRoute(path: '/water', builder: (context, state) => const WaterMain()),
        GoRoute(
            path: '/businesses',
            builder: (context, state) => const BusinessesMain()),
        GoRoute(
            path: '/parking', builder: (context, state) => const ParkingMain()),
        GoRoute(
            path: '/properties',
            builder: (context, state) => const PropertiesMain()),
        GoRoute(
            path: '/alida-ai',
            builder: (context, state) => const AlidaAiMain()),
        GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsMain()),
        GoRoute(
            path: '/announcements_add',
            builder: (context, state) => const AnnouncementsAdd()),
        GoRoute(
          path: '/announcement/:id', // Define the dynamic parameter with `:id`
          builder: (context, state) {
            // Get the ID from params
            final String? id = state.pathParameters['id'];

            // Find the correct announcement based on the ID
            final announcement = announcements.firstWhere(
              (a) => a['id'] == id,
              orElse: () => {}, // Handle missing announcements
            );

            // Pass it to AnnouncementDetail
            return AnnouncementDetail(announcement: announcement);
          },
        ),
      ],
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
