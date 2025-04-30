import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/shared/features/announcements/components/anno_comment_btn.dart';
import 'package:portal/shared/features/announcements/components/anno_upVote_btn.dart';
import 'package:portal/shared/features/announcements/components/anno_share_btn.dart';

class AnnouncementTile extends StatefulWidget {
  final Map<String, dynamic> announcement;
  const AnnouncementTile({super.key, required this.announcement});

  @override
  State<AnnouncementTile> createState() => _AnnouncementTileState();
}

class _AnnouncementTileState extends State<AnnouncementTile> {
  bool isVoted = false;
  int likes = 56;
  int commentCount = 34;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background2,
      shadowColor: blackColor.withOpacity(0.5),
      elevation: 5,
      child: Column(
        children: [
          profileDateSection(widget.announcement['date'] ?? ''),
          ListTile(
            onTap: () =>
                context.go('/announcement/${widget.announcement['id']}'),
            trailing: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            title: Text(
              widget.announcement['title'] ?? '',
              style: const TextStyle(color: textColor1),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            subtitle: Text(
              widget.announcement['content'] ?? '',
              style: const TextStyle(color: textColor1),
              overflow: TextOverflow.ellipsis,
              maxLines: 4, // Limit the number of lines for the content
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnnoUpVoteBtn(likes: widget.announcement['up_votes']),
                const Gap(8),
                AnnoCommentBtn(commentCount: widget.announcement['comments']),
                const Gap(8),
                const AnnoShareBtn(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget profileDateSection(String date) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16),
      child: Row(children: [
        const CircleAvatar(
          backgroundColor: primaryColor,
          minRadius: 8,
          maxRadius: 10,
        ),
        const Gap(8),
        Text('Admin • $date',
            style: const TextStyle(color: secondaryColor, fontSize: 12)),
      ]),
    );
  }
}
