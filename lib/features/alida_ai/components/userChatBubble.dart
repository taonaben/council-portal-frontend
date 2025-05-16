import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';

class UserChatBubble extends StatelessWidget {
  final String message;
  const UserChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(.6),
          borderRadius: BorderRadius.circular(uniBorderRadius),
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SelectableText(
          message,
        ),
      ),
    );
  }
}
