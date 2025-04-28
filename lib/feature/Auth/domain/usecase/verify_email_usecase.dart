import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/auth_repository.dart';


class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<Either<Failure, String>> call(String email, String token) {
    return repository.verifyEmail(email, token);
  }
}
