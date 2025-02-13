import 'package:app/Domain/Except/invalid_argument.dart';
import 'package:app/Domain/Model/authentication.dart';

class FactoryAuthentication {
  static Authentication create({
    required String email,
    required String password,
  }) {
    if (email.isEmpty || password.isEmpty) {
      throw InvalidArgument('email and password cannot be empty');
    }

    return Authentication(
      email: email,
      password: password,
    );
  }

  static Authentication fromJson(Map<String, dynamic> json) => Authentication(
        email: json['email'] as String,
        password: json['password'] as String,
      );

  static Map<String, dynamic> toJson(Authentication instance) =>
      <String, dynamic>{
        'email': instance.email,
        'password': instance.password,
      };
}
