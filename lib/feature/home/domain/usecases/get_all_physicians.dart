import 'package:dartz/dartz.dart';

import '../entities/physician_entity.dart';
import '../repositories/home_repository.dart';

class GetAllPhysicians {
  final HomeRepository repository;

  GetAllPhysicians(this.repository);

  Future<Either<Exception, List<PhysicianEntity>>> call(String token) {
    return repository.getAllPhysicians(token);
  }
}