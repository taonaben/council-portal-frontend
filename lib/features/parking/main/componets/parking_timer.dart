import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';

class ParkingTimer extends StatefulWidget {
  final Duration initialDuration;

  const ParkingTimer({
    super.key,
    this.initialDuration = const Duration(minutes: 30),
  });

  @override
  State<ParkingTimer> createState() => _ParkingTimerState();
}

class _ParkingTimerState extends State<ParkingTimer> {
  Timer? _timer;
  late DateTime _endTime;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _endTime = DateTime.now().add(widget.initialDuration);
    _updateRemainingTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateRemainingTime() {
    final now = DateTime.now();
    if (_endTime.isAfter(now)) {
      _remainingTime = _endTime.difference(now);
    } else {
      _remainingTime = Duration.zero;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {
        _updateRemainingTime();
      });

      if (_remainingTime.inSeconds <= 0) {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uniBorderRadius),
      ),
      shadowColor:  blackColor.withOpacity(0.5),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Gap(16),
            _buildTimer(),
            const Gap(16),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Countdown',
      style: TextStyle(color: textColor1, fontWeight: FontWeight.bold),
      textAlign: TextAlign.start,
    );
  }

  Widget _buildTimer() {
    final hours = twoDigits(_remainingTime.inHours);
    final minutes = twoDigits(_remainingTime.inMinutes.remainder(60));
    final seconds = twoDigits(_remainingTime.inSeconds.remainder(60));

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     _buildTimeLabel(hours, 'hours', true),
    //     // const Gap(8),
    //     _buildTimeLabel(minutes, 'minutes', false),
    //     // const Gap(8),
    //     _buildTimeLabel(seconds, 'seconds', false),
    //   ],
    // );

    return Text(
      "${hours != "00" ? "${hours}h" : ""}${minutes}m ${seconds}s left",
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w900,
        color: primaryColor,
      ),
    );
  }

  String id = generateRandomString(16);

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Paid: ${timeFormatted(DateTime.now())} ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: textColor1,
          ),
        ),
      ],
    );
  }
}
