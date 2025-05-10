import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/auth/api/auth_api.dart';
import 'package:portal/features/auth/model/registration_model.dart';
import 'package:portal/features/auth/model/user_model.dart';
import 'package:get/get.dart';
import 'package:portal/features/auth/services/user_services.dart';

class AuthServices {
  var authApi = AuthApi();

  Future<User> login(String username, String password) async {
    final String usernameEmail = username.trim();

    try {
      // if (!usernameRegex.hasMatch(usernameEmail)) {
      //   throw Exception('Invalid email format');
      // }

      final response = await authApi.login(usernameEmail, password);
      if (response.success) {
        // Ensure the values are strings before saving
        final accessToken = response.data["access"]?.toString();
        final refreshToken = response.data["refresh"]?.toString();
        final userId = response.data["user"]?.toString();

        if (accessToken == null || refreshToken == null || userId == null) {
          throw Exception('Invalid response data');
        }

        await saveSP("token", accessToken);
        await saveSP("refresh_token", refreshToken);
        await saveSP("user", userId);

        // Get user ID as int for API call
        final userIdInt = int.parse(userId);
        final user = await UserService().getUserById(userIdInt);

        await saveSP("city", user.city.toString());
        await saveSP("user_full_name", '${user.first_name} ${user.last_name}');

        DevLogs.logInfo("User logged in: ${user.username}");
        return user;
      }
      throw Exception('Login failed');
    } catch (e) {
      DevLogs.logError("Login error: $e");
      return User.empty();
    }
  }

  Future<bool> logout() async {
    try {
      final response = await authApi.logout();
      if (response.success) {
        await clearSP();
        DevLogs.logInfo("User logged out successfully");
        return true;
      } else {
        DevLogs.logError("Logout failed: ${response.message}");
        return false;
      }
    } catch (e) {
      DevLogs.logError("Logout error: $e");
      return false;
    }
  }
}
