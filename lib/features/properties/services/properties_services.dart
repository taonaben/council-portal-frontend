import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/properties/api/properties_api.dart';
import 'package:portal/features/properties/models/property_model.dart';

class PropertiesServices {
  var propertiesApi = PropertiesApi();

  Future<List<PropertyModel>> fetchAllProperties() async {
    try {
      var result = await propertiesApi.fetchProperties();
      if (result.success || result.data != null) {
        final dataMap = result.data as Map<String, dynamic>;
        List<dynamic> propertiesList = dataMap['properties'];

        DevLogs.logInfo('Fetched properties: ${propertiesList.length}');

        if (propertiesList.isNotEmpty &&
            propertiesList.first is PropertyModel) {
          return propertiesList.cast<PropertyModel>();
        }

        // Otherwise, map the JSON objects to PropertyModel instances
        return propertiesList
            .map((property) =>
                PropertyModel.fromJson(property as Map<String, dynamic>))
            .toList();
      }
      DevLogs.logError('Error fetching properties: ${result.message}');
      return [];
    } catch (e) {
      DevLogs.logError('Error in services: ${e.toString()}');
      return [];
    }
  }

  Future<PropertyModel?> getPropertyById(String id) async {
    try {
      var result = await propertiesApi.fetchPropertyById(id);
      if (result.success) {
        Map<String, dynamic> dataMap = result.data as Map<String, dynamic>;
        DevLogs.logInfo('Fetched property: ${dataMap.length}');
        if (dataMap.isNotEmpty && dataMap['property'] is PropertyModel) {
          return dataMap['property'] as PropertyModel;
        }

        return PropertyModel.fromJson(dataMap);
      } else {
        throw Exception('Failed to fetch property data');
      }
    } catch (e) {
      DevLogs.logError('Error in services: $e');
      return null;
    }
  }
}
