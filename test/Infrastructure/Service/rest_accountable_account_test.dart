import 'package:crypto_app/Domain/Model/accountable_account.dart';
import 'package:crypto_app/Infrastructure/Service/rest_accountable_account.dart';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock Dio Client
class MockDio extends Mock implements Dio {}

void main() {
  group('RestAccountableAccount', () {
    late Dio dio;
    late RestAccountableAccount restAccountableAccount;

    setUp(() {
      dio = MockDio();
      restAccountableAccount = RestAccountableAccount(dio);
    });

    test('getAccountableAccount should return a list of AccountableAccount', () async {
      // Arrange: Simulate a successful response
      final response = Response(
        requestOptions: RequestOptions(path: 'acountable_account'),
        data: [
          {'accountableAccountId': '123', 'appUserId': 'user1'},
          {'accountableAccountId': '124', 'appUserId': 'user2'}
        ],
      );

      // Mock the Dio client's GET request to return the above response
      when(dio.get('acountable_account')).thenAnswer((_) async => response);

      // Act: Call the method to get the accountable accounts
      final result = await restAccountableAccount.getAccountableAccount();

      // Assert: Verify the result is as expected
      expect(result, isA<List<AccountableAccount>>());
      expect(result.length, 2);
    });

    test('getAccountableAccount should throw an exception on error', () async {
      // Arrange: Simulate an error response
      final errorResponse = DioError(
        requestOptions: RequestOptions(path: 'acountable_account'),
        error: 'Request failed',
      );

      // Mock the Dio client's GET request to throw an error
      when(dio.get('acountable_account')).thenThrow(errorResponse);

      // Act & Assert: Verify that the method throws an exception
      expect(
        () async => await restAccountableAccount.getAccountableAccount(),
        throwsA(isA<DioError>()),
      );
    });
  });
}
