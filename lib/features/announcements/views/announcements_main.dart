import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/features/announcements/components/announcement_box.dart';
import 'package:portal/features/announcements/components/announcement_tile.dart';
import 'package:portal/features/announcements/views/announcements_add.dart';

String _loremIpsum() {
  return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.';
}

List<Map<String, dynamic>> announcements = [
  {
    'id': '1',
    'title': 'Announcement 1',
    'content': _loremIpsum(),
    'up_votes': 56,
    'comments': 34,
    'image_url': 'announcement_image_1.jpg',
    'date': '2023-08-01'
  },
  {
    'id': '2',
    'title': 'Announcement 2',
    'content': _loremIpsum(),
    'up_votes': 42,
    'comments': 21,
    'image_url': 'announcement_image_2.png',
    'date': '2023-08-02'
  },
  {
    'id': '3',
    'title': 'Announcement 3',
    'content': _loremIpsum(),
    'up_votes': 78,
    'comments': 45,
    'image_url': 'announcement_image_3.jpg',
    'date': '2023-08-03'
  },
  {
    'id': '4',
    'title': 'Announcement 4',
    'content': _loremIpsum(),
    'up_votes': 64,
    'comments': 30,
    'image_url': 'announcement_image_4.png',
    'date': '2023-08-04'
  },
  {
    'id': '5',
    'title': 'Announcement 5',
    'content': _loremIpsum(),
    'up_votes': 89,
    'comments': 50,
    'image_url': 'announcement_image_5.png',
    'date': '2023-08-05'
  },
];

class AnnouncementsMain extends StatefulWidget {
  const AnnouncementsMain({super.key});

  @override
  State<AnnouncementsMain> createState() => _AnnouncementsMainState();
}

class _AnnouncementsMainState extends State<AnnouncementsMain> {
  @override
  void initState() {
    super.initState();
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
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AnnouncementsAdd();
                      },
                    );
                  },
                ),
              ],
            ),
            const Gap(16),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return AnnouncementBox(
                          announcement: announcements[index],
                        );
                      },
                      itemCount: announcements.length,
                    );
                  } else {
                    return ListView.builder(
                      itemCount: announcements.length,
                      itemBuilder: (context, index) {
                        return AnnouncementTile(
                          announcement: announcements[index],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
