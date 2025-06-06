import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/core/navigation/main_navigation.dart';
import 'package:portal/features/accounts/model/account_model.dart';
import 'package:portal/features/accounts/views/account_main.dart';
import 'package:portal/features/auth/model/user_model.dart';
import 'package:portal/features/notifications/views/notification_settings.dart';
import 'package:portal/features/parking/main/parking_main.dart';
import 'package:portal/features/parking/tickets/model/parking_ticket_model.dart';
import 'package:portal/features/parking/tickets/views/bundles/bundle_purchase_successful.dart';
import 'package:portal/features/parking/tickets/views/bundles/buy_bundles_page.dart';
import 'package:portal/features/parking/tickets/views/bundles/my_bundles_page.dart';
import 'package:portal/features/parking/tickets/views/bundles/select_bundle_payment.dart';
import 'package:portal/features/parking/tickets/views/tickets/purchase_successful.dart';
import 'package:portal/features/parking/tickets/views/tickets/ticket_history_page.dart';
import 'package:portal/features/parking/tickets/views/tickets/ticket_purchase_summary_page.dart';
import 'package:portal/features/parking/tickets/views/tickets/tickets_main.dart';
import 'package:portal/features/parking/vehicles/api/vehicle_list.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';
import 'package:portal/features/parking/vehicles/views/vehicle_detail.dart';
import 'package:portal/features/parking/vehicles/views/vehicle_management.dart';
import 'package:portal/features/profile/profile_main.dart';
import 'package:portal/features/settings/settings.dart';
import 'package:portal/features/water/views/account_water_details.dart';
import 'package:portal/features/water/views/account_history_page.dart';
import 'package:portal/features/water/views/account_water_main.dart';
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
        name: "terms-of-service",
        builder: (context, state) => const TermsOfService()),
    GoRoute(
        path: '/privacy_policy',
        name: "privacy-policy",
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
                  path: '/buy_bundles',
                  name: "buy-bundles",
                  builder: (context, state) {
                    return const BuyBundlesPage();
                  },
                  routes: [
                    GoRoute(
                      path: "/select_bundle_payment",
                      name: "select-bundle-payment",
                      builder: (context, state) {
                        final bundle = state.extra as Map<String, dynamic>;
                        return SelectBundlePayment(
                          bundle: bundle,
                        );
                      },
                    ),
                    GoRoute(
                        path: '/purchase_successful',
                        name: "bundle-purchase-successful",
                        builder: (context, state) {
                          final bundle = state.extra as Map<String, dynamic>;
                          return BundlePurchaseSuccessfulPage(bundle: bundle);
                        }),
                  ],
                ),
                GoRoute(
                    path: '/purchase_successful',
                    name: "ticket-purchase-successful",
                    builder: (context, state) {
                      final ticketData = state.extra as ParkingTicketModel;
                      return TicketPurchaseSuccessfulPage(
                        ticketData: ticketData,
                      );
                    }),
              ]),
          GoRoute(
              path: '/my_bundles',
              name: "my-bundles",
              builder: (context, state) {
                final vehicleId = state.extra as String;
                return MyBundlesPage(
                  vehicleId: vehicleId,
                );
              }),
          GoRoute(
              path: '/ticket_history',
              name: "ticket-history",
              builder: (context, state) => const TicketHistoryPage()),
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
        path: '/client/water_bills_by_account/:account_id',
        name: "water-bills-by-account",
        builder: (context, state) {
          final accountId = int.parse(state.pathParameters['account_id']!);
          return AccountWaterBillsHistoryPage(accountId: accountId);
        }),
    GoRoute(
        path: '/client/account_detail',
        name: "account-detail",
        builder: (context, state) {
          final account = state.extra as AccountModel;
          return AccountWaterDetails(account: account);
        }),
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
    GoRoute(
        path: '/client/notification_settings',
        name: "notification-settings",
        builder: (context, state) => const NotificationSettings()),
  ],
);
