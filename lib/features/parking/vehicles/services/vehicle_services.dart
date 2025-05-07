import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/parking/vehicles/api/vehicle_api.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';

class VehicleServices {
  var vehicleApi = VehicleApi();

  Future<List<VehicleModel>> fetchVehicles() async {
    try {
      var response = await vehicleApi.fetchVehicles();
      if (response.success || response.data != null) {
        final dataMap = response.data as Map<String, dynamic>;
        List<dynamic> vehiclesList = dataMap['vehicles'];

        DevLogs.logInfo("Fetched Vehicles in services: ${vehiclesList.length}");

        // Check if the items in vehiclesList are already VehicleModel instances
        if (vehiclesList.isNotEmpty && vehiclesList.first is VehicleModel) {
          return vehiclesList.cast<VehicleModel>();
        }

        // Otherwise, map the JSON objects to VehicleModel instances
        return vehiclesList
            .map((vehicle) =>
                VehicleModel.fromJson(vehicle as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return [];
    }
    return [];
  }

  Future<bool> addVehicle(VehicleModel vehicle) async {
    try {
      var response = await vehicleApi.addVehicle(vehicle);
      if (response.success) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return false;
    }
  }

  Future<bool> submitVehicle({
    required String plateNumber,
    required String brand,
    required String model,
    required String color,
    required String vehicleType,
  }) async {
    VehicleModel vehicle = VehicleModel(
      plate_number: plateNumber,
      brand: brand,
      model: model,
      color: color,
      vehicle_type: vehicleType,
    );
    try {
      var response = await addVehicle(vehicle);
      if (response) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return false;
    }
  }

  Future<bool> deleteVehicle(String id) async {
    try {
      var response = await vehicleApi.deleteVehicle(id);
      if (response.success) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return false;
    }
  }

  Future<bool> updateVehicle(VehicleModel vehicle) async {
    try {
      var response = await vehicleApi.updateVehicle(vehicle);
      if (response.success) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return false;
    }
  }

  Future<VehicleModel?> getVehicleById(String id) async {
    try {
      var response = await vehicleApi.getVehicleById(id);
      if (response.success) {
        final dataMap = response.data as Map<String, dynamic>;
        return VehicleModel.fromJson(dataMap);
      } else {
        return null;
      }
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return null;
    }
  }
}
