import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/notifications/api/notifications_api.dart';
import 'package:portal/features/notifications/model/notification_model.dart';

class NotificationServices {
  final notificationApi = NotificationsApi();

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await notificationApi.fetchNotifications();
      if (response.success) {
        Map<String, dynamic> dataMap = response.data as Map<String, dynamic>;
        List<dynamic> notificationsList = dataMap['notifications'];
        return notificationsList
            .map((notification) => NotificationModel.fromJson(notification))
            .toList();
      } else {
        throw Exception('Failed to fetch notifications data');
      }
    } catch (e) {
      DevLogs.logError('Error: $e');
      return [];
    }
  }
}
