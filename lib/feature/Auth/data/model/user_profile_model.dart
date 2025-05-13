class UserProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final bool firstLogin;
  final bool verified;
  final EntityModel entity;

  UserProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.firstLogin,
    required this.verified,
    required this.entity,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      firstLogin: json['firstLogin'],
      verified: json['verified'],
      entity: EntityModel.fromJson(json['entity']),
    );
  }
}

class EntityModel {
  final int id;
  final String? dateOfBirth;
  final int? age;
  final String? contactNumber;
  final String? emergencyContactName;
  final String? emergencyContactNumber;
  final String? medicalHistory;
  final String? bloodType;
  final String? preferredLanguage;
  final String? maritalStatus;
  final double? heightInMeters;
  final double? weightInKg;
  final String? gender;

  EntityModel({
    required this.id,
    this.dateOfBirth,
    this.age,
    this.contactNumber,
    this.emergencyContactName,
    this.emergencyContactNumber,
    this.medicalHistory,
    this.bloodType,
    this.preferredLanguage,
    this.maritalStatus,
    this.heightInMeters,
    this.weightInKg,
    this.gender,
  });

  factory EntityModel.fromJson(Map<String, dynamic> json) {
    return EntityModel(
      id: json['id'],
      dateOfBirth: json['dateOfBirth'],
      age: json['age'],
      contactNumber: json['contactNumber'],
      emergencyContactName: json['emergencyContactName'],
      emergencyContactNumber: json['emergencyContactNumber'],
      medicalHistory: json['medicalHistory'],
      bloodType: json['bloodType'],
      preferredLanguage: json['preferredLanguage'],
      maritalStatus: json['maritalStatus'],
      heightInMeters: json['heightInMeters']?.toDouble(),
      weightInKg: json['weightInKg']?.toDouble(),
      gender: json['gender'],
    );
  }
}