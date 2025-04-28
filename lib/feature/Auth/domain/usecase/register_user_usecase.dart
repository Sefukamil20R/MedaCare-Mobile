import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entitiy/user_entity.dart';
import '../repository/auth_repository.dart';


class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<Either<Failure, User>> call(User user) {
    print("RegisterUserUseCase called with user: $user");
    return repository.register(user);
  }
}
