import 'package:portal/core/utils/api_response.dart';
import 'package:portal/features/notifications/api/notification_list.dart';

class NotificationsApi {
  Future<ApiResponse> fetchNotifications() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      return ApiResponse(
        success: true,
        data: {'notifications': notificationList},
        message: 'Notifications fetched successfully',
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'notifications': []},
      );
    }
  }
}
