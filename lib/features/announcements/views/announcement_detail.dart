import 'package:flutter/material.dart';
import 'package:portal/constants/colors/colors.dart';

class AnnouncementDetail extends StatelessWidget {
  final Map<String, String> announcement;
  const AnnouncementDetail({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(announcement['title'] ?? 'Announcement Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              announcement['title'] ?? '',
            ),
            const SizedBox(height: 8),
            Text(
              announcement['date'] ?? '',
            ),
            const SizedBox(height: 16),
            Text(
              announcement['content'] ?? '',
            ),
          ],
        ),
      ),
    );
  }

  Widget commentField() {
    return TextFormField(
      maxLines: 3,
      minLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.amberAccent, width: 2),
            borderRadius: BorderRadius.circular(20),
            gapPadding: 10),
        hintText: 'Comment here',
        hintStyle: const TextStyle(color: textColor1),
      ),
      style: const TextStyle(color: textColor1),
    );
  }
}
