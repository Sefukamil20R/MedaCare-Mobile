import '../repositories/booking_repository.dart';

class SubmitRatingUseCase {
  final BookingRepository repository;
  SubmitRatingUseCase( {required this.repository});

Future<void> call({required int physicianId, required int rating}) {
    return repository.submitRating(physicianId: physicianId, rating: rating);
  }
}