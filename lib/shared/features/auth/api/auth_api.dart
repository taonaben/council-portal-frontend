import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/shared/features/auth/model/user_model.dart';

class AuthApi {
  final Dio dio = Dio();
  var client = http.Client();

  Future<ApiResponse> login(String username, String password) async {
    String url = '$baseUrlLocal/auth/login';
    Map<String, String> body = {
      'username': username,
      'password': password,
    };

    try {
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await client.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: data['message'] ?? 'Login successful',
          data: data,
        );
      } else {
        return ApiResponse(
            success: false,
            data: [],
            message: data['message'] ?? 'Login failed');
      }
    } catch (e) {
      DevLogs.logError('Error: $e');
      return ApiResponse(
        success: false,
        message: 'Error: $e',
        data: [],
      );
    }
  }

  Future<ApiResponse> register(User user) async {
    String url = '$baseUrlLocal/auth/register';
    Map<String, dynamic> body = user.toJson();

    try {
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await client.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: data['message'] ?? 'Registration successful',
          data: data,
        );
      } else {
        return ApiResponse(
            success: false,
            data: [],
            message: data['message'] ?? 'Registration failed');
      }
    } catch (e) {
      DevLogs.logError('Error: $e');
      return ApiResponse(
        success: false,
        message: 'Error: $e',
        data: [],
      );
    }
  }
}
