import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/auth/model/registration_model.dart';
import 'package:portal/features/auth/model/user_model.dart';

class AuthApi {
  Future<ApiResponse> login(String username, String password) async {
    String url = '$baseUrl/auth/login/';
    Map<String, String> body = {
      'username': username,
      'password': password,
    };

    DevLogs.logInfo('Login URL: $url');

    try {
      await Future.delayed(const Duration(seconds: 2));
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 201) {
        DevLogs.logInfo('Login successful: ${response.body}');
        return ApiResponse(
          success: true,
          message: "Login successful",
          data: jsonDecode(response.body),
        );
      } else {
        DevLogs.logError('Login failed with status: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Login failed: ${response.reasonPhrase}',
          data: [],
        );
      }
    } on SocketException catch (e) {
      DevLogs.logError('Network error: $e');
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.message}',
        data: [],
      );
    } catch (e) {
      DevLogs.logError('Unexpected error: $e');
      return ApiResponse(
        success: false,
        message: 'Unexpected error: $e',
        data: [],
      );
    }
  }
Future<ApiResponse> logout() async {
    String url = '$baseUrl/auth/logout/';
    String token = await getSP("token");

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"refresh": token}),
      ).timeout(const Duration(seconds: 30)
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: "Logout successful",
          data: jsonDecode(response.body),
        );
      } else {
        return ApiResponse(
          success: false,
          message: 'Logout failed: ${response.reasonPhrase}',
          data: [],
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Unexpected error: $e',
        data: [],
      );
    }
  }

}
