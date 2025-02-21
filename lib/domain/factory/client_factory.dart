import '../abstract_factory/client_impl.dart';
import '../except/domain_exception.dart';
import '../model/i_client.dart';
import '../validator/client_validator.dart';

class ClientFactory {
  static IClient create({
    required String name,
    required String lastFatherName,
    required String lastMotherName,
    required String birthdate,
    required int documentType,
    required String documentNumber,
    required String phoneNumber,
    required String email,
  }) {
    List<String?> errors = [];
    errors.addAll(ClientValidator.isValidEmail(email));

    List<String> filteredErrors = errors.whereType<String>().toList();
    if (filteredErrors.isNotEmpty) {
      throw DomainException(errors.join(','));
    }
    return ClientImpl(
      name: name,
      lastFatherName: lastFatherName,
      lastMotherName: lastMotherName,
      birthdate: birthdate,
      documentType: documentType,
      documentNumber: documentNumber,
      phoneNumber: phoneNumber,
      email: email,
    );
  }
}
