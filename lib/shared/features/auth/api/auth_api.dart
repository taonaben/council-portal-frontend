import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/shared/features/auth/model/user_model.dart';

class AuthApi {
  final Dio _dio = Dio();

  Future<ApiResponse> login(String username, String password) async {
    String url = '$baseUrlLocal/auth/login/';
    Map<String, String> body = {
      'username': username,
      'password': password,
    };

    DevLogs.logInfo('Login URL: $url');

    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );

    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: response.data['message'] ?? 'Login successful',
          data: response.data,
        );
      } else {
        DevLogs.logError('Login failed: ${response.data['message']}');
        return ApiResponse(
            success: false,
            data: [],
            message: response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      DevLogs.logError('Dio Error: ${e.message}');
      return ApiResponse(
        success: false,
        message: 'Connection error: ${e.message}',
        data: [],
      );
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
