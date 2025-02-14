import 'package:app/Domain/Factory/factory_authentication.dart';

import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Authentication', () {
    test('fromJson should return a valid Authentication object', () {
      final Map<String, dynamic> json = {
        'email': '12345',
        'password': 'user001',
      };

      final account =
          FactoryAuthentication.fromJson(json); // Call fromJson on the instance

      expect(account.email, '12345');
      expect(account.password, 'user001');
    });

    test('toJson should return a valid JSON map', () {
      final account = FactoryAuthentication.create(
        email: '12345',
        password: 'user001',
      );

      final json = FactoryAuthentication.toJson(account);

      expect(json, isA<Map<String, dynamic>>());
      expect(json['email'], '12345');
      expect(json['password'], 'user001');
    });
  });
}
