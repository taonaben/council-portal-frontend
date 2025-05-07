import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/features/parking/main/componets/parking_main_section.dart';
import 'package:portal/features/parking/main/componets/parking_timer.dart';
import 'package:portal/features/parking/tickets/provider/parking_ticket_provider.dart';
import 'package:portal/features/parking/vehicles/provider/vehicle_provider.dart';

class ParkingMainClient extends ConsumerWidget {
  const ParkingMainClient({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeVehicleAsyncValue = ref.watch(activeVehicleProvider);
    final activeTicketAsyncValue = ref.watch(activeTicketProvider);

    return Scaffold(
      body: activeVehicleAsyncValue.when(
        data: (activeVehicle) {
          return activeTicketAsyncValue.when(
            data: (activeTicket) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(context),
                      buildSubHeader(context),
                      const Gap(16),
                      ParkingTimer(activeTicket: activeTicket!,),
                      const Gap(8),
                      ParkingMainSection(
                        activeVehicle: activeVehicle!,
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (err, stack) {
              CustomSnackbar(
                message: 'Error: $err',
                color: redColor,
              ).showSnackBar(context);
              return const SizedBox();
            },
            loading: () => const CustomCircularProgressIndicator(
              color: textColor2,
            ),
          );
        },
        error: (err, stack) {
          CustomSnackbar(
            message: 'Error: $err',
            color: redColor,
          ).showSnackBar(context);
          return const SizedBox();
        },
        loading: () => const CustomCircularProgressIndicator(
          color: textColor2,
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Text(
      "Parking",
      style: TextStyle(
        fontFamily: GoogleFonts.staatliches().fontFamily,
        color: textColor2,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
    );
  }

  Widget buildSubHeader(BuildContext context) {
    return Text(
      "Track and manage your spot",
      style: TextStyle(
        fontFamily: GoogleFonts.staatliches().fontFamily,
        color: textColor2,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.start,
    );
  }
}
