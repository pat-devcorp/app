import 'string_handler.dart';

class ClientValidator{
  static List<String> isValidEmail(String email) {
    return StringHandler.isValidEmail("email", email);
  }
}