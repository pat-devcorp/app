import 'package:app/domain/except/domain_exception.dart';

import '../../domain/model/user_login.dart';

class UserLoginFactory {
  static UserLogin create({
    required String userName,
    required String password,
  }) {
    isValid(userName, password);

    return (userName: userName, password: password);
  }

  static void isValid(String userName, String password) {
    List<String> errs = [];
    errs.addAll(isValidUserName(userName));
    errs.addAll(isValidPassword(password));

    if (errs.isNotEmpty) {
      throw DomainException(errs.join(','));
    }
  }

  static List<String> isValidUserName(String userName) {
    List<String> errors = [];
    if (userName.isEmpty) {
      errors.add("Email cannot be empty");
    } else {
      final emailRegex =
          RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
      if (!emailRegex.hasMatch(userName)) {
        errors.add("Invalid email format");
      }
    }
    return errors;
  }

  static List<String> isValidPassword(String password) {
    List<String> errors = [];
    if (password.isEmpty) {
      errors.add("Password cannot be empty");
    } else {
      if (password.length < 8) {
        errors.add("Password must be at least 8 characters long");
      }
      if (!RegExp(r'[A-Z]').hasMatch(password)) {
        errors.add("Password must contain at least one uppercase letter");
      }
      if (!RegExp(r'[a-z]').hasMatch(password)) {
        errors.add("Password must contain at least one lowercase letter");
      }
      if (!RegExp(r'[0-9]').hasMatch(password)) {
        errors.add("Password must contain at least one number");
      }
      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
        errors.add("Password must contain at least one special character");
      }
    }
    return errors;
  }

  static UserLogin fromJson(Map<String, dynamic> json) => (
        userName: json['userName'] as String,
        password: json['password'] as String,
      );

  static Map<String, dynamic> toJson(UserLogin instance) => {
        'userName': instance.userName,
        'password': instance.password,
      };
}
