import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/constants/colors/dimensions.dart';
import 'package:portal/role-client/features/parking/vehicles/models/vehicle_model.dart';

class VehicleCard extends StatefulWidget {
  final VehicleModel vehicle;
  const VehicleCard({super.key, required this.vehicle});

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: background1,
      elevation: 5,
      shadowColor: blackColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uniBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () => context.pushNamed(
            'vehicle-details',
            pathParameters: {'plate_number': widget.vehicle.plate_number},
            extra: widget.vehicle,
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(uniBorderRadius),
            child: Image.asset(widget.vehicle.image),
          ),
          title: Text(
            widget.vehicle.plate_number,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            "${widget.vehicle.brand} ${widget.vehicle.model}",
            style: const TextStyle(color: secondaryColor),
          ),
          trailing: buildStatusCard(),
        ),
      ),
    );
  }

  Widget buildStatusCard() {
    return GestureDetector(
      onTap: () => changeStatus(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        // margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color:
              widget.vehicle.is_active == true ? primaryColor : secondaryColor,
          borderRadius: BorderRadius.circular(uniBorderRadius),
        ),
        child: Text(
          widget.vehicle.is_active == true ? "Active" : "Inactive",
          style: const TextStyle(
            color: textColor1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  changeStatus() {
    setState(() {
      widget.vehicle.is_active = !widget.vehicle.is_active;
    });
  }
}
