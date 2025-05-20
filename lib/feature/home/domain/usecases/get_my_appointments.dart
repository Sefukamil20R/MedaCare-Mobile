
import '../repositories/home_repository.dart';

class GetMyAppointments {
  final HomeRepository repository;
  GetMyAppointments(this.repository);

  Future<List<Map<String, dynamic>>> call() {
    return repository.getMyAppointments();
  }
}