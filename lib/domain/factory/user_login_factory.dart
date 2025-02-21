import 'package:app/domain/except/domain_exception.dart';

import '../../domain/model/user_login.dart';
import '../validator/user_login_validator.dart';

class UserLoginFactory {
  static UserLogin create({
    required String userName,
    required String password,
  }) {

    UserLogin instance = (userName: userName, password: password);
    isValid(instance);
    return instance;
  }

  static void isValid(UserLogin instance) {
    List<String> errs = [];
    errs.addAll(UserLoginValidator.isValidUserName(instance.userName));
    errs.addAll(UserLoginValidator.isValidPassword(instance.password));

    if (errs.isNotEmpty) {
      throw DomainException(errs.join(','));
    }
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
