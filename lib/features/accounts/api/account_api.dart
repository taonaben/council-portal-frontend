import 'package:dio/dio.dart';
import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/shared_prefs.dart';

class AccountApi {
  final Dio dio = Dio();

  Future<ApiResponse> getAccount() async {
    String url = "$baseUrl/accounts/all";
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
        message: "An error occurred while fetching account data.",
      );
    }
  }

  Future<ApiResponse> getAccountById(String id) async {
    String url = "$baseUrl/accounts/$id";
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
        message: "An error occurred while fetching account data.",
      );
    }
  }
}
