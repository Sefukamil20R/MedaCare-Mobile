import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/booking_repository.dart';

class BookSlotUseCase {
  final BookingRepository repository;

  BookSlotUseCase({required this.repository});

  Future<Either<Failure, Map<String, dynamic>>> call(int slotId) {
    return repository.bookSlot(slotId);
  }
}