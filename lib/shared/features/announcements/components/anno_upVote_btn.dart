import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:portal/constants/colors/colors.dart';

class AnnoUpVoteBtn extends StatefulWidget {
  int likes;
  AnnoUpVoteBtn({super.key, required this.likes});

  @override
  State<AnnoUpVoteBtn> createState() => _AnnoUpVoteBtnState();
}

class _AnnoUpVoteBtnState extends State<AnnoUpVoteBtn> {
  bool isVoted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isVoted = !isVoted;
          isVoted ? widget.likes++ : widget.likes--;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              isVoted
                  ? CupertinoIcons.arrowtriangle_up_circle_fill
                  : CupertinoIcons.arrowtriangle_up_circle,
              color: isVoted ? redColor : textColor1,
              size: 18,
            ),
            const Gap(4),
            Text(
              "${widget.likes.toString()} upvotes",
              style: const TextStyle(color: textColor1),
            ),
          ],
        ),
      ),
    );
  }
}
