import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/shared/features/auth/model/user_model.dart';
import 'package:portal/shared/features/auth/users_list.dart';

final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

class UserService {
  Future<User?> login(String emailOrUsername, String password) async {
    // Simulate API call with dummy data
    await Future.delayed(const Duration(seconds: 1));
    for (var user in users) {
      if ((emailOrUsername == user['email_address'] ||
              emailOrUsername == user['username']) &&
          password == user['password']) {
        return User(
          id: user['id'],
          username: user['username'],
          firstName: user['first_name'],
          lastName: user['last_name'],
          emailAddress: user['email_address'],
          phoneNumber: user['phone_number'],
          city: user['city'],
          isAdmin: user['isAdmin'],
          isStaff: user['isStaff'],
          isActive: user['isActive'],
        );
      }
    }
    return null;
  }
}
