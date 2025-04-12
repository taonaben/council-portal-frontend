import 'dart:math';

import 'package:collection/collection.dart';

class IncomePoints {
  final double x;
  final double y;
  IncomePoints({required this.x, required this.y});
}

List<IncomePoints> get incomePoints {
  final random = Random();
  final List<int> operatingHours =
      List.generate(10, (index) => index + 8); // 6 AM - 10 PM

  return operatingHours.mapIndexed((index, hour) {
    // Introduce random gaps (0 revenue for some hours)
    double income =
        random.nextBool() ? 0 : (10 + random.nextInt(100)).toDouble();
    return IncomePoints(x: index.toDouble(), y: income);
  }).toList();
}
