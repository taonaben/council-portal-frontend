import 'package:portal/shared/global/cities/api/cities_api.dart';
import 'package:portal/shared/global/cities/model/city_model.dart';

class CitiesServices {
  final citiesApi = CitiesApi();

  Future<List<CityModel>> getCities() async {
    var result = await citiesApi.getCities();

    if (result.success) {
      try {
        List<CityModel> cities = (result.data as List)
            .map((city) => CityModel.fromJson(city))
            .toList();
        return cities;
      } catch (e) {
        return [];
      }
    } else {
      return [];
    }
  }
}
