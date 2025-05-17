import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/booking_repository.dart';

class FinalizeBookingUseCase {
  final BookingRepository repository;

  FinalizeBookingUseCase({required this.repository});

  Future<Either<Failure, void>> call(int slotId) {
    return repository.finalizeBooking(slotId);
  }
}