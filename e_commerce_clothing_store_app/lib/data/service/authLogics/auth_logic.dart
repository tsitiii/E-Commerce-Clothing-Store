import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../api_service.dart';

class AuthResult {
  final bool success;
  final String? error;

  AuthResult({required this.success, this.error});
}

class AuthService {
  final ApiService _apiService = ApiService();

  Future<AuthResult> SignUp({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      return AuthResult(success: false, error: "Passwords do not match");
    }
    try {
      User user = User(id: 0, username: username, email: email, password: password);
      bool success = await _apiService.signup(user);

      if (success) {
        return AuthResult(success: true);
      } else {
        return AuthResult(
            success: false, error: "Signup failed. Please try again.");
      }
    } catch (e) {
      return AuthResult(
          success: false, error: "Error during signup: ${e.toString()}");
    }
  }

  

Future<AuthResult> Login({
  required String username,
  required String password,
}) async {
  try {
    String? token = await _apiService.login(username, password);

    if (token != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      return AuthResult(success: true);
    } else {
      return AuthResult(success: false, error: "Login failed. Invalid credentials.");
    }
  } catch (e) {
    return AuthResult(success: false, error: "Error during login: ${e.toString()}");
  }
}

}
