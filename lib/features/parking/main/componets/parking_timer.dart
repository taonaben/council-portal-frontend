import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/parking/tickets/model/parking_ticket_model.dart';

class ParkingTimer extends StatefulWidget {
  final ParkingTicketModel activeTicket;

  const ParkingTimer({
    super.key,
    required this.activeTicket,
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
    try {
      if (widget.activeTicket.expiry_at != null) {
        _endTime = DateTime.parse(widget.activeTicket.expiry_at!);
        _updateRemainingTime();
        _startTimer();
      } else {
        _remainingTime = Duration.zero;
      }
    } catch (e) {
      _remainingTime = Duration.zero;
      debugPrint('Error initializing timer: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateRemainingTime() {
    try {
      final now = DateTime.now();
      if (_endTime.isAfter(now)) {
        _remainingTime = _endTime.difference(now);
      } else {
        _remainingTime = Duration.zero;
      }
    } catch (e) {
      _remainingTime = Duration.zero;
      debugPrint('Error updating remaining time: $e');
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
      shadowColor: blackColor.withOpacity(0.5),
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

    return Text(
      _remainingTime > Duration.zero
          ? "${hours != "00" ? "${hours}h" : ""}${minutes}m ${seconds}s left"
          : "00h 00m 00s left",
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
          'Paid: ${timeFormatted(widget.activeTicket.issued_at)} ',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            color: textColor1,
          ),
        ),
      ],
    );
  }
}
