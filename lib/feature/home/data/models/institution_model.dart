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
  final String? companyLogo;

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
  });

  factory InstitutionModel.fromJson(Map<String, dynamic> json) {
    return InstitutionModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      country: json['country'],
      regionOrState: json['regionOrState'],
      subCityOrDistrict: json['subCityOrDistrict'],
      street: json['street'],
      registrationLicenseNumber: json['registrationLicenseNumber'],
      yearEstablished: json['yearEstablished'],
      aboutInstitution: json['aboutInstitution'],
      rating: json['rating'].toDouble(),
      email: json['email'],
      primaryContactPersonName: json['primaryContactPersonName'],
      primaryContactPersonRole: json['primaryContactPersonRole'],
      offeredServices: json['offeredServices'],
      availableFacilities: json['availableFacilities'],
      offeredSpecializations: json['offeredSpecializations'],
      companyLogo: json['companyLogo'] ?? 'assets/images/inst.png',
    );
  }

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
      companyLogo: companyLogo ?? 'assets/images/inst.png',
    );
  }
}