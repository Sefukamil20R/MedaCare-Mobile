import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/institution_entity.dart';
import '../../domain/entities/physician_entity.dart';
import '../../domain/usecases/get_recommended_institutions.dart';
import '../../domain/usecases/get_recommended_physicians.dart';
import '../../domain/usecases/get_all_institutions.dart';
import '../../domain/usecases/get_all_physicians.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRecommendedInstitutions getRecommendedInstitutions;
  final GetRecommendedPhysicians getRecommendedPhysicians;
  final GetAllInstitutions getAllInstitutions;
  final GetAllPhysicians getAllPhysicians;

  // Caching recommended data so both can be emitted together
  List<InstitutionEntity>? _cachedRecommendedInstitutions;
  List<PhysicianEntity>? _cachedRecommendedPhysicians;

  HomeBloc({
    required this.getRecommendedInstitutions,
    required this.getRecommendedPhysicians,
    required this.getAllInstitutions,
    required this.getAllPhysicians,
  }) : super(HomeInitial()) {
    // Handle GetRecommendedInstitutionsEvent
    on<GetRecommendedInstitutionsEvent>((event, emit) async {
      emit(HomeLoading());
      final token = await _getToken();
      if (token == null || token.isEmpty) {
        print('Error: Token is null or empty in HomeBloc');
        emit(HomeError('User is not logged in.'));
        return;
      }

      print('Token used for fetching recommended institutions: $token');
      final result = await getRecommendedInstitutions(token);
      result.fold(
        (failure) => emit(HomeError(failure.toString())),
        (institutions) {
          _cachedRecommendedInstitutions = institutions;
          emit(HomeCombinedLoaded(
            recommendedInstitutions: _cachedRecommendedInstitutions,
            recommendedPhysicians: _cachedRecommendedPhysicians,
          ));
        },
      );
    });

    // Handle GetRecommendedPhysiciansEvent
    on<GetRecommendedPhysiciansEvent>((event, emit) async {
      emit(HomeLoading());
      final token = await _getToken();
      if (token == null || token.isEmpty) {
        print('Error: Token is null or empty in HomeBloc');
        emit(HomeError('User is not logged in.'));
        return;
      }

      print('Token used for fetching recommended physicians: $token');
      final result = await getRecommendedPhysicians(token);
      result.fold(
        (failure) {
          print('Error fetching recommended physicians: $failure');
          emit(HomeError(failure.toString()));
        },
        (physicians) {
          _cachedRecommendedPhysicians = physicians;
          emit(HomeCombinedLoaded(
            recommendedInstitutions: _cachedRecommendedInstitutions,
            recommendedPhysicians: _cachedRecommendedPhysicians,
          ));
        },
      );
    });

    // Handle GetAllInstitutionsEvent
    on<GetAllInstitutionsEvent>((event, emit) async {
      emit(HomeLoading());
      final token = await _getToken();
      if (token == null || token.isEmpty) {
        print('Error: Token is null or empty in HomeBloc');
        emit(HomeError('User is not logged in.'));
        return;
      }

      print('Token used for fetching all institutions: $token');
      final result = await getAllInstitutions(token);
      result.fold(
        (failure) => emit(HomeError(failure.toString())),
        (institutions) => emit(AllInstitutionsLoaded(institutions)),
      );
    });

    // Handle GetAllPhysiciansEvent
    on<GetAllPhysiciansEvent>((event, emit) async {
      emit(HomeLoading());
      final token = await _getToken();
      if (token == null || token.isEmpty) {
        print('Error: Token is null or empty in HomeBloc');
        emit(HomeError('User is not logged in.'));
        return;
      }

      print('Token used for fetching all physicians: $token');
      final result = await getAllPhysicians(token);
      result.fold(
        (failure) => emit(HomeError(failure.toString())),
        (physicians) => emit(AllPhysiciansLoaded(physicians)),
      );
    });
  }

  // Helper method to retrieve the token from SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    print('Token retrieved in HomeBloc: $token');
    return token;
  }
}
