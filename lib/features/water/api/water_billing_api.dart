import 'dart:convert';

import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:dio/dio.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/water/model/water_bill_model.dart';

class WaterBillingApi {
  final Dio dio = Dio();
  Future<ApiResponse> getWaterBill() async {
    String url = "$baseUrl/water_bill_list/";
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
        return ApiResponse(
          success: true,
          data: response.data,
          message: "success",
        );
      } else {
        return ApiResponse(
          success: false,
          data: null,
          message: 'Failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        data: null,
        message: "An error occurred while fetching water bill data.",
      );
    }
  }

  Future<ApiResponse> getWaterBillById(String id) async {
    String url = "$baseUrl/water_bill/$id/";
    String token = await getSP("token");
    try {
      var response = await dio.get(url,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token ',
            },
          ));

      if (response.statusCode == 200) {
        return ApiResponse(
          success: true,
          data: response.data,
          message: "success",
        );
      } else {
        return ApiResponse(
          success: false,
          data: null,
          message: 'Failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        data: null,
        message: "An error occurred while fetching water bill data.",
      );
    }
  }

  Future<ApiResponse> getLatestWaterBill(int accountId) async {
    String url = "$baseUrl/water/latest_water_bill/$accountId/";
    String token = await getSP("token");
    try {
      var response = await dio.get(url,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token ',
            },
          ));

      DevLogs.logInfo('Response: ${response.data}');
      if (response.data != null && response.data is Map<String, dynamic>) {
        DevLogs.logInfo(response.data.runtimeType.toString());
        DevLogs.logInfo(
            'Response model: ${WaterBillModel.fromJson(Map<String, dynamic>.from(response.data))}');
      } else {
        DevLogs.logError('Invalid or null response data: ${response.data}');
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          data: {
            "water_bill": WaterBillModel.fromJson(
                Map<String, dynamic>.from(response.data))
          },
          message: "success",
        );
      } else {
        return ApiResponse(
          success: false,
          data: null,
          message: 'Failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      DevLogs.logError('Error in API call: $e');
      return ApiResponse(
        success: false,
        data: null,
        message: "An error [$e] occurred while fetching water bill data.",
      );
    }
  }

  Future<ApiResponse> payWaterBill(String id, double amount) async {
    String url = "$baseUrl/water_bill/$id/";
    String token = await getSP("token");
    try {
      var response = await dio.put(url,
          data: {"amount_paid": amount},
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token ',
            },
          ));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          data: response.data,
          message: "success",
        );
      } else {
        return ApiResponse(
          success: false,
          data: null,
          message: 'Failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        data: null,
        message: "An error occurred while paying the water bill.",
      );
    }
  }
}
