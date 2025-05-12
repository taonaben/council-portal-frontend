import 'dart:convert';

import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:portal/features/properties/models/property_model.dart';

class PropertiesApi {
  String? _cachedToken;

  Future<String> _getToken() async {
    _cachedToken ??= await getSP("token");
    return _cachedToken!;
  }

  Future<ApiResponse> fetchProperties() async {
    String url = "$baseUrl/properties/";
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
        List<PropertyModel> properties =
            data.map((property) => PropertyModel.fromJson(property)).toList();

        DevLogs.logInfo("Fetched properties in Api: ${properties.length}");
        DevLogs.logInfo(
            "Fetched properties in Api: ${properties.map((property) => property.toJson()).toList()}");

        return ApiResponse(
          success: true,
          message: "success",
          data: {'properties': properties},
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'properties': []},
        );
      }
    } catch (e) {
      DevLogs.logError('Error fetching properties: $e');
      return ApiResponse(
        success: false,
        message: 'Error fetching properties',
        data: {'properties': []},
      );
    }
  }

  Future<ApiResponse> fetchPropertyById(String id) async {
    String url = "$baseUrl/properties/$id/";
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

      DevLogs.logInfo("Fetching property with id: $id");
      DevLogs.logInfo("Response data: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body); // Decode as a Map
        PropertyModel property = PropertyModel.fromJson(jsonResponse);

        DevLogs.logInfo("Fetched property in Api: ${property.toJson()}");

        return ApiResponse(
          success: true,
          message: "success",
          data: {'property': property},
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'property': null},
        );
      }
    } catch (e) {
      DevLogs.logError('Error fetching property: $e');
      return ApiResponse(
        success: false,
        message: 'Error fetching property',
        data: {'property': null},
      );
    }
  }
}
