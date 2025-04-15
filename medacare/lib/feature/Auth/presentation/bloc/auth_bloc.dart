
import 'package:medacare/feature/Auth/domain/usecase/get_user_profile_usecase.dart';
import 'package:medacare/feature/Auth/domain/usecase/login_user_usecase.dart';
import 'package:medacare/feature/Auth/domain/usecase/logout_usecase.dart';
import 'package:medacare/feature/Auth/domain/usecase/register_user_usecase.dart';
import 'package:medacare/feature/Auth/domain/usecase/verify_email_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUserUseCase registerUserUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;
  final LoginUserUseCase loginUserUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.registerUserUseCase,
    required this.verifyEmailUseCase,
    required this.loginUserUseCase,
    required this.getUserProfileUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<VerifyEmailEvent>(_onVerifyEmail);
    on<LoginUserEvent>(_onLoginUser);
    on<GetUserProfileEvent>(_onGetProfile);
    on<LogoutUserEvent>(_onLogout);
  }

  Future<void> _onRegisterUser(RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUserUseCase.call(event.user);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(RegisteredState(user)),
    );
  }

  Future<void> _onVerifyEmail(VerifyEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await verifyEmailUseCase.call(event.email, event.token);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (jwt) => emit(EmailVerifiedState(jwt)),
    );
  }

  Future<void> _onLoginUser(LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUserUseCase.call(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (jwt) => emit(LoggedInState(jwt)),
    );
  }

  Future<void> _onGetProfile(GetUserProfileEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await getUserProfileUseCase.call();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(UserProfileLoadedState(user)),
    );
  }

  Future<void> _onLogout(LogoutUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logoutUseCase.call();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(LoggedOutState()),
    );
  }
}
