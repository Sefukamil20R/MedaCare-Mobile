import '../../domain/entities/physician_entity.dart';

class PhysicianModel {
  final int id;
  final String specialization;
  final String licenseNumber;
  final String availabilitySchedule;
  final String education;
  final String gender;
  final String dateOfBirth;
  final int age;
  final int experience;
  final String languagesSpoken;
  final double rating;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? organizationAffiliated;
  final String accountRequestStatus;
  final bool documentInvalid;
  final bool licenseNotValid;
  final bool identityUnverified;
  final bool professionallyQualified;
  final String rejectionReasonNote;
  final String? profilePhotoUrl;

  PhysicianModel({
    required this.id,
    required this.specialization,
    required this.licenseNumber,
    required this.availabilitySchedule,
    required this.education,
    required this.gender,
    required this.dateOfBirth,
    required this.age,
    required this.experience,
    required this.languagesSpoken,
    required this.rating,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.organizationAffiliated,
    required this.accountRequestStatus,
    required this.documentInvalid,
    required this.licenseNotValid,
    required this.identityUnverified,
    required this.professionallyQualified,
    required this.rejectionReasonNote,
    this.profilePhotoUrl,
  });

 factory PhysicianModel.fromJson(Map<String, dynamic> json) {
  print('Parsing Physician JSON: $json'); // Log the JSON being parsed
  try {
    return PhysicianModel(
      id: json['id'],
      specialization: json['specialization'] ?? 'Unknown',
      licenseNumber: json['licenseNumber'] ?? '',
      availabilitySchedule: json['availabilitySchedule'] ?? 'Not Available',
      education: json['education'] ?? 'Not Specified',
      gender: json['gender'] ?? 'Not Specified',
      dateOfBirth: json['dateOfBirth'] ?? 'Unknown',
      age: json['age'] ?? 0,
      experience: json['experience'] ?? 0,
      languagesSpoken: json['languagesSpoken'] ?? 'Not Specified',
      rating: json['rating']?.toDouble() ?? 0.0,
      email: json['email'] ?? 'Not Provided',
      firstName: json['firstName'] ?? 'Unknown',
      lastName: json['lastName'] ?? 'Unknown',
      phoneNumber: json['phoneNumber'],
      organizationAffiliated: json['organizationAffiliated'],
      accountRequestStatus: json['accountRequestStatus'] ?? 'Unknown',
      documentInvalid: json['documentInvalid'] ?? false,
      licenseNotValid: json['licenseNotValid'] ?? false,
      identityUnverified: json['identityUnverified'] ?? false,
      professionallyQualified: json['professionallyQualified'] ?? false,
      rejectionReasonNote: json['rejectionReasonNote'] ?? '',
      profilePhotoUrl: json['profilePhotoUrl'] ?? 'assets/images/Doctor.png',
    );
  } catch (e) {
    print('Error parsing Physician JSON: $e');
    throw e;
  }
}
  PhysicianEntity toEntity() {
    return PhysicianEntity(
      id: id,
      specialization: specialization,
      licenseNumber: licenseNumber,
      availabilitySchedule: availabilitySchedule,
      education: education,
      gender: gender,
      dateOfBirth: dateOfBirth,
      age: age,
      experience: experience,
      languagesSpoken: languagesSpoken,
      rating: rating,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      organizationAffiliated: organizationAffiliated,
      accountRequestStatus: accountRequestStatus,
      documentInvalid: documentInvalid,
      licenseNotValid: licenseNotValid,
      identityUnverified: identityUnverified,
      professionallyQualified: professionallyQualified,
      rejectionReasonNote: rejectionReasonNote,
      profilePhotoUrl: profilePhotoUrl,
    );
  }
}