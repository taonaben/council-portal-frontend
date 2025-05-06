import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';
import 'package:portal/features/parking/vehicles/provider/vehicle_provider.dart';

class ParkingMainSection extends ConsumerWidget {
  ParkingMainSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeVehicle = ref.watch(activeVehicleProvider);

    if (activeVehicle == null) {
      return const Center(child: Text("No vehicle data available"));
    }

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
          buildHeader(context, activeVehicle),
          buildContents(activeVehicle),
        ],
      ),
    );
  }

  String id = generateRandomString(26);

  Widget buildHeader(BuildContext context, VehicleModel vehicle) {
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
                  vehicle.plate_number,
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
            Text("${vehicle.brand} ${vehicle.model}",
                style: const TextStyle(
                  color: textColor1,
                )),
          ],
        ),
      ),
    );
  }

  Widget buildContents(VehicleModel vehicle) {
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
        "extra": vehicle,
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
      // {
      //   "text": "Alerts",
      //   "icon": const Icon(
      //     CupertinoIcons.bell,
      //     color: textColor2,
      //   ),
      //   "route": "",
      // },
      // {
      //   "text": "Account",
      //   "icon": const Icon(
      //     Icons.settings_outlined,
      //     color: textColor2,
      //   ),
      //   "route": "",
      // },
    ];
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
            extra: option['extra'],
            pathParameters: option['pathParameters'],
            context: context,
          );
        },
      ),
    );
  }

  Widget buildOptionButton({
    required String text,
    required Icon icon,
    required String route,
    required BuildContext context,
    Object? extra,
    Map<String, String>? pathParameters,
  }) {
    return GestureDetector(
      onTap: () {
        if (route.isNotEmpty) {
          context.pushNamed(
            route,
            extra: extra,
            pathParameters: pathParameters ?? {}, // Use an empty map if null
          );
        } else {
          // Handle cases where the route is empty
          print("Route is not defined for $text");
        }
      },
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
