import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/features/alida_ai/model/alida_model.dart';
import 'package:portal/features/alida_ai/services/alida_services.dart';

final alidaChatHistoryProvider = FutureProvider<List<AlidaModel>>((ref) async {
  try {
    return AlidaServices().fetchAllAlidaMessages().then((value) {
      if (value.isNotEmpty) {
        value.sort((a, b) {
          final dateA = DateTime.parse(a.created_at!);
          final dateB = DateTime.parse(b.created_at!);
          return dateB.compareTo(dateA); // Sort in descending order
        }); // Sort latest first
        return value;
      } else {
        throw Exception('No messages found');
      }
    });
  } catch (e) {
    throw Exception('Error fetching messages: $e');
  }
});
