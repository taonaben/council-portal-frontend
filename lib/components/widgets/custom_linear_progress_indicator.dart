import 'package:flutter/material.dart';
import 'package:portal/constants/colors/colors.dart';

class CustomLinearProgressIndicator extends StatefulWidget {
  final DateTime startTime, endTime;

  const CustomLinearProgressIndicator({
    super.key,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<CustomLinearProgressIndicator> createState() =>
      _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState
    extends State<CustomLinearProgressIndicator> with TickerProviderStateMixin {
  late AnimationController controller;
  late double initialProgress;

  @override
  void initState() {
    super.initState();

    final totalDuration = widget.endTime.difference(widget.startTime).inSeconds;
    final elapsedTime = DateTime.now().difference(widget.startTime).inSeconds;

    initialProgress = (elapsedTime / totalDuration).clamp(0.0, 1.0);

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: totalDuration),
    );

    controller.value = initialProgress; // Set initial progress
    controller.forward(from: initialProgress); // Continue from saved progress
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: controller.value,
              backgroundColor: secondaryColor,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              minHeight: 8,
            );
          },
        ),
      ),
    );
  }
}
