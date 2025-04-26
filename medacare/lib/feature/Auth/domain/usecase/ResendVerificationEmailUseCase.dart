import 'package:medacare/feature/Auth/domain/repository/auth_repository.dart';

class ResendVerificationEmailUseCase {
  final AuthRepository repository;

  ResendVerificationEmailUseCase(this.repository);

  Future<void> call(String email) async {
    return await repository.resendVerificationEmail(email);
  }
}