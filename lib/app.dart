import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Screens/splash.dart';
import 'feature/Auth/domain/usecase/ResendVerificationEmailUseCase.dart';
import 'feature/Auth/domain/usecase/completeprofile.dart';
import 'feature/Auth/domain/usecase/get_user_profile_usecase.dart';
import 'feature/Auth/domain/usecase/login_user_usecase.dart';
import 'feature/Auth/domain/usecase/logout_usecase.dart';
import 'feature/Auth/domain/usecase/register_user_usecase.dart';
import 'feature/Auth/domain/usecase/verify_email_usecase.dart';
import 'feature/Auth/presentation/bloc/auth_bloc.dart';
import 'feature/Auth/presentation/pages/Complete_Profile.dart';
import 'feature/Auth/presentation/pages/Signin_page.dart';
import 'feature/Auth/presentation/pages/Signup_page.dart';
import 'feature/Auth/presentation/pages/home_page.dart';
import 'feature/Auth/presentation/pages/verify_Success.dart';
import 'injection_container.dart';



class MedaCareApp extends StatelessWidget {
  final String initialRoute;

  const MedaCareApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            registerUserUseCase: sl<RegisterUserUseCase>(),
            verifyEmailUseCase: sl<VerifyEmailUseCase>(),
            loginUserUseCase: sl<LoginUserUseCase>(),
            getUserProfileUseCase: sl<GetUserProfileUseCase>(),
            logoutUseCase: sl<LogoutUseCase>(),
            resendVerificationEmailUseCase: sl<ResendVerificationEmailUseCase>(), completePatientProfileUseCase: sl<CompletePatientProfileUseCase>(), // Add this line
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          '/splash': (context) => SplashScreen(),
          '/signup': (context) => SignupScreen(),
          '/signin': (context) => SigninScreen(),
          '/verify_success': (context) => VerificationSuccessScreen(),
          '/home': (context) => ProfileDetailsPage(), // Add profile page route
          '/complete_profile': (context) => CompleteProfilePage(), // Add complete profile page route
        }, // Close routes map
      ),
    );
  }
}