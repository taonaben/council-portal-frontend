import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
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
          // width: 2,
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
                Text(
                  vehiclePlate,
                  style: const TextStyle(
                    // fontFamily: GoogleFonts.staatliches().fontFamily,
                    color: textColor1,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(8),
            Text(vehicleName,
                style: const TextStyle(
                  color: textColor1,
                )),
          ],
        ),
      ),
    );
  }

  Widget buildContents() {
    return SizedBox(
      // height: 350, // Adjust this value based on your needs
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 3, // Adjust this value to control button height
        ),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return buildOptionButton(
            text: option['text'],
            icon: option['icon'],
            route: option['route'],
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> options = [
    {
      "text": "Find Parking",
      "icon": const Icon(
        Icons.location_on_outlined,
        color: textColor2,
      ),
      "route": "",
    },
    {
      "text": "Buy Ticket",
      "icon": const Icon(
        CupertinoIcons.ticket,
        color: textColor2,
      ),
      "route": "purchase-ticket",
    },
    {
      "text": "History",
      "icon": const Icon(
        CupertinoIcons.clock,
        color: textColor2,
      ),
      "route": "",
    },
    {
      "text": "My Cars",
      "icon": const Icon(
        Icons.directions_car_filled_outlined,
        color: textColor2,
      ),
      "route": "my-vehicles",
    },
    {
      "text": "Alerts",
      "icon": const Icon(
        CupertinoIcons.bell,
        color: textColor2,
      ),
      "route": "",
    },
    {
      "text": "Account",
      "icon": const Icon(
        Icons.settings_outlined,
        color: textColor2,
      ),
      "route": "",
    },
  ];

  Widget buildOptionButton({
    required String text,
    required Icon icon,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => context.pushNamed(route),
      child: Container(
        // width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(uniBorderRadius),
          border: Border.all(
            color: background2,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const Gap(8),
              Text(
                text,
                style: const TextStyle(
                  color: textColor2,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
