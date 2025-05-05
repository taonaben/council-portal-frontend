import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/auth/api/user_api.dart';
import 'package:portal/features/auth/model/user_model.dart';
import 'package:portal/features/auth/users_list.dart';

final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

class UserService {
  final userApi = UserApi();

  Future<User> getUserById(int userId) async {
    var result = await userApi.getUser(userId);

    if (result.success) {
      try {
        Map<String, dynamic> userData = result.data as Map<String, dynamic>;
        return User.fromJson(userData);
      } catch (e) {
        DevLogs.logError('Parsing error: $e');
        return User.empty();
      }
    } else {
      DevLogs.logError('Failed to fetch user: ${result.message}');
      return User.empty();
    }
  }
}
