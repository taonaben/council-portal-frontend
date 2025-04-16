import 'package:flutter/material.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/constants/colors/dimensions.dart';
import 'package:portal/role-client/features/parking/vehicles/models/vehicle_model.dart';

class VehicleCard extends StatelessWidget {
  final VehicleModel vehicle;
  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background1,
      elevation: 2,
      shadowColor: secondaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(uniBorderRadius),
          side: const BorderSide(color: secondaryColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: leadingImage(),
          title: Text(
            vehicle.plate_number,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            "${vehicle.brand} ${vehicle.model}",
            style: const TextStyle(color: secondaryColor),
          ),
        ),
      ),
    );
  }

  Widget leadingImage() {
    return Stack(children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(uniBorderRadius),
          child: Image.asset(vehicle.image)),
      Positioned(
        top: 6,
        right: 10,
        //shows active ticket on a car
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ]);
  }
}
