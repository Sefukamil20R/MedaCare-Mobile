
import '../repository/auth_repository.dart';

class CompletePatientProfileUseCase {
  final AuthRepository repository;

  CompletePatientProfileUseCase( this.repository);

  Future<void> call(Map<String, dynamic> profileData) async {
    await repository.completePatientProfile(profileData);
  }
}