import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/core/navigation/main_navigation.dart';
import 'package:portal/features/accounts/views/account_main.dart';
import 'package:portal/features/auth/model/user_model.dart';
import 'package:portal/features/parking/main/parking_main.dart';
import 'package:portal/features/parking/tickets/views/buy_for_other_page.dart';
import 'package:portal/features/parking/tickets/views/purchase_successful.dart';
import 'package:portal/features/parking/tickets/views/ticket_purchase_summary_page.dart';
import 'package:portal/features/parking/tickets/views/tickets_main.dart';
import 'package:portal/features/parking/vehicles/api/vehicle_list.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';
import 'package:portal/features/parking/vehicles/views/vehicle_detail.dart';
import 'package:portal/features/parking/vehicles/views/vehicle_management.dart';
import 'package:portal/features/profile/profile_main.dart';
import 'package:portal/features/settings/settings.dart';
import 'package:portal/features/water/views/water_main.dart';
import 'package:portal/features/alida_ai/alida_ai_main.dart';
import 'package:portal/features/auth/providers/auth_providers.dart';
import 'package:portal/features/auth/views/login_page.dart';
import 'package:portal/features/documents/privacy_policy.dart';
import 'package:portal/features/documents/terms_of_service.dart';

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
        if (state.uri.toString().startsWith('/admin') && !user.is_staff!) {
          return '/client/dashboard'; // Redirect unauthorized users
        }

        // Prevent staff/admin from accessing client-only pages
        if (state.uri.toString().startsWith('/client') && user.is_staff!) {
          return '/admin/dashboard';
        }

        return null; // No redirection if everything is fine
      },
    ),
    GoRoute(
        path: '/home/:current_page',
        name: "home",
        builder: (context, state) {
          final currentPage =
              int.parse(state.pathParameters['current_page'] ?? '0');
          return MainNavigation(currentIndex: currentPage);
        }),
    GoRoute(
        path: '/terms-of-service',
        builder: (context, state) => const TermsOfService()),
    GoRoute(
        path: '/privacy-policy',
        builder: (context, state) => const PrivacyPolicy()),
    GoRoute(
        path: '/client/parking',
        builder: (context, state) => const ParkingMainClient(),
        routes: [
          GoRoute(
              path: '/purchase_ticket',
              builder: (context, state) {
                final vehicle = state.extra as VehicleModel;
                return TicketsMainClient(vehicle: vehicle);
              },
              name: "purchase-ticket",
              routes: [
                GoRoute(
                    path: '/ticket_purchase_summary',
                    name: "parking-ticket-purchase-summary",
                    builder: (context, state) {
                      final ticketData = state.extra as Map<String, dynamic>;
                      return TicketPurchaseSummaryPage(
                        ticketData: ticketData,
                      );
                    }),
                GoRoute(
                    path: '/buy_for_other',
                    name: "buy-parking-for-other",
                    builder: (context, state) => const BuyTicketForOtherPage()),
                GoRoute(
                    path: '/purchase_successful',
                    name: "ticket-purchase-successful",
                    builder: (context, state) {
                      final ticketData = state.extra as Map<String, dynamic>;
                      return TicketPurchaseSuccessfulPage(
                        ticketData: ticketData,
                      );
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
    GoRoute(
        path: '/client/profile',
        name: "user_profile",
        builder: (context, state) {
          final user = state.extra as User;
          return ProfileMain(user: user);
        }),
    GoRoute(
        path: '/client/accounts',
        name: "accounts",
        builder: (context, state) => const AccountMain()),
  ],
);
