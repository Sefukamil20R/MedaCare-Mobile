import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasource/booking_remote_data_source.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<String>>> getAvailableDates(int physicianId) async {
    try {
      final dates = await remoteDataSource.getAvailableDates(physicianId);
      return Right(dates);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getAvailableDurations(int physicianId, String date) async {
    try {
      final durations = await remoteDataSource.getAvailableDurations(physicianId, date);
      return Right(durations);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getAvailableSlots(int physicianId, String date, int duration) async {
    try {
      final slots = await remoteDataSource.getAvailableSlots(physicianId, date, duration);
      return Right(slots);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> bookSlot(int slotId) async {
    try {
      final bookingData = await remoteDataSource.bookSlot(slotId);
      return Right(bookingData);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> finalizeBooking(int slotId) async {
    try {
      await remoteDataSource.finalizeBooking(slotId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
 @override
  Future<void> submitRating({required int physicianId, required int rating}) {
    return remoteDataSource.submitRating(physicianId: physicianId, rating: rating);
  }
}