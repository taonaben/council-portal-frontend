import 'dart:math';

DateTime now = DateTime.now();
Random random = Random();

List<String> cities = [
  'New York',
  'Los Angeles',
  'Chicago',
  'Houston',
  'Miami',
  'San Francisco'
];
List<String> durations = ['1 hour', '2 hours', '3 hours', '30 minutes'];
List<String> statuses = ['active', 'expired', 'pending', 'cancelled'];

String generateTicketNumber() {
  return List.generate(6, (_) => random.nextInt(10)).join();
}

List<Map<String, dynamic>> generateTickets(int count) {
  return List.generate(count, (index) {
    final durationHours = random.nextInt(3) + 1;
    final issuedAt = now.subtract(Duration(minutes: random.nextInt(5000)));
    final expiryAt = issuedAt.add(Duration(hours: durationHours));

    return {
      "id": (index + 1).toString(),
      "ticket_number": generateTicketNumber(),
      "user": 'John Doe',
      "vehicle": (random.nextInt(6) + 1).toString(), // IDs 1 to 6
      "city": cities[random.nextInt(cities.length)], 
      "issued_length": '${durationHours} hours',
      "issued_at": issuedAt.toIso8601String(),
      "expiry_at": expiryAt.toIso8601String(),
      "amount": random.nextInt(5) + 1,
      "status": statuses[random.nextInt(statuses.length)],
    };
  });
}

// Example: generate 50 test ticket entries
List<Map<String, dynamic>> allTickets = generateTickets(50);
