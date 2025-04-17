import 'package:equatable/equatable.dart';
import 'package:medacare/feature/Auth/domain/entitiy/user_entity.dart';

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

  VerifyEmailEvent(this.email, this.token);

  @override
  List<Object?> get props => [email, token];
}

class LoginUserEvent extends AuthEvent {
  final String email;
  final String password;

  LoginUserEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class GetUserProfileEvent extends AuthEvent {}

class LogoutUserEvent extends AuthEvent {}
class ResendVerificationEmailEvent extends AuthEvent {
  final String email;

  ResendVerificationEmailEvent(this.email);

  @override
  List<Object?> get props => [email];
}