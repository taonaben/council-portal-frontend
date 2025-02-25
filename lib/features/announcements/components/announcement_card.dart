import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/features/announcements/views/announcement_detail.dart';

class AnnouncementCard extends StatefulWidget {
  final Map<String, String> announcement;
  const AnnouncementCard({super.key, required this.announcement});

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  bool isVoted = false;
  int likes = 56;
  int commentCount = 34;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background2,
      shadowColor: primaryColor,
      elevation: 5,
      child: Column(
        children: [
          profileDateSection(widget.announcement['date'] ?? ''),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AnnouncementDetail(
                        announcement: widget.announcement);
                  },
                ),
              );
            },
            trailing: Container(
              width: 100,
              height: 50,
              decoration: const BoxDecoration(
                color: primaryColor,
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
              maxLines: 1, // Limit the number of lines for the content
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildUpVoteButton(likes),
                const Gap(8),
                buildCommentsButton(commentCount),
                const Gap(8),
                shareBtn(),
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
        Gap(8),
        Text('Admin • $date',
            style: const TextStyle(color: secondaryColor, fontSize: 12)),
      ]),
    );
  }

  Widget shareBtn() {
    return TextButton(
        onPressed: () {},
        child: const Text(
          'Share',
          style: TextStyle(color: textColor1, fontSize: 12),
        ));
  }

  Widget buildUpVoteButton(int likes) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                isVoted = !isVoted;
                isVoted ? likes++ : likes--;
              });
            },
            icon: Icon(
                isVoted
                    ? CupertinoIcons.arrowtriangle_up_circle_fill
                    : CupertinoIcons.arrowtriangle_up_circle,
                color: isVoted ? errorColor : textColor1),
          ),
          Text(
            likes.toString(),
            style: const TextStyle(color: textColor1),
          ),
          const Text(
            " upvotes",
            style: TextStyle(color: textColor1),
          ),
        ],
      ),
    );
  }

  Widget buildCommentsButton(int commentCount) {
    return Row(
      children: [
        Text(
          "${commentCount.toString()} comments",
          style: const TextStyle(color: textColor1, fontSize: 12),
        ),
      ],
    );
  }
}
