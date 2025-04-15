import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medacare/feature/Auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> register(UserModel userModel);
  Future<String> verifyEmail(String email, String token);
  Future<String> login(String email, String password);
  Future<UserModel> getUserProfile(String token);
  Future<void> logout(); 
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  final baseUrl = "https://medacare-be.onrender.com/api/v1";

  @override
  Future<UserModel> register(UserModel userModel) async {
    final response = await client.post(
      Uri.parse("$baseUrl/auth/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userModel.toJson()),
    );

    final body = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return userModel; // registration just returns email confirmation, so return local model
    } else {
      throw Exception(body['message'] ?? 'Registration failed');
    }
  }

  @override
  Future<String> verifyEmail(String email, String token) async {
    final response = await client.get(
      Uri.parse("$baseUrl/auth/verify-email?email=$email&token=$token"),
    );

    final body = jsonDecode(response.body);
    if (response.statusCode == 200 && body['status'] == 'success') {
      return body['data']['token'];
    } else {
      throw Exception(body['message'] ?? 'Verification failed');
    }
  }

  @override
  Future<String> login(String email, String password) async {
    final response = await client.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final body = jsonDecode(response.body);
    if (response.statusCode == 200 && body['status'] == 'success') {
      return body['data']['token'];
    } else {
      throw Exception(body['message'] ?? 'Login failed');
    }
  }

  @override
  Future<UserModel> getUserProfile(String token) async {
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
  }

  @override
  Future<void> logout() async {
    // if your backend doesn't have logout, clear token from cache
    return;
  }
}
