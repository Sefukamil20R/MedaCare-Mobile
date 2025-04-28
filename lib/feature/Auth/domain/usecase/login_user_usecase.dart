import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repository/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository repository;

  LoginUserUseCase(this.repository);

  Future<Either<Failure, String>> call(String email, String password) {
    return repository.login(email, password);
  }
}
