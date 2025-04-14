import 'package:dartz/dartz.dart';
import 'package:medacare/core/errors/failure.dart';
import 'package:medacare/feature/Auth/domain/repository/auth_repository.dart';

class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<Either<Failure, String>> call(String email, String token) {
    return repository.verifyEmail(email, token);
  }
}
