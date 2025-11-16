import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';

class AIChatBubble extends StatefulWidget {
  final String message;
  final int index;
  final Map<int, bool> _thumbsUp = {};
  final Map<int, bool> _thumbsDown = {};
  AIChatBubble({
    super.key,
    required this.message,
    required this.index,
    required Map<int, bool> thumbsUp,
    required Map<int, bool> thumbsDown,
  });

  @override
  State<AIChatBubble> createState() => _AIChatBubbleState();
}

class _AIChatBubbleState extends State<AIChatBubble> {
  @override
  Widget build(BuildContext context) {
    final thumbsUp = widget._thumbsUp[widget.index] ?? false;
    final thumbsDown = widget._thumbsDown[widget.index] ?? false;
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(16),
          SelectableText(
            widget.message,
          ),
          const Gap(8),
          Row(
            children: [
              IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(CupertinoIcons.square_on_square, size: 16),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.message))
                      .then((_) {
                    const CustomSnackbar(
                      message: "Message copied",
                      color: primaryColor,
                    ).showSnackBar(context);
                  });
                },
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.speaker_2, size: 16),
                onPressed: () {
                  // Add your onPressed logic here
                },
              ),
              IconButton(
                icon: Icon(
                    thumbsUp
                        ? CupertinoIcons.hand_thumbsup_fill
                        : CupertinoIcons.hand_thumbsup,
                    size: 16),
                onPressed: () {
                  setState(() {
                    widget._thumbsUp[widget.index] = !thumbsUp;
                    if (widget._thumbsUp[widget.index] == true) {
                      widget._thumbsDown[widget.index] = false;
                    }
                  });

                  const CustomSnackbar(
                          message: "Thank you for your feedback",
                          color: primaryColor)
                      .showSnackBar(context);
                },
              ),
              IconButton(
                icon: Icon(
                    thumbsDown
                        ? CupertinoIcons.hand_thumbsdown_fill
                        : CupertinoIcons.hand_thumbsdown,
                    size: 16),
                onPressed: () {
                  setState(() {
                    widget._thumbsDown[widget.index] = !thumbsDown;
                    if (widget._thumbsDown[widget.index] == true) {
                      widget._thumbsUp[widget.index] = false;
                    }
                  });
                  const CustomSnackbar(
                          message: "Thank you for your feedback",
                          color: primaryColor)
                      .showSnackBar(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
