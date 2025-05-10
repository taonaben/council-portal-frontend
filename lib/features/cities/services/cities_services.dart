import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/cities/api/cities_api.dart';
import 'package:portal/features/cities/model/city_model.dart';

class CitiesServices {
  var citiesApi = CitiesApi();

  Future<List<CityModel>> fetchAllCities() async {
    try {
      var result = await citiesApi.fetchCities();
      if (result.success || result.data != null) {
        final dataMap = result.data as Map<String, dynamic>;
        List<dynamic> citiesList = dataMap['cities'];

        DevLogs.logInfo('Fetched cities: ${citiesList.length}');

        if (citiesList.isNotEmpty && citiesList.first is CityModel) {
          return citiesList.cast<CityModel>();
        }

        // Otherwise, map the JSON objects to CityModel instances
        return citiesList
            .map((city) => CityModel.fromJson(city as Map<String, dynamic>))
            .toList();
      }
      DevLogs.logError('Error fetching cities: ${result.message}');
      return [];
    } catch (e) {
      DevLogs.logError('Error in services: ${e.toString()}');
      return [];
    }
  }

  Future<CityModel?> getCityById(String id) async {
    try {
      var result = await citiesApi.fetchCityById(id);
      if (result.success) {
        Map<String, dynamic> dataMap = result.data as Map<String, dynamic>;
        DevLogs.logInfo('Fetched city: ${dataMap.length}');
        if (dataMap.isNotEmpty && dataMap['city'] is CityModel) {
          return dataMap['city'] as CityModel;
        }

        return CityModel.fromJson(dataMap);
      } else {
        throw Exception('Failed to fetch city data');
      }
    } catch (e) {
      DevLogs.logError('Error in services: $e');
      return null;
    }
  }
}