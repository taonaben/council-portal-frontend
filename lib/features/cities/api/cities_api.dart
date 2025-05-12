import 'dart:convert';

import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:portal/features/cities/model/city_model.dart';

class CitiesApi {
  String? _cachedToken;

  Future<String> _getToken() async {
    _cachedToken ??= await getSP("token");
    return _cachedToken!;
  }

  Future<ApiResponse> fetchCities() async {
    String url = "$baseUrl/cities/all/";
    String token = await _getToken();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body); // Decode as a Map
        List<dynamic> data = jsonResponse['results'];
        List<CityModel> cities =
            data.map((city) => CityModel.fromJson(city)).toList();

        DevLogs.logInfo("Fetched cities in Api: ${cities.length}");
        DevLogs.logInfo(
            "Fetched cities in Api: ${cities.map((city) => city.toJson()).toList()}");

        return ApiResponse(
          success: true,
          message: "success",
          data: {'cities': cities},
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'cities': []},
        );
      }
    } catch (e) {
      DevLogs.logError('Error fetching cities: $e');
      return ApiResponse(
        success: false,
        message: 'Error fetching cities',
        data: {'cities': []},
      );
    }
  }

  Future<ApiResponse> fetchCityById(String id) async {
    String url = "$baseUrl/cities/$id/";
    String token = await _getToken();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body); // Decode as a Map
        CityModel city = CityModel.fromJson(jsonResponse);

        DevLogs.logInfo("Fetched city in Api: ${city.toJson()}");

        return ApiResponse(
          success: true,
          message: "success",
          data: {'city': city},
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'city': null},
        );
      }
    } catch (e) {
      DevLogs.logError('Error fetching city: $e');
      return ApiResponse(
        success: false,
        message: 'Error fetching city',
        data: {'city': null},
      );
    }
  }
}
