import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<String>>> getAvailableDates(int physicianId);
  Future<Either<Failure, List<int>>> getAvailableDurations(int physicianId, String date);
  Future<Either<Failure, List<Map<String, dynamic>>>> getAvailableSlots(int physicianId, String date, int duration);
  Future<Either<Failure, Map<String, dynamic>>> bookSlot(int slotId);
  Future<Either<Failure, void>> finalizeBooking(int slotId);
    Future<void> submitRating({required int physicianId, required int rating});

}