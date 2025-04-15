import 'package:dartz/dartz.dart';
import 'package:medacare/core/errors/failure.dart';
import 'package:medacare/feature/Auth/domain/entitiy/user_entity.dart';
import 'package:medacare/feature/Auth/domain/repository/auth_repository.dart';

class GetUserProfileUseCase {
  final AuthRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<Either<Failure, User>> call() {
    return repository.getUserProfile();
  }
}
