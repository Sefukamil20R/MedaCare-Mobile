import '../../domain/entities/institution_entity.dart';

class InstitutionModel {
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
  final String email;
  final String primaryContactPersonName;
  final String primaryContactPersonRole;
  final String offeredServices;
  final String availableFacilities;
  final String offeredSpecializations;
  final String? companyLogo; // Nullable
  final String? businessDocumentUrl; // Nullable
  final String? medicalLicenseUrl; // Nullable

  InstitutionModel({
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
  factory InstitutionModel.fromJson(Map<String, dynamic> json) {
  try {
    print('Parsing InstitutionModel: $json'); // Log the entire JSON object

    if (json['name'] == null) {
      print('Error: "name" is null');
      throw Exception('"name" cannot be null');
    }

    if (json['type'] == null) {
      print('Error: "type" is null');
      throw Exception('"type" cannot be null');
    }

    return InstitutionModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown Name', // Provide a default value if null
      type: json['type'] ?? 'Unknown Type', // Provide a default value if null
      country: json['country'] ?? 'Unknown Country',
      regionOrState: json['regionOrState'] ?? 'Unknown Region',
      subCityOrDistrict: json['subCityOrDistrict'] ?? 'Unknown SubCity',
      street: json['street'] ?? 'Unknown Street',
      registrationLicenseNumber: json['registrationLicenseNumber'] ?? 'Unknown License',
      yearEstablished: json['yearEstablished'] ?? 0,
      aboutInstitution: json['aboutInstitution'] ?? 'No description available',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      email: json['email'] ?? 'No email provided',
      primaryContactPersonName: json['primaryContactPersonName'] ?? 'Unknown Contact',
      primaryContactPersonRole: json['primaryContactPersonRole'] ?? 'Unknown Role',
      offeredServices: json['offeredServices'] ?? 'No services listed',
      availableFacilities: json['availableFacilities'] ?? 'No facilities listed',
      offeredSpecializations: json['offeredSpecializations'] ?? 'No specializations listed',
      companyLogo: json['companyLogo'], // Nullable
      businessDocumentUrl: json['businessDocumentUrl'], // Nullable
      medicalLicenseUrl: json['medicalLicenseUrl'], // Nullable
    );
  } catch (e) {
    print('Error parsing InstitutionModel: $e');
    throw Exception('Error parsing InstitutionModel: $e');
  }
}
  // Add the toEntity function
  InstitutionEntity toEntity() {
    return InstitutionEntity(
      id: id,
      name: name,
      type: type,
      country: country,
      regionOrState: regionOrState,
      subCityOrDistrict: subCityOrDistrict,
      street: street,
      registrationLicenseNumber: registrationLicenseNumber,
      yearEstablished: yearEstablished,
      aboutInstitution: aboutInstitution,
      rating: rating,
      email: email,
      primaryContactPersonName: primaryContactPersonName,
      primaryContactPersonRole: primaryContactPersonRole,
      offeredServices: offeredServices,
      availableFacilities: availableFacilities,
      offeredSpecializations: offeredSpecializations,
      companyLogo: companyLogo, // Nullable
    );
  }
}