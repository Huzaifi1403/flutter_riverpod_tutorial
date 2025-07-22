import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/auth_module/auth_apihandler.dart';
import 'package:flutter_riverpod_tutorial/auth_module/auth_state.dart';
import 'package:http/http.dart' as http; // Add this import

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

final authApiServiceProvider = Provider((ref) {
  // This would be your API service for authentication
  return AuthApihandler(client: http.Client());
});

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState(); // Initial state
  }

  Future<void> login({required String email, required String password}) async {
    // Set loading state for authResult
    debugPrint('Login called with email: $email and password: $password');
    state = state.copyWith(authResult: const AsyncValue.loading());
    try {
      final authService = ref.read(authApiServiceProvider);
      final token = await authService.login(email: email, password: password);
      // On success
      if (token != null) {
        state = state.copyWith(
          authResult: AsyncValue.data(token),
          isLoggedIn: true,
          email: email,
        );
      } else {
        // Handle error case
        debugPrint('Login failed: Token is null');
        state = state.copyWith(
          authResult: const AsyncValue.error("Login failed", StackTrace.empty),
        );
      }
    } catch (e, st) {
      debugPrint('Login error: $e');
      state = state.copyWith(authResult: AsyncValue.error(e, st));
    }
  }

  Future<void> register(
      {required String email, required String password}) async {
    // Set loading state for authResult
    debugPrint('Register called with email: $email and password: $password');
    state = state.copyWith(authResult: const AsyncValue.loading());
    try {
      final authService = ref.read(authApiServiceProvider);
      final token =
          await authService.register(email: email, password: password);
      // On success
      if (token != null) {
        debugPrint('Registration successful: $token');
        state = state.copyWith(
          authResult: AsyncValue.data(token),
          isLoggedIn: true,
          email: email,
        );
      } else {
        // Handle error case
        debugPrint('Registration failed: Token is null');
        state = state.copyWith(
          authResult:
              const AsyncValue.error("Registration failed", StackTrace.empty),
        );
      }
    } catch (e, st) {
      state = state.copyWith(authResult: AsyncValue.error(e, st));
    }
  }
}
