import '../model/client.dart';

class ClientImpl implements Client {
  @override
  final String name;
  @override
  final String lastFatherName;
  @override
  final String lastMotherName;
  @override
  final String birthdate;
  @override
  final int documentType;
  @override
  final String documentNumber;
  @override
  final String phoneNumber;
  @override
  final String email;

  ClientImpl({
    required this.name,
    required this.lastFatherName,
    required this.lastMotherName,
    required this.birthdate,
    required this.documentType,
    required this.documentNumber,
    required this.phoneNumber,
    required this.email,
  });

  @override
  String toString() {
    return 'Client(name: $name, lastFatherName: $lastFatherName, lastMotherName: $lastMotherName, birthdate: $birthdate, documentType: $documentType, documentNumber: $documentNumber, phoneNumber: $phoneNumber, email: $email)';
  }
}
