import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/shared/features/auth/api/auth_api.dart';
import 'package:portal/shared/features/auth/model/registration_model.dart';
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
      // if (!usernameRegex.hasMatch(usernameEmail)) {
      //   throw Exception('Invalid email format');
      // }

      final response = await authApi.login(usernameEmail, password);
      if (response.success) {
        saveSP("token", response.data["access"]);
        saveSP("refresh_token", response.data["refresh"]);
        saveSP(
            "user",
            response.data["user"]
                .toString()); // Convert to string before saving

        // Get user ID directly as int
        final userId = response.data["user"] as int;
        final user = await UserService().getUserById(userId);

        DevLogs.logInfo("User logged in: ${user.username}");

        return user;
      }
      throw Exception('Login failed');
    } catch (e) {
      DevLogs.logError("Login error: $e");
      return User.empty();
    }
  }

  Future<ApiResponse> register(RegistrationModel userData) async {
    try {
      final response = await authApi.register(userData);
      if (response.success) {
        saveSP("token", response.data["access"]);
        saveSP("refresh_token", response.data["refresh"]);
        saveSP("user", response.data["user"]);
        return response;
      }
      throw Exception('Registration failed');
    } catch (e) {
      DevLogs.logError("Registration error: $e");
      return ApiResponse(
          success: false, message: "Registration error", data: {});
    }
  }

  Future<User> submitUserData({
    required String username,
    required String first_name,
    required String email,
    required String password,
    required String password2,
    required String last_name,
    required String phone_number,
    required String city,
  }) async {
    try {
      RegistrationModel user = RegistrationModel(
        username: username,
        email: email,
        password: password,
        password2: password2,
        first_name: first_name,
        last_name: last_name,
        phone_number: phone_number,
        city: city,
      );

      final response = await register(user);
      if (response.success) {
        DevLogs.logInfo("User data submitted successfully");

        final userId = response.data["user"] is int
            ? response.data["user"]
            : response.data["user"]?["id"];

        if (userId == null) throw Exception("Invalid user data in response");

        final user = await UserService().getUserById(userId);
        return user;
      } else {
        DevLogs.logError("Failed to submit user data: ${response.message}");
        return User.empty();
      }
    } catch (e) {
      DevLogs.logError("Submit user data error: $e");
      return User.empty();
    }
  }
}
