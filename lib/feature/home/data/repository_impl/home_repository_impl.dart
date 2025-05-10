import 'package:dartz/dartz.dart';
import '../../domain/entities/institution_entity.dart';
import '../../domain/entities/physician_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasource/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, List<InstitutionEntity>>> getRecommendedInstitutions(String token) async {
    try {
      final institutionModels = await remoteDataSource.getRecommendedInstitutions(token);
      final institutionEntities = institutionModels.map((model) => model.toEntity()).toList();
      return Right(institutionEntities);
    } catch (e) {
      return Left(Exception('Failed to fetch recommended institutions: $e'));
    }
  }

  @override
  Future<Either<Exception, List<PhysicianEntity>>> getRecommendedPhysicians(String token) async {
    try {
      final physicianModels = await remoteDataSource.getRecommendedPhysicians(token);
      final physicianEntities = physicianModels.map((model) => model.toEntity()).toList();
      return Right(physicianEntities);
    } catch (e) {
      return Left(Exception('Failed to fetch recommended physicians: $e'));
    }
  }

  @override
  Future<Either<Exception, List<InstitutionEntity>>> getAllInstitutions(String token) async {
    try {
      final institutionModels = await remoteDataSource.getRecommendedInstitutions(token);
      final institutionEntities = institutionModels.map((model) => model.toEntity()).toList();
      return Right(institutionEntities);
    } catch (e) {
      return Left(Exception('Failed to fetch all institutions: $e'));
    }
  }

  @override
  Future<Either<Exception, List<PhysicianEntity>>> getAllPhysicians(String token) async {
    try {
      final physicianModels = await remoteDataSource.getRecommendedPhysicians(token);
      final physicianEntities = physicianModels.map((model) => model.toEntity()).toList();
      return Right(physicianEntities);
    } catch (e) {
      return Left(Exception('Failed to fetch all physicians: $e'));
    }
  }
}