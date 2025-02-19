import 'package:app/domain/factory/user_login_factory.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Authentication', () {
    test('fromJson should return a valid Authentication object', () {
      final Map<String, dynamic> json = {
        'userName': '12345',
        'password': 'user001',
      };

      final account = UserLoginFactory.fromJson(json);

      expect(account.userName, '12345');
      expect(account.password, 'user001');
    });

    test('toJson should return a valid JSON map', () {
      final account = UserLoginFactory.create(
        userName: '12345',
        password: 'user001',
      );

      final json = UserLoginFactory.toJson(account);

      expect(json, isA<Map<String, dynamic>>());
      expect(json['userName'], '12345');
      expect(json['password'], 'user001');
    });
  });
}
