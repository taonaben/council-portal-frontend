import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/features/announcements/components/announcement_card.dart';
import 'package:portal/features/announcements/views/announcement_detail.dart';

class AnnouncementsMain extends StatefulWidget {
  const AnnouncementsMain({super.key});

  @override
  State<AnnouncementsMain> createState() => _AnnouncementsMainState();
}

class _AnnouncementsMainState extends State<AnnouncementsMain> {
  String _loremIpsum() {
    return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.';
  }

  List<Map<String, String>> announcements = [];

  @override
  void initState() {
    super.initState();
    announcements = [
      {
        'title': 'Announcement 1',
        'content': _loremIpsum(),
        'date': '2023-08-01'
      },
      {
        'title': 'Announcement 2',
        'content': _loremIpsum(),
        'date': '2023-08-02'
      },
      {
        'title': 'Announcement 3',
        'content': _loremIpsum(),
        'date': '2023-08-03'
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                CustomFilledButton(
                    btnLabel: 'Post',
                    onTap: () => context.go('/announcements/add')),
              ],
            ),
            const Gap(16),
            Expanded(
              child: ListView.builder(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  return AnnouncementCard(announcement: announcements[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
