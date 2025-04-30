import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/role-client/features/parking/vehicles/components/vehicle_card.dart';
import 'package:portal/role-client/features/parking/vehicles/provider/vehicle_provider.dart';

class VehicleManagement extends ConsumerStatefulWidget {
  const VehicleManagement({super.key});

  @override
  ConsumerState<VehicleManagement> createState() => _VehicleManagementState();
}

class _VehicleManagementState extends ConsumerState<VehicleManagement> {
  @override
  Widget build(BuildContext context) {
    final allVehiclesAsyncValue = ref.watch(allVehiclesProvider);
    return allVehiclesAsyncValue.when(
      data: (vehicles) {
        if (vehicles.isEmpty) {
          return const Center(
            child: Text('No vehicles found'),
          );
        } else {
          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return VehicleCard(vehicle: vehicle);
            },
          );
        }
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
  }
}
