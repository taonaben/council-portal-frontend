import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/constants/colors/colors.dart';

class AnnouncementDetail extends StatelessWidget {
  final Map<String, String> announcement;
  const AnnouncementDetail({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: background2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    mainHero(),
                    commentSection(),
                  ],
                ),
              ),
            ),
            const Gap(20),
            Expanded(
              child: contentSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainHero() {
    return Column(
      children: [
        announcementHeaderSection(),
        const Gap(8),
        announcementImages(announcement['image_url'] ?? ''),
      ],
    );
  }

  Widget commentSection() {
    return Column(
      children: [
        postOptions(),
      ],
    );
  }

  Widget contentSection() {
    return Text("");
  }

  Widget postOptions() {
    return Row(children: [
      
    ]);
  }

  Widget announcementHeaderSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          const Icon(
            CupertinoIcons.arrow_left_circle,
            color: textColor1,
          ),
          const Gap(8),
          Expanded(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: primaryColor,
                minRadius: 16,
                maxRadius: 20,
              ),
              title: const Text(
                'A/admin',
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
            borderRadius: BorderRadius.circular(20),
            gapPadding: 10),
        hintText: 'Comment here',
        hintStyle: const TextStyle(color: textColor1),
      ),
      style: const TextStyle(color: textColor1),
    );
  }
}
