import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Screens/splash.dart';
import 'feature/Auth/data/services/auth_service.dart';
import 'feature/Auth/domain/usecase/ResendVerificationEmailUseCase.dart';
import 'feature/Auth/domain/usecase/completeprofile.dart';
import 'feature/Auth/domain/usecase/get_user_profile_usecase.dart';
import 'feature/Auth/domain/usecase/login_user_usecase.dart';
import 'feature/Auth/domain/usecase/logout_usecase.dart';
import 'feature/Auth/domain/usecase/password_reset_usecases.dart';
import 'feature/Auth/domain/usecase/register_user_usecase.dart';
import 'feature/Auth/domain/usecase/verify_email_usecase.dart';
import 'feature/Auth/presentation/bloc/auth_bloc.dart';
import 'feature/Auth/presentation/pages/Complete_Profile.dart';
import 'feature/Auth/presentation/pages/Signin_page.dart';
import 'feature/Auth/presentation/pages/Signup_page.dart';
import 'feature/Auth/presentation/pages/profile.dart';
import 'feature/Auth/presentation/pages/verify_Success.dart';
import 'feature/home/domain/usecases/SubmitRatingUseCase.dart';
import 'feature/home/domain/usecases/book_slot_usecase.dart';
import 'feature/home/domain/usecases/finalize_booking_usecase.dart';
import 'feature/home/domain/usecases/get_available_dates_usecase.dart';
import 'feature/home/domain/usecases/get_available_slots_usecase.dart';
import 'feature/home/domain/usecases/get_my_appointments.dart';
import 'feature/home/presentation/bloc/booking_bloc.dart';
import 'feature/home/presentation/pages/home_page.dart';
import 'feature/home/presentation/pages/booking.dart';
import 'feature/home/presentation/pages/my_appointments.dart';
import 'injection_container.dart';
import 'feature/home/presentation/bloc/home_bloc.dart';
import 'feature/home/domain/usecases/get_all_institutions.dart';
import 'feature/home/domain/usecases/get_all_physicians.dart';
import 'feature/home/domain/usecases/get_recommended_institutions.dart';
import 'feature/home/domain/usecases/get_recommended_physicians.dart';


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
            resendVerificationEmailUseCase: sl<ResendVerificationEmailUseCase>(),
            completePatientProfileUseCase: sl<CompletePatientProfileUseCase>(),
            sendResetPasswordEmailUseCase: sl<SendResetPasswordEmailUseCase>(),
            verifyResetCodeUseCase: sl<VerifyResetCodeUseCase>(),
            resetPasswordUseCase: sl<ResetPasswordUseCase>(),
          ),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            getRecommendedInstitutions: sl<GetRecommendedInstitutions>(),
            getRecommendedPhysicians: sl<GetRecommendedPhysicians>(),
            getAllInstitutions: sl<GetAllInstitutions>(),
            getAllPhysicians: sl<GetAllPhysicians>(),
            getMyAppointments: sl<GetMyAppointments>(),
            // authService: sl<AuthService>(),
          ),
        ),
        BlocProvider<BookingBloc>(
          create: (context) => BookingBloc(
            getAvailableDatesUseCase: sl<GetAvailableDatesUseCase>(),
            getAvailableSlotsUseCase: sl<GetAvailableSlotsUseCase>(),
            bookSlotUseCase: sl<BookSlotUseCase>(),
            finalizeBookingUseCase: sl<FinalizeBookingUseCase>(), submitRatingUseCase: sl<SubmitRatingUseCase>(),
            

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
          '/profile': (context) => ProfileDetailsPage(),
          '/complete_profile': (context) => CompleteProfilePage(),
          '/home': (context) => HomePage(),
          '/my_appointments': (context) => const MyAppointmentsPage(),
          // '/booking': (context) => BookingPage(),
        },
      ),
    );
  }
}