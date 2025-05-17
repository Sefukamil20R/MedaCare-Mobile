import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class BookingRemoteDataSource {
  Future<List<String>> getAvailableDates(int physicianId);
  Future<List<int>> getAvailableDurations(int physicianId, String date);
  Future<List<Map<String, dynamic>>> getAvailableSlots(int physicianId, String date, int duration);
  Future<Map<String, dynamic>> bookSlot(int slotId);
  Future<void> finalizeBooking(int slotId);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final http.Client client;

  BookingRemoteDataSourceImpl({required this.client});

  static const _baseUrl = 'https://medacare-be.onrender.com/api/v1';

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    if (token == null) {
      throw Exception('Authorization token is missing. Please log in again.');

    }
    print('Token retrieved: $token'); // Log the token for debugging

    return token;
  }

  Map<String, String> _buildHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
@override
Future<List<String>> getAvailableDates(int physicianId) async {
  final token = await _getToken();
  final url = Uri.parse('$_baseUrl/physicians/$physicianId/available/dates');
  print('Fetching available dates for physicianId: $physicianId');
  print('API URL: $url');

  try {
    final response = await client.get(url, headers: _buildHeaders(token));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return List<String>.from(body['data']);
    } else {
      throw Exception('Failed to fetch available dates: ${response.body}');
    }
  } catch (e) {
    print('Error fetching available dates: $e');
    throw Exception('Error fetching available dates: $e');
  }
}

@override
Future<List<int>> getAvailableDurations(int physicianId, String date) async {
  final token = await _getToken();
  final url = Uri.parse('$_baseUrl/physicians/$physicianId/available/durations/$date');
  print('Fetching available durations for physicianId: $physicianId on date: $date');
  print('API URL: $url');

  try {
    final response = await client.get(url, headers: _buildHeaders(token));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return List<int>.from(body['data']);
    } else {
      throw Exception('Failed to fetch available durations: ${response.body}');
    }
  } catch (e) {
    print('Error fetching available durations: $e');
    throw Exception('Error fetching available durations: $e');
  }
}

@override
Future<List<Map<String, dynamic>>> getAvailableSlots(int physicianId, String date, int duration) async {
  final token = await _getToken();
  final url = Uri.parse('$_baseUrl/physicians/$physicianId/available-slots/$date/$duration');
  print('Fetching available slots for physicianId: $physicianId on date: $date with duration: $duration');
  print('API URL: $url');

  try {
    final response = await client.get(url, headers: _buildHeaders(token));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(body['data']);
    } else {
      throw Exception('Failed to fetch available slots: ${response.body}');
    }
  } catch (e) {
    print('Error fetching available slots: $e');
    throw Exception('Error fetching available slots: $e');
  }
}
@override
Future<Map<String, dynamic>> bookSlot(int slotId) async {
  final token = await _getToken();
  final url = Uri.parse('$_baseUrl/physicians/book/slot/$slotId');
  print('Booking slot with ID: $slotId');
  print('API URL: $url');

  try {
    final response = await client.post(url, headers: _buildHeaders(token));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['data'];
    } else {
      throw Exception('Failed to book slot: ${response.body}');
    }
  } catch (e) {
    print('Error booking slot: $e');
    throw Exception('Error booking slot: $e');
  }
}

@override
Future<void> finalizeBooking(int slotId) async {
  final token = await _getToken();
  final url = Uri.parse('$_baseUrl/physicians/booking/finalization/$slotId');
  print('Finalizing booking for slot ID: $slotId');
  print('API URL: $url');

  try {
    final response = await client.post(url, headers: _buildHeaders(token));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to finalize booking: ${response.body}');
    }
  } catch (e) {
    print('Error finalizing booking: $e');
    throw Exception('Error finalizing booking: $e');
  }
}
}