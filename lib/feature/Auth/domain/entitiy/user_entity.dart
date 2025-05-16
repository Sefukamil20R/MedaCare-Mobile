import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? password;
  final bool? firstLogin; // <-- Add this


  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.password,
    this.firstLogin, // <-- Add this
  });

  @override
  List<Object?> get props => [id, email, firstName, lastName, password];
}
