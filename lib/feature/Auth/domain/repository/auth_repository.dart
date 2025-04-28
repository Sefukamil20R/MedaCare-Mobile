import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entitiy/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> register(User user);
  Future<Either<Failure, String>> verifyEmail(String email, String token);
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, User>> getUserProfile();
  Future<Either<Failure, void>> logout();
  Future<void> resendVerificationEmail(String email);
   Future<void> completePatientProfile(Map<String, dynamic> profileData);

}
