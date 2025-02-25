// lib/services/mock_ecocash_payment_service.dart

import 'dart:math';

class EcocashPaymentService {
  static const networkDelay = Duration(seconds: 2);

  Future<bool> initiatePayment(double amount) async {
    await Future.delayed(networkDelay);
    _log(
        "Initiating Ecocash payment for amount: \$${amount.toStringAsFixed(2)}");

    return true; // Always return true to simulate a successful initiation
  }

  Future<bool> confirmPayment() async {
    await Future.delayed(networkDelay);
    _log("Confirming payment...");

    return true; // Always return true to simulate a successful confirmation
  }

  Future<String> checkPaymentStatus(String transactionId) async {
    await Future.delayed(networkDelay);
    _log("Checking status for transaction ID: $transactionId");
    List<String> statuses = ["Pending", "Completed", "Failed", "Cancelled"];
    String status = statuses[Random().nextInt(statuses.length)];
    _log("Payment status for transaction ID $transactionId: $status");
    return status;
  }

  void _log(String message) {
    print(message);
  }
}
