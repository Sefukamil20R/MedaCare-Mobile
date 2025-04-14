import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? password;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.password,
  });

  @override
  List<Object?> get props => [id, email, firstName, lastName, password];
}
