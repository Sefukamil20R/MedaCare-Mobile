class PhysicianEntity {
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

  PhysicianEntity({
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
}