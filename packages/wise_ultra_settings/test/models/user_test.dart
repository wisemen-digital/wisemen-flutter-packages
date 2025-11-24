import 'package:flutter_test/flutter_test.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';

void main() {
  group('User', () {
    group('constructor', () {
      test('creates user with all required fields', () {
        final user = User(
          uuid: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          profilePictureUrl: 'https://example.com/avatar.jpg',
        );

        expect(user.uuid, equals('123'));
        expect(user.firstName, equals('John'));
        expect(user.lastName, equals('Doe'));
        expect(user.email, equals('john@example.com'));
        expect(user.profilePictureUrl, equals('https://example.com/avatar.jpg'));
        expect(user.phone, isNull);
        expect(user.mobilePhone, isNull);
        expect(user.birthDate, isNull);
      });

      test('creates user with all fields', () {
        final birthDate = DateTime(1990, 1, 1);
        final user = User(
          uuid: '456',
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane@example.com',
          profilePictureUrl: null,
          phone: '+1234567890',
          mobilePhone: '+0987654321',
          birthDate: birthDate,
        );

        expect(user.uuid, equals('456'));
        expect(user.firstName, equals('Jane'));
        expect(user.lastName, equals('Smith'));
        expect(user.email, equals('jane@example.com'));
        expect(user.profilePictureUrl, isNull);
        expect(user.phone, equals('+1234567890'));
        expect(user.mobilePhone, equals('+0987654321'));
        expect(user.birthDate, equals(birthDate));
      });

      test('creates user with null optional fields', () {
        final user = User(
          uuid: '789',
          firstName: 'Bob',
          lastName: 'Johnson',
          email: 'bob@example.com',
          profilePictureUrl: null,
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        expect(user.profilePictureUrl, isNull);
        expect(user.phone, isNull);
        expect(user.mobilePhone, isNull);
        expect(user.birthDate, isNull);
      });
    });

    group('fullName', () {
      test('returns combined first and last name', () {
        final user = User(
          uuid: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          profilePictureUrl: null,
        );

        expect(user.fullName, equals('John Doe'));
      });

      test('handles single character names', () {
        final user = User(
          uuid: '123',
          firstName: 'J',
          lastName: 'D',
          email: 'j@example.com',
          profilePictureUrl: null,
        );

        expect(user.fullName, equals('J D'));
      });

      test('handles names with spaces', () {
        final user = User(
          uuid: '123',
          firstName: 'Mary Jane',
          lastName: 'Watson Parker',
          email: 'mary@example.com',
          profilePictureUrl: null,
        );

        expect(user.fullName, equals('Mary Jane Watson Parker'));
      });

      test('handles empty names', () {
        final user = User(
          uuid: '123',
          firstName: '',
          lastName: '',
          email: 'empty@example.com',
          profilePictureUrl: null,
        );

        expect(user.fullName, equals(' '));
      });
    });

    group('properties', () {
      test('uuid is accessible', () {
        final user = User(
          uuid: 'test-uuid',
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          profilePictureUrl: null,
        );

        expect(user.uuid, isA<String>());
        expect(user.uuid, equals('test-uuid'));
      });

      test('email is accessible', () {
        final user = User(
          uuid: '123',
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          profilePictureUrl: null,
        );

        expect(user.email, isA<String>());
        expect(user.email, equals('test@example.com'));
      });

      test('birthDate is accessible when set', () {
        final birthDate = DateTime(1995, 6, 15);
        final user = User(
          uuid: '123',
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          profilePictureUrl: null,
          birthDate: birthDate,
        );

        expect(user.birthDate, isA<DateTime>());
        expect(user.birthDate, equals(birthDate));
      });

      test('phone numbers are accessible when set', () {
        final user = User(
          uuid: '123',
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          profilePictureUrl: null,
          phone: '+1234567890',
          mobilePhone: '+0987654321',
        );

        expect(user.phone, equals('+1234567890'));
        expect(user.mobilePhone, equals('+0987654321'));
      });
    });

    group('edge cases', () {
      test('handles very long names', () {
        final longName = 'A' * 100;
        final user = User(
          uuid: '123',
          firstName: longName,
          lastName: longName,
          email: 'long@example.com',
          profilePictureUrl: null,
        );

        expect(user.firstName.length, equals(100));
        expect(user.lastName.length, equals(100));
        expect(user.fullName.length, equals(201)); // 100 + space + 100
      });

      test('handles special characters in names', () {
        final user = User(
          uuid: '123',
          firstName: "O'Brien",
          lastName: 'Müller-Schmidt',
          email: 'special@example.com',
          profilePictureUrl: null,
        );

        expect(user.fullName, equals("O'Brien Müller-Schmidt"));
      });

      test('handles unicode characters', () {
        final user = User(
          uuid: '123',
          firstName: '李',
          lastName: '明',
          email: 'unicode@example.com',
          profilePictureUrl: null,
        );

        expect(user.fullName, equals('李 明'));
      });

      test('handles very long URLs', () {
        final longUrl = 'https://example.com/${'a' * 500}.jpg';
        final user = User(
          uuid: '123',
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          profilePictureUrl: longUrl,
        );

        expect(user.profilePictureUrl, equals(longUrl));
      });
    });
  });
}
