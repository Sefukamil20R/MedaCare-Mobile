import 'package:dartz/dartz.dart';
import 'package:medacare/core/errors/failure.dart';

import 'package:medacare/feature/Auth/data/datasource/auth_remote_datasource.dart';
import 'package:medacare/feature/Auth/data/model/user_model.dart';
import 'package:medacare/feature/Auth/domain/entitiy/user_entity.dart';
import 'package:medacare/feature/Auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> register(User user) async {
    try {
      final result = await remoteDataSource.register(UserModel(
        id: user.id,
        email: user.email,
        password: user.password,
        firstName: user.firstName,
        lastName: user.lastName,
      ));
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString(), message: 'Failed to register user'));
    }
  }

  @override
  Future<Either<Failure, String>> verifyEmail(String email, String token) async {
    try {
      final jwt = await remoteDataSource.verifyEmail(email, token);
      return Right(jwt);
    } catch (e) {
      return Left(ServerFailure(e.toString(), message: 'Failed to verify email'));
    }
  }

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      final jwt = await remoteDataSource.login(email, password);
      return Right(jwt);
    } catch (e) {
      return Left(ServerFailure(e.toString(), message: 'Failed to login'));
    }
  }

  @override
  Future<Either<Failure, User>> getUserProfile() async {
    try {
      // You can inject token from storage here (ex: shared_prefs)
      const token = 'your_token_here';
      final user = await remoteDataSource.getUserProfile(token);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString(), message: ' failed to get profile'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString(), message: 'failed to log out'));
    }
  }
}
