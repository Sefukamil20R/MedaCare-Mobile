import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medacare/feature/Auth/data/model/user_model.dart';

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
        print('Registration successful: ${body['message']}');
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
      print('Verifying email: $email with token: $token'); // Log email and token
      final response = await client.post(
        Uri.parse("$baseUrl/auth/verify-email?email=$email&token=$token"),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      final body = jsonDecode(response.body);
      if (response.statusCode == 200 && body['status'] == 'success') {
        final token = body['data']['token'];
        print('Verification successful. Token: $token');

        // Save the token locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);

        return token;
      } else {
        print('Error Response: ${body['message']}');
        throw Exception(body['message'] ?? 'Verification failed');
      }
    } catch (e) {
      print('Error during email verification: $e'); // Log the error
      throw Exception('Error during email verification: $e');
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

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    final body = jsonDecode(response.body);
    if (response.statusCode == 200 && body['status'] == 'success') {
      final token = body['data']['token'];

      // Save the token locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      print('Token saved successfully during login: $token'); // Add this log

      return token;
    } else {
      throw Exception(body['message'] ?? 'Login failed');
    }
  } catch (e) {
    print('Error during login: $e');
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
    print('Response Status Code (Profile fetching): ${response.statusCode}');
    print('Response Body (Profile Fetching): ${response.body}');
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return UserModel.fromJson(body);
    } else {
      throw Exception(body['message'] ?? 'Failed to fetch profile');
    }
  } catch (e) {
    print('Error during fetching user profile: $e');
    throw Exception('Error during fetching user profile: $e');
  }
}

  @override
  Future<void> logout() async {
    try {
      // Clear token from local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('jwt_token'); // Remove only the token
      print('User logged out successfully');
    } catch (e) {
      throw Exception('Error during logout: $e');
    }
  }

  @override
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
@override
Future<void> completePatientProfile(Map<String, dynamic> profileData) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    print('Token retrieved during profile completion: $token');

    if (token == null) {
      print('Error: Authorization token is null.');
      throw Exception('Authorization token is missing. Please log in again.');
    }
   // 🔍 Log the profile data (original map)
    print('📦 Raw profileData map: $profileData');

    // 🔍 Log the encoded JSON body
    final encodedBody = jsonEncode(profileData);
    print('🧾 Encoded JSON body: $encodedBody');

    print('Sending profile data: $profileData');
    final response = await client.post(
      Uri.parse("$baseUrl/patients"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(profileData),
    );

    print('Response Status Code (Profile Completion): ${response.statusCode}');
    print('Response Body (Profile Completion): ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Failed to complete profile');
    }
  } catch (e) {
    print('Error during profile completion: $e');
    throw Exception('Error during profile completion: $e');
  }
}
}