import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class ApiService {
  final String _baseUrl = 'https://fakestoreapi.com/users';
  final String _logUrl = 'https://fakestoreapi.com/auth/login';

  Future<bool> signup(User user) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(user.toJson()),
    );
    print('Signup status: ${response.statusCode}');
    print('Signup response: ${response.body}');
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<String?> login(String username, String password) async {
    try {
          final response = await http.post(
            Uri.parse(_logUrl),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'username': username,
              'password': password,
            }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final token = data['token'];
        print("Logged in! Token: $token");
        print("username:");
        return token;
      } else {
        print("Login failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error during login: $e");
      return null;
    }
  }
}
