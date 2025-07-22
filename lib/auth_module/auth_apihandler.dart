import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthApihandler {
  final http.Client client;
  final String baseUrl = "https://reqres.in/api";
  final Map<String, String> _headers = {
    'x-api-key': 'reqres-free-v1',
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  AuthApihandler({required this.client});

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      headers: _headers,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["token"];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/register'),
        headers: _headers,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.body; // Assuming the response contains a token
      } else {
        throw Exception('Failed to register');
      }
    } on Exception catch (e) {
      // TODO
      debugPrint('Error during registration: $e');
    }
    return null;
  }

  Future<void> logout() async {
    final response = await client.post(
      Uri.parse('$baseUrl/logout'),
      headers: _headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to logout');
    }
  }
}
