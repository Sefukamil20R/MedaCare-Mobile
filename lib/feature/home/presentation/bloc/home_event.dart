import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class GetRecommendedInstitutionsEvent extends HomeEvent {}

class GetRecommendedPhysiciansEvent extends HomeEvent {}

class GetAllInstitutionsEvent extends HomeEvent {}

class GetAllPhysiciansEvent extends HomeEvent {}
