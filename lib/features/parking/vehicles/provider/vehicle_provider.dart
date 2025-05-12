import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/features/parking/vehicles/api/vehicle_list.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';
import 'package:portal/features/parking/vehicles/services/vehicle_services.dart';

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

final getVehicleByIdProvider =
    FutureProvider.family<VehicleModel, String>((ref, vehicleId) async {
  try {
    final vehicles = await ref.watch(allVehiclesProvider.future);
    return vehicles.firstWhere((vehicle) => vehicle.id == vehicleId);
  } catch (e) {
    throw Exception('Error fetching vehicle by ID: $e');
  }
});

final activeVehicleProvider = FutureProvider<VehicleModel?>((ref) async {
  try {
    final vehicles = await VehicleServices().fetchVehicles();
    return vehicles.firstWhere(
      (vehicle) => vehicle.is_active == true,
      // orElse: () => null,
    );
  } catch (e) {
    throw Exception('Error fetching active vehicle: $e');
  }
});
class ActiveVehicleNotifier extends StateNotifier<VehicleModel?> {
  ActiveVehicleNotifier() : super(null) {
    // Initialize with the active vehicle if one exists
    final activeVehicle = getActiveVehicle();
    if (activeVehicle != null) {
      state = VehicleModel.fromJson(activeVehicle);
    }
  }

  void setActiveVehicle(String vehicleId) {
    setVehicleActive(vehicleId);
    final activeVehicle = getActiveVehicle();
    if (activeVehicle != null) {
      state = VehicleModel.fromJson(activeVehicle);
    }
  }
}
