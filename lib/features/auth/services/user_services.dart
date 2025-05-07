import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/auth/api/user_api.dart';
import 'package:portal/features/auth/model/user_model.dart';

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

        DevLogs.logInfo('User data: $userData');
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

  Future<bool> updateUser(int userId, Map<String, dynamic> data) async {
    var result = await userApi.updateUser(userId, data);

    if (result.success) {
      return true;
    } else {
      DevLogs.logError('Failed to update user: ${result.message}');
      return false;
    }
  }
}
