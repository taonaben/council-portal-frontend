import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal/constants/colors.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool enableNotifications = true;
  bool notificationSound = true;
  bool vibration = true;
  String selectedTone = "Default";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Notification Settings'),
      ),
      child: ListView(
        children: [
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile(
                title: const Text('Enable Notifications'),
                trailing: CupertinoSwitch(
                  value: enableNotifications,
                  onChanged: (bool value) {
                    setState(() {
                      enableNotifications = value;
                    });
                  },
                ),
              ),
              CupertinoListTile(
                title: const Text('Notification Sound'),
                trailing: CupertinoSwitch(
                  value: notificationSound,
                  onChanged: (bool value) {
                    setState(() {
                      notificationSound = value;
                    });
                  },
                ),
              ),
              CupertinoListTile(
                title: const Text('Vibration'),
                trailing: CupertinoSwitch(
                  value: vibration,
                  onChanged: (bool value) {
                    setState(() {
                      vibration = value;
                    });
                  },
                ),
              ),
              CupertinoListTile(
                title: Text('Notification Tone: $selectedTone'),
                trailing: const CupertinoListTileChevron(),
                onTap: () async {
                  final tone = await showCupertinoModalPopup<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoActionSheet(
                        title: const Text('Select Notification Tone'),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () => Navigator.pop(context, 'Default'),
                            child: const Text('Default'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () => Navigator.pop(context, 'Chime'),
                            child: const Text('Chime'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () => Navigator.pop(context, 'Alert'),
                            child: const Text('Alert'),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () => Navigator.pop(context, null),
                          child: const Text('Cancel'),
                        ),
                      );
                    },
                  );

                  if (tone != null) {
                    setState(() {
                      selectedTone = tone;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
