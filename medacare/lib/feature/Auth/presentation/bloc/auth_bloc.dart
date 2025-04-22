import 'package:medacare/feature/Auth/domain/usecase/ResendVerificationEmailUseCase.dart';
import 'package:medacare/feature/Auth/domain/usecase/completeprofile.dart';
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
  final ResendVerificationEmailUseCase resendVerificationEmailUseCase;
  final CompletePatientProfileUseCase completePatientProfileUseCase;
  AuthBloc({
    required this.registerUserUseCase,
    required this.verifyEmailUseCase,
    required this.loginUserUseCase,
    required this.getUserProfileUseCase,
    required this.logoutUseCase,
    required this.resendVerificationEmailUseCase,
    required this.completePatientProfileUseCase,
  }) : super(AuthInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<VerifyEmailEvent>(_onVerifyEmail);
    on<LoginUserEvent>(_onLoginUser);
    on<GetUserProfileEvent>(_onGetProfile);
    on<LogoutUserEvent>(_onLogout);
    on<ResendVerificationEmailEvent>(_onResendVerificationEmail);
    on<CompletePatientProfileEvent>(_onCompletePatientProfile);

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
    emit(VerifyLoading());
    final result = await verifyEmailUseCase.call(event.email, event.token);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (jwt) {
        emit(EmailVerifiedState(jwt));
        // Schedule automatic logout after verification
        scheduleLogout(event.expiresIn);
      },
    );
  }

  Future<void> _onLoginUser(LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUserUseCase.call(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (jwt) {
        emit(LoggedInState(jwt));
        // Schedule automatic logout after login
        // scheduleLogout(event.expiresIn);
      },
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

  Future<void> _onResendVerificationEmail(
      ResendVerificationEmailEvent event, Emitter<AuthState> emit) async {
    emit(ResendEmailLoading());
    try {
      await resendVerificationEmailUseCase.call(event.email);
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void scheduleLogout(int expiresIn) {
    Future.delayed(Duration(milliseconds: expiresIn), () async {
      final result = await logoutUseCase.call();
      result.fold(
        (failure) => add(AuthErrorEvent(failure.message)), // Emit AuthErrorEvent on failure
        (_) => add(LogoutUserEvent()), // Emit LogoutUserEvent on success
      );
    });
  }
   Future<void> _onCompletePatientProfile(
      CompletePatientProfileEvent event, Emitter<AuthState> emit) async {
    emit(ProfileCompletionLoading());
    try {
      await completePatientProfileUseCase.call(event.profileData);
      emit(ProfileCompletionSuccess());
    } catch (e) {
      emit(ProfileCompletionError(e.toString()));
    }
  }
}