class InstitutionEntity {
  final int id;
  final String name;
  final String type;
  final String country;
  final String regionOrState;
  final String subCityOrDistrict;
  final String street;
  final String registrationLicenseNumber;
  final int yearEstablished;
  final String aboutInstitution;
  final double rating;
  final String email; // New field
  final String primaryContactPersonName; // New field
  final String primaryContactPersonRole; // New field
  final String offeredServices; // New field
  final String availableFacilities; // New field
  final String offeredSpecializations; // New field
  final String? companyLogo; // New field
   final String? businessDocumentUrl; // Nullable
  final String? medicalLicenseUrl; // Nullable

  
  InstitutionEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.country,
    required this.regionOrState,
    required this.subCityOrDistrict,
    required this.street,
    required this.registrationLicenseNumber,
    required this.yearEstablished,
    required this.aboutInstitution,
    required this.rating,
    required this.email,
    required this.primaryContactPersonName,
    required this.primaryContactPersonRole,
    required this.offeredServices,
    required this.availableFacilities,
    required this.offeredSpecializations,
    this.companyLogo,
    this.businessDocumentUrl,
    this.medicalLicenseUrl,
  });
}