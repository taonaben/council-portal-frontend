import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/constants/colors/colors.dart';

class AnnouncementsAdd extends StatefulWidget {
  const AnnouncementsAdd({super.key});

  @override
  State<AnnouncementsAdd> createState() => _AnnouncementsAddState();
}

class _AnnouncementsAddState extends State<AnnouncementsAdd> {
  bool expires = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: background2,
          border: Border.all(color: textColor1, width: .2),
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildHeader(context),
            buildBody(),
            buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Post Announcement",
          style: TextStyle(color: textColor1),
        ),
        IconButton(
          icon: const Icon(CupertinoIcons.clear, color: textColor1),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Title',
            labelStyle: TextStyle(color: textColor1),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: textColor1),
          maxLines: 1,
        ),
        const CustomDivider(),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Say something...',
            labelStyle: TextStyle(color: textColor1),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: textColor1),
          maxLines: 15,
        ),
        const CustomDivider(),
      ],
    );
  }

  Widget buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.textformat,
              color: textColor1,
            )),
        const Gap(8),
        Tooltip(
          message: 'Add an image',
          
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.photo,
                color: textColor1,
              )),
        ),
        const Gap(8),
        Tooltip(
          message: 'Add a link',
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.link,
                color: textColor1,
              )),
        ),
        const Spacer(),
        Tooltip(
          message: 'Expires',
          child: Switch.adaptive(
              value: expires,
              activeColor: primaryColor,
              activeTrackColor: secondaryColor,
              inactiveThumbColor: secondaryColor,
              inactiveTrackColor: background2,
              applyCupertinoTheme: true,
              onChanged: (value) {
                setState(() {
                  expires = value;
                });
              }),
        ),
        const Gap(8),
        CustomFilledButton(
            btnLabel: 'Post',
            onTap: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
