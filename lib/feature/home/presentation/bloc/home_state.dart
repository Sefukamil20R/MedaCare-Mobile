import 'package:equatable/equatable.dart';

import '../../domain/entities/institution_entity.dart';
import '../../domain/entities/physician_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

// class RecommendedInstitutionsLoaded extends HomeState {
//   final List<InstitutionEntity> institutions;
//   const RecommendedInstitutionsLoaded(this.institutions);

//   @override
//   List<Object?> get props => [institutions];
// }

// class RecommendedPhysiciansLoaded extends HomeState {
//   final List<PhysicianEntity> physicians;
//   const RecommendedPhysiciansLoaded(this.physicians);

//   @override
//   List<Object?> get props => [physicians];
// }

class HomeCombinedLoaded extends HomeState {
  final List<InstitutionEntity>? recommendedInstitutions;
  final List<PhysicianEntity>? recommendedPhysicians;

  const HomeCombinedLoaded({
    this.recommendedInstitutions,
    this.recommendedPhysicians,
  });

  @override
  List<Object?> get props => [
        recommendedInstitutions ?? [],
        recommendedPhysicians ?? [],
      ];
}

class AllInstitutionsLoaded extends HomeState {
  final List<InstitutionEntity> institutions;
  const AllInstitutionsLoaded(this.institutions);

  @override
  List<Object?> get props => [institutions];
}

class AllPhysiciansLoaded extends HomeState {
  final List<PhysicianEntity> physicians;
  const AllPhysiciansLoaded(this.physicians);

  @override
  List<Object?> get props => [physicians];
}
class MyAppointmentsLoading extends HomeState {}
class MyAppointmentsLoaded extends HomeState {
  final List<Map<String, dynamic>> appointments;
  MyAppointmentsLoaded(this.appointments);
}
class MyAppointmentsError extends HomeState {
  final String message;
  MyAppointmentsError(this.message);
}