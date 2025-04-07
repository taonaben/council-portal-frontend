import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/constants/colors/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';

class ParkingMainSection extends StatefulWidget {
  const ParkingMainSection({super.key});

  @override
  State<ParkingMainSection> createState() => _ParkingMainSectionState();
}

class _ParkingMainSectionState extends State<ParkingMainSection> {
  String vehicleName = "Honda Civic Type R";
  String vehiclePlate = "AFE 8044";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(uniBorderRadius),
        border: Border.all(
          color: background2,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          buildHeader(),
          buildContents(),
        ],
      ),
    );
  }

  String id = generateRandomString(26);

  Widget buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: background2,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(uniBorderRadius),
          topRight: Radius.circular(uniBorderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            Row(
              children: [
                const Icon(
                  CupertinoIcons.car_detailed,
                  color: textColor1,
                  size: 14,
                ),
                const Gap(8),
                Text(
                  'ID: $id',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: textColor1,
                  ),
                ),
              ],
            ),
            const Gap(16),
            Text("Current Vehicle: $vehicleName",
                style: TextStyle(
                  color: textColor1,
                )),
            const Gap(8),
            Row(
              children: [
                Text(
                  vehiclePlate,
                  style: TextStyle(
                    // fontFamily: GoogleFonts.staatliches().fontFamily,
                    color: textColor1,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8),
                Tooltip(
                  message: "Change Vehicle",
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.arrow_right_arrow_left,
                      color: textColor1,
                      size: 28,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContents() {
    return Container();
  }
}
