import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/parking/vehicles/api/vehicle_api.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';

class VehicleServices {
  var vehicleApi = VehicleApi();

  Future<List<VehicleModel>> fetchVehicles() async {
    try {
      var result = await vehicleApi.fetchVehicles();
      if (!result.success || result.data == null) {
        DevLogs.logError(
            'Error fetching vehicles: ${result.message ?? 'Unknown error'}');
        return [];
      }

      final dataMap = result.data as Map<String, dynamic>;
      final vehiclesList = dataMap['vehicles'] as List<dynamic>?;

      if (vehiclesList == null) {
        DevLogs.logError('Error: Vehicles list is null');
        return [];
      }

      return vehiclesList
          .map((vehicle) => VehicleModel.fromJson(vehicle))
          .toList();
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return [];
    }
  }
}
