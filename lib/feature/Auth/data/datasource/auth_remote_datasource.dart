import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medacare/core/errors/utility.dart';
import 'package:medacare/feature/Auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> register(UserModel userModel);
  Future<String> verifyEmail(String email, String token);
  Future<String> login(String email, String password);
  Future<UserModel> getUserProfile(String token);
  Future<void> logout();
  Future<void> resendVerificationEmail(String email);
  Future<void> completePatientProfile(Map<String, dynamic> profileData);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  final baseUrl = "https://medacare-be.onrender.com/api/v1";

@override
Future<UserModel> register(UserModel userModel) async {
  try {
    final payload = {
      ...userModel.toJson(),
      "origin": "SELF_REGISTERED", // Add the origin field
    };

    final response = await client.post(
      Uri.parse("$baseUrl/auth/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payload),
    );


    final body = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return userModel; // Registration just returns email confirmation, so return local model
    } else {
      throw Exception(body['message'] ?? 'Registration failed');
    }
  } catch (e) {
    print('Error during registration: $e');
    throw Exception('Error during registration: $e');
  }
}
@override
Future<String> verifyEmail(String email, String token) async {
  try {
    final response = await client.post(
      Uri.parse("$baseUrl/auth/verify-email?email=$email&token=$token"),
    );


    final body = jsonDecode(response.body);
    if (response.statusCode == 200 && body['status'] == 'success') {
      final token = body['data']['token'];
      final expiresIn = body['data']['expiresIn'];
      print('Token: $token, Expires In: $expiresIn'); // Log the token and expiration
      // Save token and expiration locally
      final prefs = await SharedPreferences.getInstance();
      final expirationDate = DateTime.now().add(Duration(milliseconds: expiresIn));
      await prefs.setString('token', token);
      await prefs.setString('token_expiration', expirationDate.toIso8601String());

      // Schedule automatic logout
      scheduleLogout(expiresIn);

      return token;
    } else {
      throw Exception(ErrorMapper.getFriendlyMessage(body['message'] ?? 'Verification failed'));
    }
  } catch (e) {
    print('Error during email verification: $e'); // Log the error
    throw Exception(ErrorMapper.getFriendlyMessage(e.toString()));
  }
}
@override
Future<String> login(String email, String password) async {
  try {
    final response = await client.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );


    final body = jsonDecode(response.body);
    if (response.statusCode == 200 && body['status'] == 'success') {
      final token = body['data']['token'];

      // Save the token locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      return token;
    } else {
      throw Exception(body['message'] ?? 'Login failed');
    }
  } catch (e) {
    throw Exception('Error during login: $e');
  }
}
  @override
  Future<UserModel> getUserProfile(String token) async {
    try {
      final response = await client.get(
        Uri.parse("$baseUrl/users/current"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      final body = jsonDecode(response.body);
      if (response.statusCode == 200 && body['status'] == 'success') {
        return UserModel.fromJson(body['data']);
      } else {
        throw Exception(body['message'] ?? 'Failed to fetch profile');
      }
    } catch (e) {
      throw Exception('Error during fetching user profile: $e');
    }
  }

 @override
Future<void> logout() async {
  try {
    // Clear token and expiration from local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all stored data
    print('User logged out successfully');
  } catch (e) {
    throw Exception('Error during logout: $e');
  }
}
 Future<void> resendVerificationEmail(String email) async {
    try {
      final response = await client.post(
        Uri.parse("$baseUrl/auth/email/verification?email=$email"),
      );


      final body = jsonDecode(response.body);
      if (response.statusCode == 200 && body['status'] == 'success') {
        print('Verification email resent successfully');
      } else {
        throw Exception(body['message'] ?? 'Failed to resend verification email');
      }
    } catch (e) {
      print('Error during resending verification email: $e'); // Log the error
      throw Exception('Error during resending verification email: $e');
    }
  }
  void scheduleLogout(int expiresIn) {
  Future.delayed(Duration(milliseconds: expiresIn), () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('Token expired. User logged out automatically.');
    // Notify the UI layer to handle navigation
  });
}

@override
Future<void> completePatientProfile(Map<String, dynamic> profileData) async {
  try {
    // Retrieve the token from SharedPreferences
    final token = await SharedPreferences.getInstance().then((prefs) => prefs.getString('jwt_token'));
    if (token == null) {
      print('Error: Authorization token is null. Ensure the user is logged in and the token is saved.');
      throw Exception('Authorization token is missing. Please log in again.');
    }


    // Send the API request
    final response = await client.post(
      Uri.parse("$baseUrl/patients"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Include token if required
      },
      body: jsonEncode(profileData),
    );

 

    // Handle non-successful responses
    if (response.statusCode != 200 && response.statusCode != 201) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Failed to complete profile');
    }
  } catch (e) {
    print('Error during profile completion: $e'); // Log the error
    throw Exception('Error during profile completion: $e');
  }
}
}