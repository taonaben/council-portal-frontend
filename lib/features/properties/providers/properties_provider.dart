import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/features/properties/models/property_model.dart';
import 'package:portal/features/properties/services/properties_services.dart';

final allPropertiesProvider = FutureProvider<List<PropertyModel>>((ref) async {
  try {
    return PropertiesServices().fetchAllProperties().then((value) {
      if (value.isNotEmpty) {
        // Sort latest first
        return value;
      } else {
        throw Exception('No properties found');
      }
    });
  } catch (e) {
    throw Exception('Error fetching properties: $e');
  }
});

final propertyByIdProvider =
    FutureProvider.family<PropertyModel?, String>((ref, id) async {
  try {
    return PropertiesServices().getPropertyById(id);
  } catch (e) {
    throw Exception('Error fetching property by ID: $e');
  }
});
