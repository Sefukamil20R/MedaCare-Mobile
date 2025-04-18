import 'package:dartz/dartz.dart';
import 'package:medacare/core/errors/failure.dart';
import 'package:medacare/feature/Auth/domain/entitiy/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> register(User user);
  Future<Either<Failure, String>> verifyEmail(String email, String token);
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, User>> getUserProfile();
  Future<Either<Failure, void>> logout();
}
