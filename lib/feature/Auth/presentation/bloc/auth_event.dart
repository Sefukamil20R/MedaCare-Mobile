import 'package:equatable/equatable.dart';

import '../../domain/entitiy/user_entity.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends AuthEvent {
  final User user;

  RegisterUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}
class VerifyEmailEvent extends AuthEvent {
  final String email;
  final String token;
  final int expiresIn; 

  VerifyEmailEvent(this.email, this.token, {this.expiresIn = 3600000}); // Default to 1 hour
}
class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;
  final int expiresIn; // Add expiresIn field with a default value

  LoginUserEvent(this.email, this.password, {this.expiresIn = 3600000}); // Default to 1 hour
}

class GetUserProfileEvent extends AuthEvent {}

class LogoutUserEvent extends AuthEvent {}
class ResendVerificationEmailEvent extends AuthEvent {
  final String email;

  ResendVerificationEmailEvent(this.email);

  @override
  List<Object?> get props => [email];
}
class AuthErrorEvent extends AuthEvent {
  final String message;

  AuthErrorEvent(this.message);
}
class CompletePatientProfileEvent extends AuthEvent {
  final Map<String, dynamic> profileData;

  CompletePatientProfileEvent(this.profileData);
}

