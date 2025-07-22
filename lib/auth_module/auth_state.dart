import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final AsyncValue<String?> authResult; // Handles token/loading/error
  final bool isLoggedIn;
  final String? email;

  const AuthState({
    this.authResult = const AsyncValue.data(null),
    this.isLoggedIn = false,
    this.email,
  });

  AuthState copyWith({
    AsyncValue<String?>? authResult,
    bool? isLoggedIn,
    String? email,
  }) {
    return AuthState(
      authResult: authResult ?? this.authResult,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      email: email ?? this.email,
    );
  }
}
