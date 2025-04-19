import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medacare/Screens/splash.dart';
import 'package:medacare/feature/Auth/domain/usecase/ResendVerificationEmailUseCase.dart';
import 'package:medacare/feature/Auth/presentation/bloc/auth_bloc.dart';
import 'package:medacare/feature/Auth/domain/usecase/register_user_usecase.dart';
import 'package:medacare/feature/Auth/domain/usecase/verify_email_usecase.dart';
import 'package:medacare/feature/Auth/domain/usecase/login_user_usecase.dart';
import 'package:medacare/feature/Auth/domain/usecase/get_user_profile_usecase.dart';
import 'package:medacare/feature/Auth/domain/usecase/logout_usecase.dart';
import 'package:medacare/feature/Auth/presentation/pages/Signin_page.dart';
import 'package:medacare/feature/Auth/presentation/pages/Signup_page.dart';
import 'package:medacare/feature/Auth/presentation/pages/verify_page.dart';
import 'package:medacare/injection_container.dart';


class MedaCareApp extends StatelessWidget {
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
            resendVerificationEmailUseCase: sl<ResendVerificationEmailUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
  routes: {
    '/': (context) => SplashScreen(),
    '/signup': (context) => SignupScreen(),
    '/signin': (context) => SigninScreen(),
    // '/verify': (context) => VerifyPage(), // Add this route
  },
      ),
    );
  }
}
