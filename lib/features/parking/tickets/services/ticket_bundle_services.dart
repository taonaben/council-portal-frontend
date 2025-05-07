import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/parking/tickets/api/ticket_bundle_api.dart';
import 'package:portal/features/parking/tickets/model/ticket_bundle_model.dart';

class TicketBundleServices {
  var ticketBundlesApi = TicketBundleApi();

  Future<List<TicketBundleModel>> fetchAllBundles() async {
    try {
      var result = await ticketBundlesApi.fetchBundles();
      if (result.success || result.data != null) {
        final dataMap = result.data as Map<String, dynamic>;
        List<dynamic> bundlesList = dataMap['bundles'];

        DevLogs.logInfo('Fetched bundles: ${bundlesList.length}');

        if (bundlesList.isNotEmpty && bundlesList.first is TicketBundleModel) {
          return bundlesList.cast<TicketBundleModel>();
        }

        // Otherwise, map the JSON objects to TicketBundleModel instances
        return bundlesList
            .map((bundle) =>
                TicketBundleModel.fromJson(bundle as Map<String, dynamic>))
            .toList();
      }
      DevLogs.logError('Error fetching bundles: ${result.message}');
      return [];
    } catch (e) {
      DevLogs.logError('Error in services: ${e.toString()}');
      return [];
    }
  }

  Future<bool> purchaseBundle(
      int quantity, int ticketMinutes, double pricePaid) async {
    try {
      var result = await ticketBundlesApi.purchaseBundle(
          quantity, ticketMinutes, pricePaid);
      if (result.success && result.data != null) {
        return true;
      }
      DevLogs.logError('Error purchasing tickets: ${result.message}');
      return false;
    } catch (e) {
      DevLogs.logError('Error in services: ${e.toString()}');
      return false;
    }
  }

  Future<bool> redeemTicketFromBundle(String vehicleId) async {
    try {
      var result = await ticketBundlesApi.redeemTicketFromBundle(vehicleId);
      if (result.success && result.data != null) {
        return true;
      }
      DevLogs.logError('Error redeeming tickets: ${result.message}');
      return false;
    } catch (e) {
      DevLogs.logError('Error in services: ${e.toString()}');
      return false;
    }
  }
}
