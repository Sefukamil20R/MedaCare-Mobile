import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/booking_repository.dart';

class GetAvailableDatesUseCase {
  final BookingRepository repository;

  GetAvailableDatesUseCase({required this.repository});

  Future<Either<Failure, List<String>>> call(int physicianId) {
    return repository.getAvailableDates(physicianId);
  }
}