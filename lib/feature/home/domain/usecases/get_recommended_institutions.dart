import 'package:dartz/dartz.dart';

import '../entities/institution_entity.dart';
import '../repositories/home_repository.dart';

class GetRecommendedInstitutions {
  final HomeRepository repository;

  GetRecommendedInstitutions(this.repository);

  Future<Either<Exception, List<InstitutionEntity>>> call(String token) {
    return repository.getRecommendedInstitutions(token);
  }
}