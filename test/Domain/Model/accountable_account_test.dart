import 'package:flutter_test/flutter_test.dart';

import 'package:crypto_app/Domain/Model/accountable_account.dart';

void main() {
  group('AccountableAccount', () {
    test('fromJson should return a valid AccountableAccount object', () {
      final Map<String, dynamic> json = {
        'accountableAccountId': '12345',
        'appUserId': 'user001',
      };

      final account = AccountableAccount.fromJson(json);

      expect(account.accountableAccountId, '12345');
      expect(account.appUserId, 'user001');
    });

    test('toJson should return a valid JSON map', () {
      final account = AccountableAccount(
        accountableAccountId: '12345',
        appUserId: 'user001',
      );

      final json = account.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['accountableAccountId'], '12345');
      expect(json['appUserId'], 'user001');
    });
  });
}
