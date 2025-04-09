// import 'package:flutter_bloc/flutter_bloc.dart';

// // Bloc
// import 'package:medacare/feature/Auth/presentation/bloc/auth_event.dart';
// import 'package:medacare/feature/Auth/presentation/bloc/auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc() : super(AuthInitial()) {
//     on<LoginRequested>((event, emit) async {
//       emit(AuthLoading());
//       await Future.delayed(Duration(seconds: 1)); // Simulate API call
//       if (event.username == "demo" && event.password == "password") {
//         emit(AuthAuthenticated());
//       } else {
//         emit(AuthError("Invalid credentials"));
//       }
//     });

//     on<LogoutRequested>((event, emit) {
//       emit(AuthInitial());
//     });
//   }
// }

// // Remove this placeholder Bloc class and import the correct one from flutter_bloc
