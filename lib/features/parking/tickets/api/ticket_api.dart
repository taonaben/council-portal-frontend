import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/parking/tickets/model/parking_ticket_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TicketApi {
  String? _cachedToken;

  Future<String> _getToken() async {
    _cachedToken ??= await getSP("token");
    return _cachedToken!;
  }
  
  Future<ApiResponse> fetchAllTickets() async {
    String url = "$baseUrl/parking_tickets/all/";
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
        List<dynamic> data =
            jsonResponse['results']; // Access the 'tickets' field
        List<ParkingTicketModel> tickets =
            data.map((ticket) => ParkingTicketModel.fromJson(ticket)).toList();

        DevLogs.logInfo("Fetched tickets in Api: ${tickets.length}");
        DevLogs.logInfo(
            "Fetched tickets in Api: ${tickets.map((ticket) => ticket.toJson()).toList()}");

        return ApiResponse(
          success: true,
          message: "success",
          data: {'tickets': tickets},
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
      DevLogs.logError("Error fetching tickets: ${e.toString()}");
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'tickets': []},
      );
    }
  }

  Future<ApiResponse> getTicketById(String id) async {
    String url = "$baseUrl/parking_tickets/$id";
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
        var data = jsonDecode(response.body);
        ParkingTicketModel ticket = ParkingTicketModel.fromJson(data);

        return ApiResponse(
          success: true,
          message: "success",
          data: {'ticket': ticket},
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'ticket': null},
        );
      }
    } catch (e) {
      DevLogs.logError("Error fetching ticket by id: ${e.toString()}");
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'ticket': null},
      );
    }
  }

  Future<ApiResponse> fetchAllTicketsByVehicleId(String id) async {
    String url = "$baseUrl/parking_tickets/$id/";
    String token = await _getToken();

    DevLogs.logInfo("Url push: $url");

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
        List<dynamic> data =
            jsonResponse['results']; // Access the 'tickets' field
        List<ParkingTicketModel> tickets =
            data.map((ticket) => ParkingTicketModel.fromJson(ticket)).toList();

        DevLogs.logInfo("Fetched tickets in Api: ${tickets.length}");
        DevLogs.logInfo(
            "Fetched tickets in Api: ${tickets.map((ticket) => ticket.toJson()).toList()}");

        return ApiResponse(
          success: true,
          message: "success",
          data: {'tickets': tickets},
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
      DevLogs.logError("Error fetching tickets: ${e.toString()}");
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'tickets': []},
      );
    }
  }

  Future<ApiResponse> updateTicket(String id, ParkingTicketModel ticket) async {
    String url = "$baseUrl/parking_tickets/$id";
    String token = await _getToken();

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(ticket.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: "success",
          data: {'ticket': ticket},
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'ticket': null},
        );
      }
    } catch (e) {
      DevLogs.logError("Error updating ticket: ${e.toString()}");
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'ticket': null},
      );
    }
  }

  Future<ApiResponse> fetchTicketsByVehicleId(String vehicleId) async {
    String url = "$baseUrl/parking_tickets/$vehicleId";
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
        List<dynamic> data = jsonDecode(response.body);
        List<ParkingTicketModel> tickets =
            data.map((ticket) => ParkingTicketModel.fromJson(ticket)).toList();

        return ApiResponse(
          success: true,
          message: "success",
          data: {'tickets': tickets},
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
      DevLogs.logError("Error fetching tickets by vehicle id: ${e.toString()}");
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'tickets': []},
      );
    }
  }

  Future<ApiResponse> addTicket(Map<String, dynamic> body) async {
    String url = "$baseUrl/parking_tickets/all/";
    String token = await _getToken();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: true,
          message: "success",
          data: {'ticket': ParkingTicketModel.fromJson(jsonDecode(response.body))},
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'ticket': null},
        );
      }
    } catch (e) {
      DevLogs.logError("Error adding ticket: ${e.toString()}");
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'ticket': null},
      );
    }
  }
}
