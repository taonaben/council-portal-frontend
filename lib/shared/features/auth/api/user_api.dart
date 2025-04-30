import 'package:dio/dio.dart';
import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/shared_prefs.dart';

class UserApi {
  final Dio _dio = Dio();
  Future<ApiResponse> getUser() async {
    String url = "$baseUrlLocal/users/all";
    String token = await getSP("token");

    try {
      var response = await _dio.get(url,
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
