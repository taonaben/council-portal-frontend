import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/shared/features/announcements/components/anno_comment_btn.dart';
import 'package:portal/shared/features/announcements/components/anno_upVote_btn.dart';
import 'package:portal/shared/features/announcements/components/anno_share_btn.dart';

class AnnouncementDetail extends StatelessWidget {
  final Map<String, dynamic> announcement;
  const AnnouncementDetail({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: background2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mainHero(context),
                    commentSection(),
                  ],
                ),
              ),
            ),
            const Gap(8),
            Expanded(
              child: contentSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainHero(BuildContext context) {
    return Column(
      children: [
        announcementHeaderSection(context),
        const Gap(8),
        announcementImages(announcement['image_url'] ?? ''),
      ],
    );
  }

  Widget commentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(8),
        postOptions(),
        const Gap(8),
        commentList(),
      ],
    );
  }

  Widget commentList() {
    return const Text('No comments yet',
        style: TextStyle(color: textColor1, fontSize: 12));
  }

  Widget contentSection() {
    return Container(
      padding: const EdgeInsets.all(8),
      height: double.infinity,
      decoration: BoxDecoration(
        color: background2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Text(
          announcement['content'] ?? '',
          style: const TextStyle(color: textColor1, fontSize: 14),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget postOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnnoUpVoteBtn(likes: announcement['up_votes']),
            const Gap(16),
            AnnoCommentBtn(commentCount: announcement['comments']),
            const Gap(16),
            const AnnoShareBtn(),
          ],
        ),
        const Gap(8),
        commentField(),
        const Gap(8),
      ],
    );
  }

  Widget announcementHeaderSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              CupertinoIcons.arrow_left_circle,
              color: textColor1,
            ),
          ),
          Expanded(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: primaryColor,
                minRadius: 16,
                maxRadius: 20,
              ),
              title: const Text(
                'Author/admin',
                style: TextStyle(
                    color: textColor1,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                announcement['date'] ?? '',
                style: const TextStyle(color: textColor1, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      const Gap(8),
      Text(
        announcement['title'] ?? '',
        style: const TextStyle(
            color: textColor1, fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    ]);
  }

  Widget announcementImages(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
                child: Image.asset(
                  'lib/assets/images/$imageUrl',
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: secondaryColor,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 350,
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                'lib/assets/images/$imageUrl',
                fit: BoxFit.contain,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image_outlined,
                  color: redColor,
                  size: 50,
                ),
              ),
            ),
          ),
        ],
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
            borderRadius: BorderRadius.circular(40),
            gapPadding: 10),
        hintText: 'Comment here',
        hoverColor: primaryColor,
        hintStyle: const TextStyle(color: textColor1),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: IconButton(
            icon: const Icon(CupertinoIcons.paperplane),
            color: primaryColor,
            enableFeedback: true,
            disabledColor: secondaryColor,
            onPressed: () {},
          ),
        ),
      ),
      style: const TextStyle(color: textColor1),
    );
  }
}
