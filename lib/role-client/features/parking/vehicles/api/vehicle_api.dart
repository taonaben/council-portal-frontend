import 'package:portal/core/utils/api_response.dart';
import 'package:portal/role-client/features/parking/vehicles/api/vehicle_list.dart';

class VehicleApi {
  Future<ApiResponse> fetchVehicles() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      return ApiResponse(
        success: true,
        data: {'vehicles': vehicles},
        message: 'Vehicles fetched successfully',
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'vehicles': []},
      );
    }
  }
}
