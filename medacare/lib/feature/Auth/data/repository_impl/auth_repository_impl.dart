import 'package:dartz/dartz.dart';
import 'package:medacare/core/errors/failure.dart';
import 'package:medacare/feature/Auth/data/datasource/auth_remote_datasource.dart';
import 'package:medacare/feature/Auth/data/model/user_model.dart';
import 'package:medacare/feature/Auth/domain/entitiy/user_entity.dart';
import 'package:medacare/feature/Auth/domain/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  static const _tokenKey = 'jwt_token';

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, User>> register(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      await remoteDataSource.register(userModel);
      return Right(user); // registration doesn't return user, only confirmation
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyEmail(String email, String token) async {
    try {
      final jwt = await remoteDataSource.verifyEmail(email, token);
      await sharedPreferences.setString(_tokenKey, jwt);
      return Right(jwt);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final jwt = await remoteDataSource.login(email, password);
      await sharedPreferences.setString(_tokenKey, jwt);
      return Right(jwt);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUserProfile() async {
    try {
      final token = sharedPreferences.getString(_tokenKey);
      if (token == null) {
        return Left(CacheFailure(message: "Token not found"));
      }

      final userModel = await remoteDataSource.getUserProfile(token);
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await sharedPreferences.remove(_tokenKey);
      await remoteDataSource.logout(); // even if it's empty, call it
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: "Failed to clear token"));
    }
  }
  Future<void> resendVerificationEmail(String email) async {
    return await remoteDataSource.resendVerificationEmail(email);
  }
}
