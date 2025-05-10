import 'package:dartz/dartz.dart';

import '../entities/institution_entity.dart';
import '../repositories/home_repository.dart';

class GetAllInstitutions {
  final HomeRepository repository;

  GetAllInstitutions(this.repository);

  Future<Either<Exception, List<InstitutionEntity>>> call(String token) {
    return repository.getAllInstitutions(token);
  }
}