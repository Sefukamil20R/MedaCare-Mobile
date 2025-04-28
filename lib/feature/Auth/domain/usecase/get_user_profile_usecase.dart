import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entitiy/user_entity.dart';
import '../repository/auth_repository.dart';


class GetUserProfileUseCase {
  final AuthRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<Either<Failure, User>> call() {
    return repository.getUserProfile();
  }
}
