import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/parking/vehicles/api/vehicle_list.dart';
import 'package:dio/dio.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';

class VehicleApi {
  final Dio dio = Dio();
  Future<ApiResponse> fetchVehicles() async {
    String url = "$baseUrl/vehicles/all";
    String token = await getSP("token");

    try {
      var response = await dio.get(url,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<VehicleModel> vehicles = (response.data as List)
            .map((vehicle) => VehicleModel.fromJson(vehicle))
            .toList();

        return ApiResponse(
          success: true,
          message: "success",
          data: {'vehicles': vehicles},
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'vehicles': []},
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'vehicles': []},
      );
    }
  }

  Future<ApiResponse> getVehicleById(String id) async {
    String url = "$baseUrl/vehicles/$id";
    String token = await getSP("token");

    try {
      var response = await dio.get(url,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200 || response.statusCode == 201) {
        VehicleModel vehicle = VehicleModel.fromJson(response.data);
        return ApiResponse(
          success: true,
          message: "success",
          data: vehicle,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: null,
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ApiResponse> addVehicle(VehicleModel vehicle) async {
    String url = "$baseUrl/vehicles/all";
    String token = await getSP("token");

    try {
      var response = await dio.post(url,
          data: vehicle.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: "Vehicle added successfully",
          data: response.data,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: response.data,
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ApiResponse> updateVehicle(VehicleModel vehicle) async {
    String url = "$baseUrl/vehicles/${vehicle.id}";
    String token = await getSP("token");

    try {
      var response = await dio.patch(url,
          data: vehicle.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: "Vehicle updated successfully",
          data: response.data,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: response.data,
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ApiResponse> deleteVehicle(String id) async {
    String url = "$baseUrl/vehicles/$id";
    String token = await getSP("token");

    try {
      var response = await dio.delete(url,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: "Vehicle deleted successfully",
          data: response.data,
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: response.data,
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: null,
      );
    }
  }
}
