import 'package:flutter/cupertino.dart';
import 'package:portal/constants/colors.dart';

class AnnoCommentBtn extends StatelessWidget {
  final int commentCount;
  const AnnoCommentBtn({super.key, required this.commentCount});

  @override
  Widget build(BuildContext context) {
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
