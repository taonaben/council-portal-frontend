import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/notifications/model/notification_model.dart';
import 'package:portal/features/notifications/services/notification_services.dart';

final allNotificationProvider =
    FutureProvider<List<NotificationModel>>((ref) async {
  final notificationServices = NotificationServices();
  try {
    final notifications = await notificationServices.getNotifications();
    DevLogs.logInfo(
        'Fetched notifications: ${notifications.length}'); // Debug print
    return notifications;
  } catch (e) {
    DevLogs.logError('Error fetching notifications: $e'); // Debug print
    return <NotificationModel>[];
  }
});
