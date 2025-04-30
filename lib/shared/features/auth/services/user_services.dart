import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/shared/features/auth/api/user_api.dart';
import 'package:portal/shared/features/auth/model/user_model.dart';
import 'package:portal/shared/features/auth/users_list.dart';

final authServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

class UserService {
  final userApi = UserApi();
  Future<User> getUserById(int userId) async {
    var results = await userApi.getUser();
    try {
      if (results.success) {
        Map<String, dynamic> dataMap = results.data as Map<String, dynamic>;

        List<dynamic> userList = dataMap["users"] as List<dynamic>;

        return userList.map((user) => User.fromJson(user)).toList().firstWhere(
              (user) => user.id == userId,
              orElse: () => User(
                id: 0,
                first_name: "",
                last_name: "",
                email: "",
                city: "",
                phone_number: "",
                username: "",
                is_superuser: false,
                is_staff: false,
                is_active: false,
              ),
            );
      }
    } catch (e) {
      DevLogs.logError('Error: $e');
      return User(
        id: 0,
        first_name: "",
        last_name: "",
        email: "",
        city: "",
        phone_number: "",
        username: "",
        is_superuser: false,
        is_staff: false,
        is_active: false,
      );
    }
    return User(
      id: 0,
      first_name: "",
      last_name: "",
      email: "",
      city: "",
      phone_number: "",
      username: "",
      is_superuser: false,
      is_staff: false,
      is_active: false,
    );
  }
}
