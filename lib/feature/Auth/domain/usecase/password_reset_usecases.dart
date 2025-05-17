import '../repository/auth_repository.dart';
class SendResetPasswordEmailUseCase {
  final AuthRepository repo;
  SendResetPasswordEmailUseCase(this.repo);
  Future<void> call(String email) => repo.sendResetPasswordEmail(email);
}

class VerifyResetCodeUseCase {
  final AuthRepository repo;
  VerifyResetCodeUseCase(this.repo);
  Future<void> call(String email, String code) => repo.verifyResetCode(email, code);
}

class ResetPasswordUseCase {
  final AuthRepository repo;
  ResetPasswordUseCase(this.repo);
  Future<void> call(String email, String newPassword) => repo.resetPassword(email, newPassword);
}