import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/alida_ai/api/alida_api.dart';
import 'package:portal/features/alida_ai/model/alida_model.dart';

class AlidaServices {
  var alidaAPI = AlidaApi();

  Future<List<AlidaModel>> fetchAllAlidaMessages() async {
    try {
      var result = await alidaAPI.fetchAllAlidaMessages();
      if (result.success || result.data != null) {
        final dataMap = result.data as Map<String, dynamic>;
        final alidaListRaw = dataMap['messages'];
        if (alidaListRaw == null) {
          DevLogs.logError('Messages list is null');
          return [];
        }

        List<dynamic> alidaList = alidaListRaw;

        DevLogs.logInfo('Fetched messages in services: ${alidaList.length}');

        if (alidaList.isNotEmpty && alidaList.first is AlidaModel) {
          return alidaList.cast<AlidaModel>();
        }

        // Otherwise, map the JSON objects to AlidaModel instances
        return alidaList
            .map((message) =>
                AlidaModel.fromJson(message as Map<String, dynamic>))
            .toList();
      }
      DevLogs.logError('Error fetching messages: ${result.message}');
      return [];
    } catch (e) {
      DevLogs.logError('Error in services: ${e.toString()}');
      return [];
    }
  }

  Future<AlidaResponseModel?> sendMessageToAlida(String content) async {
    try {
      var result = await alidaAPI.sendMessageToAlida(content);
      if (result.success && result.data != null) {
        final dataMap = result.data as Map<String, dynamic>;
        final message = dataMap['message'];
        if (message is AlidaResponseModel) {
          return message;
        } else if (message is Map<String, dynamic>) {
          return AlidaResponseModel.fromJson(message);
        }
      }
      DevLogs.logError('Error sending message: [33m${result.message}');
      return null;
    } catch (e) {
      DevLogs.logError('Error in sendMessageToAlida: [33m${e.toString()}');
      return null;
    }
  }
}
