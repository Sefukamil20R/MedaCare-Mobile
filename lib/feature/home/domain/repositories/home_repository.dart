import 'package:dartz/dartz.dart';
import '../entities/institution_entity.dart';
import '../entities/physician_entity.dart';

abstract class HomeRepository {
  Future<Either<Exception, List<InstitutionEntity>>> getRecommendedInstitutions(String token);
  Future<Either<Exception, List<PhysicianEntity>>> getRecommendedPhysicians(String token);
  Future<Either<Exception, List<InstitutionEntity>>> getAllInstitutions(String token);
  Future<Either<Exception, List<PhysicianEntity>>> getAllPhysicians(String token);
}