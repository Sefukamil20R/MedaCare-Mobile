import 'package:dartz/dartz.dart';
import 'package:medacare/core/errors/failure.dart';
import 'package:medacare/feature/Auth/domain/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.logout();
  }
}
