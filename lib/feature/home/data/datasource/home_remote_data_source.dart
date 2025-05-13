import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/institution_model.dart';
import '../models/physician_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<InstitutionModel>> getRecommendedInstitutions(String token);
  Future<List<PhysicianModel>> getRecommendedPhysicians(String token);
  Future<List<InstitutionModel>> getAllInstitutions(String token);
  Future<List<PhysicianModel>> getAllPhysicians(String token);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;

  HomeRemoteDataSourceImpl({required this.client});

  static const _baseUrl = 'https://medacare-be.onrender.com/api/v1';

  Map<String, String> _buildHeaders(String token) {
    print('Token used in headers: $token'); // Log the token
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
Future<List<PhysicianModel>> getRecommendedPhysicians(String token) async {
  try {
    print('Fetching recommended physicians with token: $token');
    final response = await client.get(
      Uri.parse('$_baseUrl/recommendations/physician'),
      headers: _buildHeaders(token),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      print('Parsed Physicians JSON: $jsonList'); // Log parsed JSON
      return jsonList.map((json) => PhysicianModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recommended physicians');
    }
  } catch (e) {
    print('Error fetching recommended physicians: $e');
    throw Exception('Failed to get recommended physicians: $e');
  }
}
  @override
  Future<List<InstitutionModel>> getRecommendedInstitutions(String token) async {
    try {
      print('Fetching recommended institutions...');
      final response = await client.get(
        Uri.parse('$_baseUrl/recommendations/institution'),
        headers: _buildHeaders(token),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => InstitutionModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recommended institutions');
      }
    } catch (e) {
      print('Error fetching recommended institutions: $e');
      throw Exception('Failed to get recommended institutions: $e');
    }
  }

  @override
  Future<List<InstitutionModel>> getAllInstitutions(String token) async {
    try {
      print('Fetching all institutions...');
      final response = await client.get(
        Uri.parse('$_baseUrl/institutions'),
        headers: _buildHeaders(token),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => InstitutionModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load all institutions');
      }
    } catch (e) {
      print('Error fetching all institutions: $e');
      throw Exception('Failed to get all institutions: $e');
    }
  }

  @override
  Future<List<PhysicianModel>> getAllPhysicians(String token) async {
    try {
      print('Fetching all physicians...');
      final response = await client.get(
        Uri.parse('$_baseUrl/physicians'),
        headers: _buildHeaders(token),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => PhysicianModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load all physicians');
      }
    } catch (e) {
      print('Error fetching all physicians: $e');
      throw Exception('Failed to get all physicians: $e');
    }
  }
}