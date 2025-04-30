import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/shared/features/auth/model/user_model.dart';
import 'package:portal/shared/features/auth/services/auth_services.dart';

final authServicesProvider = Provider<AuthServices>((ref) => AuthServices());

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthState {
  final User? user;
  final bool isLoading;

  AuthState({this.user, this.isLoading = false});

  AuthState copyWith({User? user, bool? isLoading}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(AuthState());

  Future<bool> login(String emailOrUsername, String password) async {
    try {
      state = state.copyWith(isLoading: true);
      final user = await _ref
          .read(authServicesProvider)
          .login(emailOrUsername, password);
      state = state.copyWith(user: user, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  void logout() {
    state = AuthState();
  }
}
