import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/role-client/features/parking/componets/parking_main_section.dart';
import 'package:portal/role-client/features/parking/componets/parking_timer.dart';

class ParkingMainClient extends StatelessWidget {
  const ParkingMainClient({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(context),
          buildSubHeader(context),
          const Gap(16),
          ParkingTimer(),
          const Gap(8),
          ParkingMainSection(),
        ],
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
      "Park your vehicle and track the time",
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
