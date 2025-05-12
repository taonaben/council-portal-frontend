import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/features/cities/model/city_model.dart';
import 'package:portal/features/cities/services/cities_services.dart';

final allCitiesProvider = FutureProvider<List<CityModel>>((ref) async {
  try {
    return CitiesServices().fetchAllCities().then((value) {
      if (value.isNotEmpty) {
        // Sort latest first
        return value;
      } else {
        throw Exception('No cities found');
      }
    });
  } catch (e) {
    throw Exception('Error fetching cities: $e');
  }
});

final cityByIdProvider =
    FutureProvider.family<CityModel?, String>((ref, id) async {
  try {
    return CitiesServices().getCityById(id);
  } catch (e) {
    throw Exception('Error fetching city by ID: $e');
  }
});
