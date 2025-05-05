import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';

import 'package:http/http.dart' as http;

class UserApi {
  Future<ApiResponse> getUser(int userId) async {
    String token = await getSP("token");
    if (token.isEmpty) {
      return ApiResponse(
        success: false,
        message: 'No authentication token found',
        data: null,
      );
    }

    final url = Uri.parse("$baseUrl/users/$userId");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          success: true,
          data: decodedData,
          message: 'Success',
        );
      } else {
        return ApiResponse(
          success: false,
          data: null,
          message: 'Server returned ${response.statusCode}',
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

  Future<ApiResponse> updateUser(int userId, Map<String, dynamic> data) async {
    final url = Uri.parse("$baseUrl/users/$userId");
    String token = await getSP("token");

    if (token.isEmpty) {
      return ApiResponse(
        success: false,
        message: 'No authentication token found',
        data: null,
      );
    }

    try {
      final response = await http
          .patch(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          success: true,
          data: decodedData,
          message: 'Success',
        );
      } else {
        return ApiResponse(
          success: false,
          data: null,
          message: 'Server returned ${response.statusCode}',
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
