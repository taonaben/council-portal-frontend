import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';

import 'package:http/http.dart' as http;

class UserApi {
  final Dio _dio = Dio();
  Future<ApiResponse> getUser(int userId) async {
    String url = "$baseUrl/users/$userId";
    String token = await getSP("token");

    DevLogs.logInfo("Token: $token");

    if (token.isEmpty) {
      return ApiResponse(
        success: false,
        message: 'Token is null',
        data: [],
      );
    }

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': ' Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          data: jsonDecode(response.body), // Need to decode the JSON response
          message: 'Success',
        );
      } else {
        return ApiResponse(
            success: false,
            data: [],
            message: 'Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Error: $e',
        data: [],
      );
    }
  }
}
