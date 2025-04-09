import 'package:medacare/feature/Auth/domain/repository/auth_repository.dart';

class SignUpPatientUseCase {
  final AuthRepository repository;

  SignUpPatientUseCase(this.repository);

  // Future<Either<Failure, Patient>> signUpPatient(Patient patient) {
  //   return repository.signUpPatient(patient);
  // }
}