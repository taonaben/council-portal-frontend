import 'dart:convert';

import 'package:portal/constants/keys_and_urls.dart';
import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:portal/features/alida_ai/model/alida_model.dart';

class AlidaApi {
  String? _cachedToken;

  Future<String> _getToken() async {
    _cachedToken ??= await getSP("token");
    return _cachedToken!;
  }

  Future<ApiResponse> fetchAllAlidaMessages() async {
    String url = "$baseUrl/alida_ai/chat-history/";
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
        List<dynamic> data = jsonResponse;
        List<AlidaModel> alidaMessages =
            data.map((messages) => AlidaModel.fromJson(messages)).toList();

        DevLogs.logInfo("Fetched messages in Api: ${alidaMessages.length}");
        DevLogs.logInfo(
            "Fetched messages in Api: ${alidaMessages.map((message) => message.toJson()).toList()}");

        return ApiResponse(
          success: true,
          message: "success",
          data: {'messages': alidaMessages},
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'messages': []},
        );
      }
    } catch (e) {
      DevLogs.logError("Error fetching messages: ${e.toString()}");
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'messages': []},
      );
    }
  }

  Future<ApiResponse> sendMessageToAlida(String content) async {
    String url = "$baseUrl/alida_ai/chat/";

    String token = await _getToken();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "content": content,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body); // Decode as a Map
        AlidaResponseModel data = AlidaResponseModel.fromJson(jsonResponse);

        DevLogs.logInfo("Fetched messages in Api: ${data.toJson()}");

        return ApiResponse(
          success: true,
          message: "success",
          data: {'message': data},
        );
      } else {
        DevLogs.logError('Failed with status code: ${response.statusCode}');
        return ApiResponse(
          success: false,
          message: 'Failed with status code: ${response.statusCode}',
          data: {'message': []},
        );
      }
    } catch (e) {
      DevLogs.logError("Error fetching messages: ${e.toString()}");
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'message': []},
      );
    }
  }
}
