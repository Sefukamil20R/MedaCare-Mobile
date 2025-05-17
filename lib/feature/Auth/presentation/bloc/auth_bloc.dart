import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecase/ResendVerificationEmailUseCase.dart';
import '../../domain/usecase/completeprofile.dart';
import '../../domain/usecase/get_user_profile_usecase.dart';
import '../../domain/usecase/login_user_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../domain/usecase/password_reset_usecases.dart';
import '../../domain/usecase/register_user_usecase.dart';
import '../../domain/usecase/verify_email_usecase.dart';

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
  final SendResetPasswordEmailUseCase sendResetPasswordEmailUseCase;
  final VerifyResetCodeUseCase verifyResetCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthBloc({
    required this.registerUserUseCase,
    required this.verifyEmailUseCase,
    required this.loginUserUseCase,
    required this.getUserProfileUseCase,
    required this.logoutUseCase,
    required this.resendVerificationEmailUseCase,
    required this.completePatientProfileUseCase,
    required this.sendResetPasswordEmailUseCase,
    required this.verifyResetCodeUseCase, 
    required this.resetPasswordUseCase,
  }) : super(AuthInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<VerifyEmailEvent>(_onVerifyEmail);
    on<LoginUserEvent>(_onLoginUser);
    on<GetUserProfileEvent>(_onGetProfile);
    on<LogoutUserEvent>(_onLogout);
    on<ResendVerificationEmailEvent>(_onResendVerificationEmail);
    on<CompletePatientProfileEvent>(_onCompletePatientProfile);
    on<SendResetPasswordEmailEvent>(_onSendResetPasswordEmail);
    on<VerifyResetCodeEvent>(_onVerifyResetCode);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onRegisterUser(RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUserUseCase.call(event.user);
    result.fold(
      (failure) {
        print('Register API Error: ${failure.message}');
        emit(AuthError(failure.message));
      },
      (user) {
        print('Register API Success: User registered successfully');
        emit(RegisteredState(user));
      },
    );
  }

  Future<void> _onVerifyEmail(VerifyEmailEvent event, Emitter<AuthState> emit) async {
    emit(VerifyLoading());
    final result = await verifyEmailUseCase.call(event.email, event.token);
    result.fold(
      (failure) {
        print('Verify Email API Error: ${failure.message}');
        emit(AuthError(failure.message));
      },
      (jwt) {
        print('Verify Email API Success: JWT Token: $jwt');
        emit(EmailVerifiedState(jwt));
        // After verification, navigate to the login page
        emit(NavigateToLoginState());
      },
    );
  }

  // Future<void> _onLoginUser(LoginUserEvent event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading()); // Emit loading state
  //   try {
  //     final result = await loginUserUseCase.call(event.email, event.password);

  //     await result.fold(
  //       (failure) async {
  //         print('Login API Error: ${failure.message}');
  //         emit(AuthError(failure.message)); // Emit error state
  //       },
  //       (jwt) async {
  //         if (jwt == null || jwt.isEmpty) {
  //           print('Login API Error: Received null or empty JWT token');
  //           emit(AuthError('Login failed: Invalid token received')); // Emit error state
  //           return;
  //         }

  //         // Save the token locally
  //         final prefs = await SharedPreferences.getInstance();
  //         await prefs.setString('jwt_token', jwt);

  //         print('Login API Success: JWT token saved: $jwt');
  //         emit(LoggedInState(jwt)); // Emit success state
  //       },
  //     );
  //   } catch (e) {
  //     print('Unexpected error during login: $e');
  //     emit(AuthError('Unexpected error occurred during login.')); // Emit error state
  //   }
  // }
  
Future<void> _onLoginUser(LoginUserEvent event, Emitter<AuthState> emit) async {
  emit(AuthLoading()); // Emit loading state
  try {
    final result = await loginUserUseCase.call(event.email, event.password);

    await result.fold(
      (failure) async {
        print('Login API Error: ${failure.message}');
        emit(AuthError(failure.message)); // Emit error state
      },
      (jwt) async {
        if (jwt == null || jwt.isEmpty) {
          print('Login API Error: Received null or empty JWT token');
          emit(AuthError('Login failed: Invalid token received')); // Emit error state
          return;
        }

        // Save the token locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', jwt);

        print('Login API Success: JWT token saved: $jwt');

        // Fetch user profile after login
        final profileResult = await getUserProfileUseCase.call();
        profileResult.fold(
          (failure) {
            print('Get Profile API Error: ${failure.message}');
            emit(AuthError(failure.message));
          },
          (user) {
            print('Get Profile API Success: User profile loaded');
            emit(UserProfileLoadedState(user)); // <-- Use this for navigation
          },
        );
      },
    );
  } catch (e) {
    print('Unexpected error during login: $e');
    emit(AuthError('Unexpected error occurred during login.')); // Emit error state
  }
}
  Future<void> _onGetProfile(GetUserProfileEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await getUserProfileUseCase.call();
    result.fold(
      (failure) {
        print('Get Profile API Error: ${failure.message}');
        emit(AuthError(failure.message));
      },
      (user) {
        print('Get Profile API Success: User profile loaded');
        emit(UserProfileLoadedState(user));
      },
    );
  }

  Future<void> _onLogout(LogoutUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logoutUseCase.call();
    result.fold(
      (failure) {
        print('Logout API Error: ${failure.message}');
        emit(AuthError(failure.message));
      },
      (_) {
        print('Logout API Success: User logged out');
        emit(LoggedOutState());
      },
    );
  }

  Future<void> _onResendVerificationEmail(
      ResendVerificationEmailEvent event, Emitter<AuthState> emit) async {
    emit(ResendEmailLoading());
    try {
      await resendVerificationEmailUseCase.call(event.email);
      print('Resend Verification Email API Success: Email resent successfully');
      emit(ResendEmailSuccess());
    } catch (e) {
      print('Resend Verification Email API Error: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCompletePatientProfile(
      CompletePatientProfileEvent event, Emitter<AuthState> emit) async {
    emit(ProfileCompletionLoading());
    try {
      await completePatientProfileUseCase.call(event.profileData);
      print('Complete Profile API Success: Profile completed successfully');
      emit(ProfileCompletionSuccess());
      // After completing the profile, navigate to the home page
      emit(NavigateToHomeState());
    } catch (e) {
      print('Complete Profile API Error: $e');
      emit(ProfileCompletionError(e.toString()));
    }
  }
  Future<void> _onSendResetPasswordEmail(
    SendResetPasswordEmailEvent event, Emitter<AuthState> emit) async {
  emit(ResetPasswordLoading());
  try {
    await sendResetPasswordEmailUseCase(event.email);
    emit(ResetPasswordEmailSent());
  } catch (e) {
    emit(ResetPasswordError(e.toString()));
  }
}

Future<void> _onVerifyResetCode(
    VerifyResetCodeEvent event, Emitter<AuthState> emit) async {
  emit(ResetPasswordLoading());
  try {
    await verifyResetCodeUseCase(event.email, event.code);
    emit(ResetPasswordCodeVerified());
  } catch (e) {
    emit(ResetPasswordError(e.toString()));
  }
}

Future<void> _onResetPassword(
    ResetPasswordEvent event, Emitter<AuthState> emit) async {
  emit(ResetPasswordLoading());
  try {
    await resetPasswordUseCase(event.email, event.newPassword);
    emit(ResetPasswordSuccess());
  } catch (e) {
    emit(ResetPasswordError(e.toString()));
  }
}
  
}