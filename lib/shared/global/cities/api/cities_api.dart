import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;

class CitiesApi {
  Future<ApiResponse> getCities() async {
    String url = "$baseUrl/cities/all/";

    String token = await getSP("token");

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
          data: response.body,
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
