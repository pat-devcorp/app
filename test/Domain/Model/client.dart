import 'package:app/domain/abstract_factory/client_impl.dart';
import 'package:app/domain/except/domain_exception.dart';
import 'package:app/domain/factory/client_factory.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClientFactory', () {
    test('should create a valid Client object', () {
      final client = ClientFactory.create(
        name: 'John',
        lastFatherName: 'Doe',
        lastMotherName: 'Smith',
        birthdate: '1990-01-01',
        documentType: 1,
        documentNumber: '1234567890',
        phoneNumber: '+15551234567',
        email: 'john.doe@example.com',
      );

      expect(client, isA<ClientImpl>());
      expect(client.name, 'John');
      expect(client.lastFatherName, 'Doe');
      expect(client.lastMotherName, 'Smith');
      expect(client.birthdate, '1990-01-01');
      expect(client.documentType, 1);
      expect(client.documentNumber, '1234567890');
      expect(client.phoneNumber, '+15551234567');
      expect(client.email, 'john.doe@example.com');
    });

    test('should throw a DomainException for invalid name (empty)', () {
      expect(
        () => ClientFactory.create(
          name: '',
          lastFatherName: 'Doe',
          lastMotherName: 'Smith',
          birthdate: '1990-01-01',
          documentType: 1,
          documentNumber: '1234567890',
          phoneNumber: '+15551234567',
          email: 'john.doe@example.com',
        ),
        throwsA(isA<DomainException>()),
      );
    });

    test('should throw a DomainException for invalid name (too long)', () {
      expect(
        () => ClientFactory.create(
          name: 'a' * 51,
          lastFatherName: 'Doe',
          lastMotherName: 'Smith',
          birthdate: '1990-01-01',
          documentType: 1,
          documentNumber: '1234567890',
          phoneNumber: '+15551234567',
          email: 'john.doe@example.com',
        ),
        throwsA(isA<DomainException>()),
      );
    });

    test(
        'should throw a DomainException for invalid lastFatherName (contains number)',
        () {
      expect(
        () => ClientFactory.create(
          name: 'John',
          lastFatherName: 'Doe1',
          lastMotherName: 'Smith',
          birthdate: '1990-01-01',
          documentType: 1,
          documentNumber: '1234567890',
          phoneNumber: '+15551234567',
          email: 'john.doe@example.com',
        ),
        throwsA(isA<DomainException>()),
      );
    });

    test('should throw a DomainException for invalid birthdate', () {
      expect(
        () => ClientFactory.create(
          name: 'John',
          lastFatherName: 'Doe',
          lastMotherName: 'Smith',
          birthdate: 'invalid-date',
          documentType: 1,
          documentNumber: '1234567890',
          phoneNumber: '+15551234567',
          email: 'john.doe@example.com',
        ),
        throwsA(isA<DomainException>()),
      );
    });

    test('should throw a DomainException for invalid phoneNumber', () {
      expect(
        () => ClientFactory.create(
          name: 'John',
          lastFatherName: 'Doe',
          lastMotherName: 'Smith',
          birthdate: '1990-01-01',
          documentType: 1,
          documentNumber: '1234567890',
          phoneNumber: 'invalid-phone',
          email: 'john.doe@example.com',
        ),
        throwsA(isA<DomainException>()),
      );
    });

    test('should throw a DomainException for invalid email (empty)', () {
      expect(
        () => ClientFactory.create(
          name: 'John',
          lastFatherName: 'Doe',
          lastMotherName: 'Smith',
          birthdate: '1990-01-01',
          documentType: 1,
          documentNumber: '1234567890',
          phoneNumber: '+15551234567',
          email: '',
        ),
        throwsA(isA<DomainException>()),
      );
    });

    test('should throw a DomainException for invalid email (format)', () {
      expect(
        () => ClientFactory.create(
          name: 'John',
          lastFatherName: 'Doe',
          lastMotherName: 'Smith',
          birthdate: '1990-01-01',
          documentType: 1,
          documentNumber: '1234567890',
          phoneNumber: '+15551234567',
          email: 'invalid-email',
        ),
        throwsA(isA<DomainException>()),
      );
    });
  });
}
