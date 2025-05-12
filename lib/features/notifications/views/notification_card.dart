import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/features/notifications/model/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: notification.isRead == true
            ? background1
            : secondaryColor.withOpacity(0.4),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            getIcon(notification.type),
            color: textColor2,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(notification.title ?? 'No Title',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Gap(4),
            Text(
              notification.description ?? 'No Description',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[800]),
            ),
          ],
        ),
        onTap: () => viewNotificationDetails(context),
      ),
    );
  }

  IconData getIcon(String? type) {
    switch (type) {
      case 'water':
        return Icons.water_drop_outlined;
      case 'parking':
        return Icons.local_parking_outlined;
      case 'account':
        return CupertinoIcons.person;
      default:
        return CupertinoIcons.bell;
    }
  }

  void viewNotificationDetails(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(uniBorderRadius)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.title ?? 'No Title',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            notification.date ?? 'No Date',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Gap(8),
                const CustomDivider(color: textColor2),
                const Gap(8),
                // Notification content
                Expanded(
                  child: SingleChildScrollView(
                    child: SelectableText(
                      notification.description ?? 'No Description',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                const Gap(16),
                // Navigation to notification settings
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    context.pushNamed("notification-settings");
                  },
                  child: const Row(
                    children: [
                      Icon(
                        CupertinoIcons.settings,
                        color: textColor2,
                      ),
                      Gap(8),
                      Text(
                        "Manage Notification Settings",
                        style: TextStyle(
                          color: textColor2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
