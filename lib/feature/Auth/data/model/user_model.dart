
import 'package:medacare/feature/Auth/domain/entitiy/user_entity.dart';

class UserModel extends User {

  UserModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    String? password,
    bool? firstLogin,

  }) : super(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          password: password,
          firstLogin: firstLogin, // <-- Add this
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      firstLogin: json['firstLogin'], // <-- Add this

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "firstLogin": firstLogin,
    };
  }
  factory UserModel.fromEntity(User user) {
    return UserModel(
      // Map User entity properties to UserModel properties
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      password: user.password, 
      firstLogin: user.firstLogin, // <-- Add this
      // Add other fields as necessary
    );
  }
}
