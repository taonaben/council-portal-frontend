import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/features/notifications/providers/notification_providers.dart';
import 'package:portal/features/notifications/views/notification_card.dart';

class NotificationsMain extends ConsumerWidget {
  const NotificationsMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationAsyncValue = ref.watch(allNotificationProvider);
    return notificationAsyncValue.when(
      data: (notifications) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: notifications.isEmpty
                ? const Center(child: Text('No notifications available'))
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return NotificationCard(
                        notification: notifications[index],
                      );
                    },
                  ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text('Error: $error'));
      },
      loading: () => const Center(
          child: CustomCircularProgressIndicator(color: textColor2)),
    );
  }
}
