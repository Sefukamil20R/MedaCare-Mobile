import 'package:equatable/equatable.dart';

import '../../domain/entitiy/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class VerifyLoading extends AuthState {}

class ResendEmailLoading extends AuthState {}

class ResendEmailSuccess extends AuthState {
  final String message;

  ResendEmailSuccess({this.message = 'Verification email resent successfully.'});

  @override
  List<Object?> get props => [message];
}

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
  final User user; // <-- Add this


  LoggedInState(this.jwt , this.user); // <-- Modify constructor to accept user

  @override
  List<Object?> get props => [jwt,user]; // <-- Include user in props
}

class UserProfileLoadedState extends AuthState {
  final User user;

  UserProfileLoadedState(this.user);

  @override
  List<Object?> get props => [user];
}

class LoggedOutState extends AuthState {}

class AuthMessage extends AuthState {
  final String message;

  AuthMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileCompletionLoading extends AuthState {}

class ProfileCompletionSuccess extends AuthState {}

class ProfileCompletionError extends AuthState {
  final String message;

  ProfileCompletionError(this.message);

  @override
  List<Object?> get props => [message];
}

class NavigateToLoginState extends AuthState {}

class NavigateToHomeState extends AuthState {}
class ResetPasswordLoading extends AuthState {}
class ResetPasswordEmailSent extends AuthState {}
class ResetPasswordCodeVerified extends AuthState {}
class ResetPasswordSuccess extends AuthState {}
class ResetPasswordError extends AuthState {
  final String message;
  ResetPasswordError(this.message);
}