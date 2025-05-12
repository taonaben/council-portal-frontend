import 'dart:convert';

import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/parking/vehicles/api/vehicle_list.dart';
import 'package:dio/dio.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';

class VehicleApi {
  final Dio dio = Dio();
  Future<ApiResponse> fetchVehicles() async {
    String url = "$baseUrl/vehicles/all/";
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
        var jsonResponse = response.data; // Use response.data directly

        List<dynamic> data = jsonResponse["results"];

        List<VehicleModel> vehicles =
            data.map((vehicle) => VehicleModel.fromJson(vehicle)).toList();

        DevLogs.logInfo("Fetched vehicles in Api: ${vehicles.length}");
        DevLogs.logInfo(
            "Fetched vehicles in Api: ${vehicles.map((vehicle) => vehicle.toJson()).toList()}");

        return ApiResponse(
          success: true,
          message: "success",
          data: {'vehicles': vehicles},
        );
      } else {
        DevLogs.logError(
            "Failed with status code in api: ${response.statusCode}");
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'vehicles': []},
        );
      }
    } catch (e) {
      DevLogs.logError("Error in api: $e");
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
    String url = "$baseUrl/vehicles/${vehicle.id}/";
    String token = await getSP("token");

    DevLogs.logInfo("Patching: $url");
    DevLogs.logInfo("Payload being sent: ${vehicle.toJson()}");

    try {
      var response = await dio.put(url,
          data: vehicle.toJson(),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      DevLogs.logInfo("Status code: ${response.statusCode}");
      DevLogs.logInfo("Response data: ${response.data}");

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
      if (e is DioException) {
        DevLogs.logError("DioException: ${e.response?.data}");
      } else {
        DevLogs.logError("Error: $e");
      }
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
