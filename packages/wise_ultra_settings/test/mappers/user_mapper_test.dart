import 'package:flutter_test/flutter_test.dart';
import 'package:wise_ultra_settings/src/database/database.dart';
import 'package:wise_ultra_settings/src/network/dto/dto.dart';
import 'package:wise_ultra_settings/src/repository/mappers/user_mapper.dart';

void main() {
  group('UserMapper', () {
    group('toDbCompanion', () {
      test('maps all fields correctly', () {
        const dto = UserDTO(
          uuid: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phone: '+1234567890',
          mobilePhone: '+0987654321',
          birthDate: '1990-01-15',
        );

        final companion = dto.toDbCompanion();

        expect(companion.id.value, equals('123'));
        expect(companion.firstName.value, equals('John'));
        expect(companion.lastName.value, equals('Doe'));
        expect(companion.primaryEmail.value, equals('john@example.com'));
        expect(companion.phone.value, equals('+1234567890'));
        expect(companion.mobilePhone.value, equals('+0987654321'));
        expect(companion.birthDate.value, equals(DateTime(1990, 1, 15)));
      });

      test('handles null optional fields', () {
        const dto = UserDTO(
          uuid: '456',
          firstName: 'Jane',
          lastName: 'Smith',
          email: null,
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        final companion = dto.toDbCompanion();

        expect(companion.id.value, equals('456'));
        expect(companion.firstName.value, equals('Jane'));
        expect(companion.lastName.value, equals('Smith'));
        expect(companion.primaryEmail.value, isNull);
        expect(companion.phone.value, isNull);
        expect(companion.mobilePhone.value, isNull);
        expect(companion.birthDate.value, isNull);
      });

      test('parses birthDate string correctly', () {
        const dto = UserDTO(
          uuid: '789',
          firstName: 'Bob',
          lastName: 'Johnson',
          birthDate: '1985-12-25',
        );

        final companion = dto.toDbCompanion();

        expect(companion.birthDate.value, equals(DateTime(1985, 12, 25)));
      });

      test('handles different date formats', () {
        const dto = UserDTO(
          uuid: '101',
          firstName: 'Alice',
          lastName: 'Williams',
          birthDate: '2000-06-15T10:30:00.000Z',
        );

        final companion = dto.toDbCompanion();

        expect(companion.birthDate.value, isNotNull);
        expect(companion.birthDate.value!.year, equals(2000));
        expect(companion.birthDate.value!.month, equals(6));
        expect(companion.birthDate.value!.day, equals(15));
      });

      test('handles empty strings', () {
        const dto = UserDTO(
          uuid: '',
          firstName: '',
          lastName: '',
          email: '',
          phone: '',
          mobilePhone: '',
        );

        final companion = dto.toDbCompanion();

        expect(companion.id.value, equals(''));
        expect(companion.firstName.value, equals(''));
        expect(companion.lastName.value, equals(''));
        expect(companion.primaryEmail.value, equals(''));
        expect(companion.phone.value, equals(''));
        expect(companion.mobilePhone.value, equals(''));
      });

      test('handles special characters in names', () {
        const dto = UserDTO(
          uuid: '202',
          firstName: "O'Brien",
          lastName: 'Müller-Schmidt',
          email: 'test@example.com',
        );

        final companion = dto.toDbCompanion();

        expect(companion.firstName.value, equals("O'Brien"));
        expect(companion.lastName.value, equals('Müller-Schmidt'));
      });

      test('handles unicode characters', () {
        const dto = UserDTO(
          uuid: '303',
          firstName: '李',
          lastName: '明',
          email: 'unicode@example.com',
        );

        final companion = dto.toDbCompanion();

        expect(companion.firstName.value, equals('李'));
        expect(companion.lastName.value, equals('明'));
      });
    });
  });

  group('BaseUserMapper', () {
    group('toFeatureModel', () {
      test('maps all fields correctly', () {
        final dbUser = BaseSettingsUser(
          id: '123',
          firstName: 'John',
          lastName: 'Doe',
          primaryEmail: 'john@example.com',
          phone: '+1234567890',
          mobilePhone: '+0987654321',
          birthDate: DateTime(1990, 1, 15),
        );

        final user = dbUser.toFeatureModel();

        expect(user.uuid, equals('123'));
        expect(user.firstName, equals('John'));
        expect(user.lastName, equals('Doe'));
        expect(user.email, equals('john@example.com'));
        expect(user.birthDate, equals(DateTime(1990, 1, 15)));
        expect(user.profilePictureUrl, equals(''));
      });

      test('handles null email', () {
        final dbUser = BaseSettingsUser(
          id: '456',
          firstName: 'Jane',
          lastName: 'Smith',
          primaryEmail: null,
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        final user = dbUser.toFeatureModel();

        expect(user.uuid, equals('456'));
        expect(user.firstName, equals('Jane'));
        expect(user.lastName, equals('Smith'));
        expect(user.email, equals(''));
        expect(user.birthDate, isNull);
        expect(user.profilePictureUrl, equals(''));
      });

      test('handles null birthDate', () {
        final dbUser = BaseSettingsUser(
          id: '789',
          firstName: 'Bob',
          lastName: 'Johnson',
          primaryEmail: 'bob@example.com',
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        final user = dbUser.toFeatureModel();

        expect(user.birthDate, isNull);
      });

      test('sets profilePictureUrl to empty string', () {
        final dbUser = BaseSettingsUser(
          id: '101',
          firstName: 'Alice',
          lastName: 'Williams',
          primaryEmail: 'alice@example.com',
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        final user = dbUser.toFeatureModel();

        expect(user.profilePictureUrl, equals(''));
      });

      test('fullName works correctly on mapped user', () {
        final dbUser = BaseSettingsUser(
          id: '202',
          firstName: 'Charlie',
          lastName: 'Brown',
          primaryEmail: 'charlie@example.com',
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        final user = dbUser.toFeatureModel();

        expect(user.fullName, equals('Charlie Brown'));
      });

      test('handles empty strings', () {
        final dbUser = BaseSettingsUser(
          id: '',
          firstName: '',
          lastName: '',
          primaryEmail: '',
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        final user = dbUser.toFeatureModel();

        expect(user.uuid, equals(''));
        expect(user.firstName, equals(''));
        expect(user.lastName, equals(''));
        expect(user.email, equals(''));
      });

      test('handles special characters', () {
        final dbUser = BaseSettingsUser(
          id: '303',
          firstName: "O'Brien",
          lastName: 'Müller-Schmidt',
          primaryEmail: 'special@example.com',
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        final user = dbUser.toFeatureModel();

        expect(user.firstName, equals("O'Brien"));
        expect(user.lastName, equals('Müller-Schmidt'));
        expect(user.fullName, equals("O'Brien Müller-Schmidt"));
      });

      test('handles unicode characters', () {
        final dbUser = BaseSettingsUser(
          id: '404',
          firstName: '李',
          lastName: '明',
          primaryEmail: 'unicode@example.com',
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        final user = dbUser.toFeatureModel();

        expect(user.firstName, equals('李'));
        expect(user.lastName, equals('明'));
        expect(user.fullName, equals('李 明'));
      });
    });
  });
}
