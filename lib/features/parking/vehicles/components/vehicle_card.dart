import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/parking/vehicles/api/vehicle_api.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';
import 'package:portal/features/parking/vehicles/provider/vehicle_provider.dart';

class VehicleCard extends ConsumerStatefulWidget {
  final VehicleModel vehicle;
  const VehicleCard({super.key, required this.vehicle});

  @override
  ConsumerState<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends ConsumerState<VehicleCard> {
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
            child: widget.vehicle.image != null &&
                    widget.vehicle.image!.isNotEmpty
                ? Image.network(
                    widget.vehicle.image!,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.error,
                      color: secondaryColor,
                    ),
                  )
                : const Icon(
                    Icons.directions_car,
                    color: secondaryColor,
                  ),
          ),
          title: Text(
            widget.vehicle.plate_number,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            "${widget.vehicle.brand.toLowerCase()} ${widget.vehicle.model.toLowerCase()}",
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
        decoration: BoxDecoration(
          color: widget.vehicle.is_active! ? primaryColor : secondaryColor,
          borderRadius: BorderRadius.circular(uniBorderRadius),
        ),
        child: Text(
          widget.vehicle.is_active! ? "Current" : "Activate",
          style: const TextStyle(
            color: textColor1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  bool isLoading = false;

  Future<void> changeStatus() async {
    if (widget.vehicle.is_active!) {
      CustomSnackbar(
              message: "${widget.vehicle.plate_number} is already active",
              color: secondaryColor)
          .showSnackBar(context);
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CustomCircularProgressIndicator(color: textColor2),
            ));

    final vehicleApi = VehicleApi();
    final updatedVehicle =
        widget.vehicle.copyWith(is_active: !widget.vehicle.is_active!);

    // Call API to update the backend
    final response = await vehicleApi.updateVehicle(updatedVehicle);

    if (response.success) {
      setState(() {
        widget.vehicle.is_active = updatedVehicle.is_active;
        // isLoading = !isLoading;
      });

      ref.refresh(allVehiclesProvider);
      ref.refresh(activeVehicleProvider);
      Navigator.pop(context);
      CustomSnackbar(
              message: "${widget.vehicle.plate_number} active",
              color: primaryColor)
          .showSnackBar(context);

      DevLogs.logInfo('Vehicle status updated to ${updatedVehicle.is_active}');
    } else {
      const CustomSnackbar(
              message: "Failed to update status, please try again later",
              color: redColor)
          .showSnackBar(context);
      DevLogs.logError('Failed to update status: ${response.message}');
    }
  }
}
