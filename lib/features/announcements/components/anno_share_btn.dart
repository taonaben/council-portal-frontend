import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:portal/constants/colors/colors.dart';

class AnnoShareBtn extends StatelessWidget {
  const AnnoShareBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          CupertinoIcons.arrowshape_turn_up_right,
          color: textColor1,
          size: 12,
        ),
        Gap(4),
        Text(
          'Share',
          style: TextStyle(color: textColor1, fontSize: 12),
        )
      ],
    );
  }
}
