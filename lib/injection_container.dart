import 'package:get_it/get_it.dart';
import 'feature/Auth/data/datasource/auth_remote_datasource.dart';
import 'feature/Auth/data/repository_impl/auth_repository_impl.dart';
import 'feature/Auth/domain/repository/auth_repository.dart';
import 'feature/Auth/domain/usecase/ResendVerificationEmailUseCase.dart';
import 'feature/Auth/domain/usecase/completeprofile.dart';
import 'feature/Auth/domain/usecase/get_user_profile_usecase.dart';
import 'feature/Auth/domain/usecase/login_user_usecase.dart';
import 'feature/Auth/domain/usecase/logout_usecase.dart';
import 'feature/Auth/domain/usecase/register_user_usecase.dart';
import 'feature/Auth/domain/usecase/verify_email_usecase.dart';
import 'feature/Auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Bloc
  sl.registerFactory(() => AuthBloc(
    registerUserUseCase: sl(),
    verifyEmailUseCase: sl(),
    loginUserUseCase: sl(),
    getUserProfileUseCase: sl(),
    logoutUseCase: sl(), resendVerificationEmailUseCase: sl(), completePatientProfileUseCase: sl(), // Add this line
  ));

  // Use cases
  sl.registerLazySingleton(() => RegisterUserUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton(() => LoginUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ResendVerificationEmailUseCase(sl()));
  sl.registerLazySingleton(() => CompletePatientProfileUseCase(sl())); // Add this line
  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: sl(),
    sharedPreferences: sl(),
  ));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl(),),
  );

  // External
  sl.registerLazySingleton(() => http.Client());

  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);
}
