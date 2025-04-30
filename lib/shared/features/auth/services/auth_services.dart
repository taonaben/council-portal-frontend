import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/shared/features/auth/api/auth_api.dart';
import 'package:portal/shared/features/auth/model/user_model.dart';
import 'package:get/get.dart';
import 'package:portal/shared/features/auth/services/user_services.dart';

class AuthServices {
  var authApi = AuthApi();

  Future<User> login(String username, String password) async {
    final String usernameEmail = username.trim();

    final usernameRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    try {
      if (!usernameRegex.hasMatch(usernameEmail)) {
        throw Exception('Invalid email format');
      }

      final response = await authApi.login(usernameEmail, password);
      if (response.success) {
        saveSP("token", response.data["access"]);
        saveSP("refresh_token", response.data["refresh"]);
        saveSP("user", response.data["user"]);

        final user = UserService().getUserById(response.data["user"]);

        // Add to GetX storage
        Get.put(user, tag: "user");
        // user.obs;

        return user;
      }
      throw Exception('Login failed');
    } catch (e) {
      rethrow;
    }
  }
}
