import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/booking_repository.dart';

class GetAvailableSlotsUseCase {
  final BookingRepository repository;

  GetAvailableSlotsUseCase({required this.repository});

  Future<Either<Failure, List<Map<String, dynamic>>>> call(
      int physicianId, String date, int duration,  ) {
    return repository.getAvailableSlots(physicianId, date, duration);
  }
}