import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_image_widget.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/shared/features/announcements/components/anno_comment_btn.dart';
import 'package:portal/shared/features/announcements/components/anno_upVote_btn.dart';
import 'package:portal/shared/features/announcements/components/anno_share_btn.dart';

class AnnouncementBox extends StatefulWidget {
  final Map<String, dynamic> announcement;
  const AnnouncementBox({super.key, required this.announcement});

  @override
  State<AnnouncementBox> createState() => _AnnouncementBoxState();
}

class _AnnouncementBoxState extends State<AnnouncementBox> {
  bool isVoted = false;
  int likes = 56;
  int commentCount = 34;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go('/announcement/${widget.announcement['id']}');
      },
      child: Card(
        color: background2,
        shadowColor:  blackColor.withOpacity(0.5),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText(),
              const Gap(8),
              profileDateSection(widget.announcement['date'] ?? ''),
              const Gap(8),
              CustomImageWidget(
                  imageName: widget.announcement['image_url'] ?? ''),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnnoUpVoteBtn(likes: widget.announcement['up_votes']),
                    const Gap(8),
                    AnnoCommentBtn(
                        commentCount: widget.announcement['comments']),
                    const Gap(8),
                    const AnnoShareBtn(),
                  ],
                ),
              ),
              const Gap(8),
              LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight,
                    ),
                    child: Text(
                      widget.announcement['content'] ?? '',
                      style: const TextStyle(color: textColor1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleText() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        widget.announcement['title'] ?? '',
        style: const TextStyle(color: textColor1, fontSize: 20),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Widget profileDateSection(String date) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
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
