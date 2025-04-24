import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/core/main_nav/role-admin/main_navigation_admin.dart';
import 'package:portal/core/main_nav/role-client/main_navigation_client.dart';
import 'package:portal/role-client/features/assets/assets_main.dart';
import 'package:portal/role-client/features/dashboard/dashboard_main.dart';
import 'package:portal/role-client/features/issues/issues_main.dart';
import 'package:portal/role-client/features/licensing/licensing_main.dart';
import 'package:portal/role-client/features/parking/main/parking_main.dart';
import 'package:portal/role-client/features/parking/tickets/views/buy_for_other_page.dart';
import 'package:portal/role-client/features/parking/tickets/views/purchase_successful.dart';
import 'package:portal/role-client/features/parking/tickets/views/ticket_purchase_summary_page.dart';
import 'package:portal/role-client/features/parking/tickets/views/tickets_main.dart';
import 'package:portal/role-client/features/parking/vehicles/api/vehicle_list.dart';
import 'package:portal/role-client/features/parking/vehicles/models/vehicle_model.dart';
import 'package:portal/role-client/features/parking/vehicles/views/vehicle_detail.dart';
import 'package:portal/role-client/features/parking/vehicles/views/vehicle_management.dart';
import 'package:portal/role-client/features/water/water_main.dart';
import 'package:portal/shared/features/alida_ai/alida_ai_main.dart';
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
import 'package:portal/shared/features/auth/providers/auth_providers.dart';
import 'package:portal/shared/features/auth/views/login_page.dart';




final GoRouter router = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,
  // extraCodec: const ExtraCodec(),
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
      redirect: (context, state) {
        final ref = ProviderScope.containerOf(context);
        final authState = ref.read(authNotifierProvider);

        if (authState.user == null) {
          // If not logged in, force login page
          return '/login';
        }

        final user = authState.user!;

        // Prevent non-admins from accessing admin routes
        if (state.uri.toString().startsWith('/admin') && !user.isStaff) {
          return '/client/dashboard'; // Redirect unauthorized users
        }

        // Prevent staff/admin from accessing client-only pages
        if (state.uri.toString().startsWith('/client') && user.isStaff) {
          return '/admin/dashboard';
        }

        return null; // No redirection if everything is fine
      },
    ),

    // 🔹 Admin Navigation
    ShellRoute(
      builder: (context, state, child) {
        return MainNavigationAdmin(child: child);
      },
      routes: [
        GoRoute(
            path: '/admin/dashboard',
            builder: (context, state) => const DashboardMain()),
        GoRoute(
            path: '/admin/announcements',
            builder: (context, state) => const AnnouncementsMain()),
        GoRoute(
            path: '/admin/issues',
            builder: (context, state) => const IssuesMain()),
        GoRoute(
            path: '/admin/water',
            builder: (context, state) => const WaterMain()),
        GoRoute(
            path: '/admin/licenses',
            builder: (context, state) => const LicensesMain()),
        GoRoute(
            path: '/admin/businesses',
            builder: (context, state) => const BusinessesMain()),
        GoRoute(
            path: '/admin/parking',
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
            path: '/admin/properties',
            builder: (context, state) => const PropertiesMain()),
        GoRoute(
            path: '/admin/alida-ai',
            builder: (context, state) => const AlidaAiMain()),
        GoRoute(
            path: '/admin/settings',
            builder: (context, state) => const SettingsMain()),
        GoRoute(
            path: '/admin/announcements_add',
            builder: (context, state) => const AnnouncementsAdd()),
        GoRoute(
          path: '/admin/announcement/:id',
          builder: (context, state) {
            final String? id = state.pathParameters['id'];
            final announcement = announcements.firstWhere(
              (a) => a['id'] == id,
              orElse: () => {},
            );
            return AnnouncementDetail(announcement: announcement);
          },
        ),
        GoRoute(
          path: '/admin/notifications',
          builder: (context, state) => const NotificationsMain(),
        ),
        GoRoute(
          path: '/admin/profile',
          builder: (context, state) => const ProfileMain(),
        ),
      ],
    ),

    // 🔹 Client Navigation
    ShellRoute(
      builder: (context, state, child) {
        return MainNavigationClient(child: child);
      },
      routes: [
        GoRoute(
            path: '/client/dashboard',
            builder: (context, state) => const DashboardMainClient()),
        GoRoute(
            path: '/client/announcements',
            builder: (context, state) => const AnnouncementsMain()),
        GoRoute(
            path: '/client/issues',
            builder: (context, state) => const IssuesMainClient()),
        GoRoute(
            path: '/client/water',
            builder: (context, state) => const WaterMainClient()),
        GoRoute(
            path: '/client/licenses',
            builder: (context, state) => const LicensingMainClient()),
        GoRoute(
            path: '/client/assets',
            builder: (context, state) => const AssetsMainClient()),
        GoRoute(
            path: '/client/parking',
            builder: (context, state) => const ParkingMainClient(),
            routes: [
              GoRoute(
                  path: '/purchase_ticket',
                  builder: (context, state) {
                    final vehicle = state.extra as VehicleModel;
                    return  TicketsMainClient(vehicle: vehicle);
                  },
                  name: "purchase-ticket",
                  routes: [
                    GoRoute(
                        path: '/ticket_purchase_summary',
                        name: "parking-ticket-purchase-summary",
                        builder: (context, state) {
                          final ticketData = state.extra as Map<String, dynamic>;
                          return  TicketPurchaseSummaryPage(ticketData: ticketData,);
                        }),
                    GoRoute(
                        path: '/buy_for_other',
                        name: "buy-parking-for-other",
                        builder: (context, state) =>
                            const BuyTicketForOtherPage()),
                        GoRoute(
                        path: '/purchase_successful', 
                        name: "ticket-purchase-successful",
                        builder: (context, state) {
                          final ticketData = state.extra as Map<String, dynamic>;
                          return  TicketPurchaseSuccessfulPage(ticketData: ticketData,);
                        }),
                  ]),
              GoRoute(
                  path: '/vehicles',
                  builder: (context, state) => const VehicleManagement(),
                  name: "my-vehicles",
                  routes: [
                    GoRoute(
                      path: 'vehicle_details/:plate_number',
                      name: 'vehicle-details',
                      builder: (context, state) {
                        final vehicle = state.extra as VehicleModel;
                        return VehicleDetail(vehicle: vehicle);
                      },
                    ),
                  ]),
            ]),
        GoRoute(
            path: '/client/alida-ai',
            builder: (context, state) => const AlidaAiMain()),
        GoRoute(
            path: '/client/settings',
            builder: (context, state) => const SettingsMain()),
      ],
    ),
  ],
);


