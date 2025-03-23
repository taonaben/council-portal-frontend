import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/main_nav/main_navigation.dart';
import 'package:portal/role-admin/features/alida_ai/alida_ai_main.dart';
import 'package:portal/shared/features/announcements/views/announcement_detail.dart';
import 'package:portal/shared/features/announcements/views/announcements_add.dart';
import 'package:portal/shared/features/announcements/views/announcements_main.dart';
import 'package:portal/role-admin/features/business_management/businesses_main.dart';
import 'package:portal/role-admin/features/dashboard/dashboard_main.dart';
import 'package:portal/role-admin/features/issues/issues_main.dart';
import 'package:portal/role-admin/features/licenses_management/licenses_main.dart';
import 'package:portal/role-admin/features/notifications/notifications_main.dart';
import 'package:portal/role-admin/features/parking_management/views/parking_main.dart';
import 'package:portal/role-admin/features/parking_management/views/tickets_page.dart';
import 'package:portal/role-admin/features/profile/profile_main.dart';
import 'package:portal/role-admin/features/properties_management/properties_main.dart';
import 'package:portal/role-admin/features/settings/settings_main.dart';
import 'package:portal/role-admin/features/water_management/water_main.dart';

final GoRouter router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainNavigation(child: child);
      },
      routes: [
        GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardMain()),
        GoRoute(
            path: '/announcements',
            builder: (context, state) => const AnnouncementsMain()),
        GoRoute(path: '/issues', builder: (context, state) => IssuesMain()),
        GoRoute(path: '/water', builder: (context, state) => const WaterMain()),
        GoRoute(
            path: '/licenses',
            builder: (context, state) => const LicensesMain()),
        GoRoute(
            path: '/businesses',
            builder: (context, state) => const BusinessesMain()),
        GoRoute(
            path: '/parking',
            builder: (context, state) => const ParkingMain(),
            routes: [
              GoRoute(
                path: '/tickets',
                builder: (context, state) {
                  tickets = tickets;

                  return TicketsPage(
                    tickets: tickets,
                    totalPages: 24,
                  );
                },
              ),
            ]),
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
          path: '/announcement/:id',
          builder: (context, state) {
            final String? id = state.pathParameters['id'];
            final announcement = announcements.firstWhere(
              (a) => a['id'] == id,
              orElse: () => {},
            );
            return AnnouncementDetail(announcement: announcement);
          },
        ),
      ],
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
    GoRoute(
      path: '/alida_ai',
      builder: (BuildContext context, GoRouterState state) {
        return const AlidaAiMain();
      },
    ),
  ],
);
