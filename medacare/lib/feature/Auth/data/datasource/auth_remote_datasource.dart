// import 'package:dio/dio.dart';

// class AuthRemoteDataSource {

//   AuthRemoteDataSource(this._dio);

//   Future<String> login(String email, String password) async {
//     try {
//       final response = await _dio.post(
//         'https://example.com/api/login',
//         data: {'email': email, 'password': password},
//       );
//       return response.data['token'];
//     } catch (e) {
//       throw Exception('Failed to login: $e');
//     }
//   }

//   Future<void> register(String email, String password) async {
//     try {
//       await _dio.post(
//         'https://example.com/api/register',
//         data: {'email': email, 'password': password},
//       );
//     } catch (e) {
//       throw Exception('Failed to register: $e');
//     }
//   }
// }