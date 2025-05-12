import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/features/parking/tickets/model/ticket_bundle_model.dart';
import 'package:portal/features/parking/tickets/services/ticket_bundle_services.dart';

final allBundlesProvider = FutureProvider<List<TicketBundleModel>>((ref) async {
  try {
    return TicketBundleServices().fetchAllBundles().then((value) {
      if (value.isNotEmpty) {
        value.sort((a, b) {
          final dateA = DateTime.parse(a.purchased_at!);
          final dateB = DateTime.parse(b.purchased_at!);
          return dateB.compareTo(dateA); // Sort in descending order
        }); // Sort latest first
        return value;
      } else {
        throw Exception('No tickets found');
      }
    });
  } catch (e) {
    throw Exception('Error fetching tickets: $e');
  }
});
