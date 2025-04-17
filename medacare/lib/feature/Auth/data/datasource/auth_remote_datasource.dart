import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medacare/feature/Auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> register(UserModel userModel);
  Future<String> verifyEmail(String email, String token);
  Future<String> login(String email, String password);
  Future<UserModel> getUserProfile(String token);
  Future<void> logout();
  Future<void> resendVerificationEmail(String email);
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
    print('Request Payload: $payload'); // Log the payload

    final response = await client.post(
      Uri.parse("$baseUrl/auth/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payload),
    );

    print('API Response: ${response.body}');

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

    print('API Response: ${response.body}'); // Log the response

    final body = jsonDecode(response.body);
    if (response.statusCode == 200 && body['status'] == 'success') {
      // Return the data field directly as a String
      return body['data'];
    } else {
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

      final body = jsonDecode(response.body);
      if (response.statusCode == 200 && body['status'] == 'success') {
        print('user logged in  successfully'); // Log the response
        return body['data']['token'];
        
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
    // If your backend doesn't have logout, clear token from cache
    return;
  }
 Future<void> resendVerificationEmail(String email) async {
    try {
      final response = await client.post(
        Uri.parse("$baseUrl/auth/email/verification?email=$email"),
      );

      print('API Response: ${response.body}'); // Log the response

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
}