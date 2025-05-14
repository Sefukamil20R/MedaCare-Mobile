import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/booking_repository.dart';

class GetAvailableDurationsUseCase {
  final BookingRepository repository;

  GetAvailableDurationsUseCase({required this.repository});

  Future<Either<Failure, List<int>>> call(int physicianId, String date) {
    return repository.getAvailableDurations(physicianId, date);
  }
}