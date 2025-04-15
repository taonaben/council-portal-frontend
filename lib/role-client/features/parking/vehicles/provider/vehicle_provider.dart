import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/role-client/features/parking/vehicles/models/vehicle_model.dart';
import 'package:portal/role-client/features/parking/vehicles/services/vehicle_services.dart';

final allVehiclesProvider = FutureProvider<List<VehicleModel>>((ref) async {
  try {
    return VehicleServices().fetchVehicles().then((value) {
      if (value.isNotEmpty) {
        return value;
      } else {
        throw Exception('No vehicles found');
      }
    });
  } catch (e) {
    throw Exception('Error fetching vehicles: $e');
  }
});
