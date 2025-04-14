import 'package:dartz/dartz.dart';
import 'package:medacare/core/errors/failure.dart';
import 'package:medacare/feature/Auth/domain/entitiy/user_entity.dart';
import 'package:medacare/feature/Auth/domain/repository/auth_repository.dart';


class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<Either<Failure, User>> call(User user) {
    return repository.register(user);
  }
}
