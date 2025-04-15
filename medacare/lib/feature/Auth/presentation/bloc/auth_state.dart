import 'package:equatable/equatable.dart';
import 'package:medacare/feature/Auth/domain/entitiy/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class RegisteredState extends AuthState {
  final User user;

  RegisteredState(this.user);

  @override
  List<Object?> get props => [user];
}

class EmailVerifiedState extends AuthState {
  final String jwt;

  EmailVerifiedState(this.jwt);

  @override
  List<Object?> get props => [jwt];
}

class LoggedInState extends AuthState {
  final String jwt;

  LoggedInState(this.jwt);

  @override
  List<Object?> get props => [jwt];
}

class UserProfileLoadedState extends AuthState {
  final User user;

  UserProfileLoadedState(this.user);

  @override
  List<Object?> get props => [user];
}

class LoggedOutState extends AuthState {}
