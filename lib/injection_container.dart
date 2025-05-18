import 'dart:math';

import 'package:get_it/get_it.dart';
import 'feature/Auth/data/datasource/auth_remote_datasource.dart';
import 'feature/Auth/data/repository_impl/auth_repository_impl.dart';
import 'feature/Auth/data/services/auth_service.dart';
import 'feature/Auth/domain/repository/auth_repository.dart';
import 'feature/Auth/domain/usecase/ResendVerificationEmailUseCase.dart';
import 'feature/Auth/domain/usecase/completeprofile.dart';
import 'feature/Auth/domain/usecase/get_user_profile_usecase.dart';
import 'feature/Auth/domain/usecase/login_user_usecase.dart';
import 'feature/Auth/domain/usecase/logout_usecase.dart';
import 'feature/Auth/domain/usecase/password_reset_usecases.dart';
import 'feature/Auth/domain/usecase/register_user_usecase.dart';
import 'feature/Auth/domain/usecase/verify_email_usecase.dart';
import 'feature/Auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'feature/home/data/datasource/booking_remote_data_source.dart';
import 'feature/home/data/datasource/home_remote_data_source.dart';
import 'feature/home/data/repository_impl/booking_repository_impl.dart';
import 'feature/home/data/repository_impl/home_repository_impl.dart';
import 'feature/home/domain/repositories/booking_repository.dart';
import 'feature/home/domain/repositories/home_repository.dart';
import 'feature/home/domain/usecases/SubmitRatingUseCase.dart';
import 'feature/home/domain/usecases/book_slot_usecase.dart';
import 'feature/home/domain/usecases/finalize_booking_usecase.dart';
import 'feature/home/domain/usecases/get_all_institutions.dart';
import 'feature/home/domain/usecases/get_all_physicians.dart';
import 'feature/home/domain/usecases/get_available_dates_usecase.dart';
import 'feature/home/domain/usecases/get_available_slots_usecase.dart';
import 'feature/home/domain/usecases/get_recommended_institutions.dart';
import 'feature/home/domain/usecases/get_recommended_physicians.dart';
import 'feature/home/presentation/bloc/booking_bloc.dart';
import 'feature/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;
Future<void> setupLocator() async {
  try {
    print('Registering dependencies...');

    // Bloc
    sl.registerFactory(() => AuthBloc(
          registerUserUseCase: sl(),
          verifyEmailUseCase: sl(),
          loginUserUseCase: sl(),
          getUserProfileUseCase: sl(),
          logoutUseCase: sl(),
          resendVerificationEmailUseCase: sl(),
          completePatientProfileUseCase: sl(),
          sendResetPasswordEmailUseCase: sl(),
          verifyResetCodeUseCase: sl(),
          resetPasswordUseCase: sl(),
        ));
      sl.registerFactory(() => BookingBloc(
        getAvailableDatesUseCase: sl(),
        getAvailableSlotsUseCase: sl(),
        bookSlotUseCase: sl(),
        finalizeBookingUseCase: sl(),
        submitRatingUseCase: sl(),
      ));
    print('AuthBloc registered.');

    sl.registerFactory(() => HomeBloc(
          getRecommendedInstitutions: sl(),
          getRecommendedPhysicians: sl(),
          getAllInstitutions: sl(),
          getAllPhysicians: sl(),
          // authService: sl(),
        ));
    print('HomeBloc registered.');

    // Use cases
    sl.registerLazySingleton(() => RegisterUserUseCase(sl()));
    sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
    sl.registerLazySingleton(() => LoginUserUseCase(sl()));
    sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
    sl.registerLazySingleton(() => LogoutUseCase(sl()));
    sl.registerLazySingleton(() => ResendVerificationEmailUseCase(sl()));
    sl.registerLazySingleton(() => CompletePatientProfileUseCase(sl()));
    sl.registerLazySingleton(() => SendResetPasswordEmailUseCase(sl()));
    sl.registerLazySingleton(() => VerifyResetCodeUseCase(sl()));
    sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
    
    sl.registerLazySingleton(() => GetRecommendedInstitutions(sl()));
    sl.registerLazySingleton(() => GetRecommendedPhysicians(sl()));
    sl.registerLazySingleton(() => GetAllInstitutions(sl()));
    sl.registerLazySingleton(() => GetAllPhysicians(sl()));
    


  sl.registerLazySingleton(() => GetAvailableDatesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAvailableSlotsUseCase(repository: sl()));
  sl.registerLazySingleton(() => BookSlotUseCase(repository: sl()));
  sl.registerLazySingleton(() => FinalizeBookingUseCase(repository: sl()));
  sl.registerLazySingleton(() => SubmitRatingUseCase(repository: sl()));
    // Repository
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
          remoteDataSource: sl(),
          sharedPreferences: sl(),
        ));
    sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(remoteDataSource: sl()));
    sl.registerLazySingleton<BookingRepository>(
      () => BookingRepositoryImpl(remoteDataSource: sl()));

    // Data sources
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()),
    );
    sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(client: sl()));
   sl.registerLazySingleton<BookingRemoteDataSource>(
      () => BookingRemoteDataSourceImpl(client: sl()));



    // Services
    sl.registerLazySingleton(() => AuthService());
    print('AuthService registered.');

    // External
    sl.registerLazySingleton(() => http.Client());
    print('http.Client registered.');
    
    final sharedPrefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPrefs);
    print('SharedPreferences registered.');

    print('All dependencies registered successfully.');
  } catch (e) {
    print('Error during dependency registration: $e');
    rethrow;
  }
}