import 'package:dartz/dartz.dart';
import '../entities/physician_entity.dart';
import '../repositories/home_repository.dart';

class GetRecommendedPhysicians {
  final HomeRepository repository;

  GetRecommendedPhysicians(this.repository);

  Future<Either<Exception, List<PhysicianEntity>>> call(String token) {
    return repository.getRecommendedPhysicians(token);
  }
}