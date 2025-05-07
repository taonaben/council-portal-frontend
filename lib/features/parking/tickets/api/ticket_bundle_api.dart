import 'dart:convert';

import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:portal/features/parking/tickets/model/ticket_bundle_model.dart';

class TicketBundleApi {
  String? _cachedToken;
  String? _cachedCityId;

  Future<String> _getToken() async {
    _cachedToken ??= await getSP("token");
    return _cachedToken!;
  }

  Future<String> _getCityId() async {
    _cachedCityId ??= await getSP("city");
    return _cachedCityId!;
  }



  Future<ApiResponse> fetchBundles() async {
    String url = "$baseUrl/parking_tickets/ticket-bundles/";
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
        List<TicketBundleModel> bundles =
            data.map((bundle) => TicketBundleModel.fromJson(bundle)).toList();

        DevLogs.logInfo("Fetched tickets in Api: ${bundles.length}");
        DevLogs.logInfo(
            "Fetched tickets in Api: ${bundles.map((bundle) => bundle.toJson()).toList()}");

        return ApiResponse(
          success: true,
          message: "success",
          data: {'bundles': bundles},
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'tickets': []},
        );
      }
    } catch (e) {
      DevLogs.logError("Error fetching bundles: ${e.toString()}");
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'bundles': []},
      );
    }
  }

  Future<ApiResponse> purchaseBundle(
    int quantity,
    int ticketMinutes,
    double pricePaid,
  ) async {
    String url = "$baseUrl/parking_tickets/ticket-bundles/purchase/";
    String token = await _getToken();

    DevLogs.logInfo("Purchasing tickets in Api: $url");
    DevLogs.logInfo("Purchasing tickets in Api: $pricePaid");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "quantity": quantity,
          "ticket_minutes": ticketMinutes,
          "price_paid": pricePaid
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);

        DevLogs.logInfo("Purchased tickets in Api: $jsonResponse");

        return ApiResponse(
          success: true,
          message: "success",
          data: Map<String, dynamic>.from(jsonResponse),
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'bundle': []},
        );
      }
    } catch (e) {
      DevLogs.logError("Error purchasing bundle: ${e.toString()}");
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'bundle': []},
      );
    }
  }

  Future<ApiResponse> redeemTicketFromBundle(
      String vehicleId) async {
    String url = "$baseUrl/parking_tickets/ticket-bundles/redeem/";
    String token = await _getToken();
    String cityId = await _getCityId();

    DevLogs.logInfo("Redeeming tickets in Api: $url");

    DevLogs.logInfo("Redeeming tickets in car: $vehicleId");
    DevLogs.logInfo("Redeeming tickets in city: $cityId");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"vehicle_id": vehicleId, "city_id": cityId}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);

        DevLogs.logInfo("Redeemed tickets in Api: $jsonResponse");

        return ApiResponse(
          success: true,
          message: "success",
          data: Map<String, dynamic>.from(jsonResponse),
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {},
        );
      }
    } catch (e) {
      DevLogs.logError("Error redeeming bundle: ${e.toString()}");
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {},
      );
    }
  }
}
