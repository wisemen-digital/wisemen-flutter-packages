import 'package:flutter_test/flutter_test.dart';
import 'package:wise_ultra_settings/src/network/dto/user_dto.dart';

void main() {
  group('UserDTO', () {
    group('constructor', () {
      test('creates instance with all fields', () {
        final dto = UserDTO(
          uuid: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phone: '+1234567890',
          mobilePhone: '+0987654321',
          birthDate: '1990-01-01',
        );

        expect(dto.uuid, '123');
        expect(dto.firstName, 'John');
        expect(dto.lastName, 'Doe');
        expect(dto.email, 'john@example.com');
        expect(dto.phone, '+1234567890');
        expect(dto.mobilePhone, '+0987654321');
        expect(dto.birthDate, '1990-01-01');
      });

      test('creates instance with null optional fields', () {
        final dto = UserDTO(
          uuid: '456',
          firstName: 'Jane',
          lastName: 'Smith',
          email: null,
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        expect(dto.uuid, '456');
        expect(dto.firstName, 'Jane');
        expect(dto.lastName, 'Smith');
        expect(dto.email, isNull);
        expect(dto.phone, isNull);
        expect(dto.mobilePhone, isNull);
        expect(dto.birthDate, isNull);
      });
    });

    group('fromJson', () {
      test('deserializes from JSON with all fields', () {
        final json = {
          'uuid': '123',
          'firstName': 'John',
          'lastName': 'Doe',
          'email': 'john@example.com',
          'phone': '+1234567890',
          'mobilePhone': '+0987654321',
          'birthDate': '1990-01-01',
        };

        final dto = UserDTO.fromJson(json);

        expect(dto.uuid, '123');
        expect(dto.firstName, 'John');
        expect(dto.lastName, 'Doe');
        expect(dto.email, 'john@example.com');
        expect(dto.phone, '+1234567890');
        expect(dto.mobilePhone, '+0987654321');
        expect(dto.birthDate, '1990-01-01');
      });

      test('deserializes from JSON with null optional fields', () {
        final json = {
          'uuid': '456',
          'firstName': 'Jane',
          'lastName': 'Smith',
        };

        final dto = UserDTO.fromJson(json);

        expect(dto.uuid, '456');
        expect(dto.firstName, 'Jane');
        expect(dto.lastName, 'Smith');
        expect(dto.email, isNull);
        expect(dto.phone, isNull);
        expect(dto.mobilePhone, isNull);
        expect(dto.birthDate, isNull);
      });

      test('handles empty strings', () {
        final json = {
          'uuid': '',
          'firstName': '',
          'lastName': '',
          'email': '',
          'phone': '',
          'mobilePhone': '',
          'birthDate': '',
        };

        final dto = UserDTO.fromJson(json);

        expect(dto.uuid, '');
        expect(dto.firstName, '');
        expect(dto.lastName, '');
        expect(dto.email, '');
        expect(dto.phone, '');
        expect(dto.mobilePhone, '');
        expect(dto.birthDate, '');
      });

      test('handles special characters', () {
        final json = {
          'uuid': 'special-123',
          'firstName': "O'Brien",
          'lastName': 'Müller-Schmidt',
          'email': 'special@example.com',
        };

        final dto = UserDTO.fromJson(json);

        expect(dto.firstName, "O'Brien");
        expect(dto.lastName, 'Müller-Schmidt');
      });

      test('handles unicode characters', () {
        final json = {
          'uuid': 'unicode-123',
          'firstName': '李',
          'lastName': '明',
          'email': 'unicode@example.com',
        };

        final dto = UserDTO.fromJson(json);

        expect(dto.firstName, '李');
        expect(dto.lastName, '明');
      });
    });

    group('toJson', () {
      test('serializes to JSON with all fields', () {
        final dto = UserDTO(
          uuid: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phone: '+1234567890',
          mobilePhone: '+0987654321',
          birthDate: '1990-01-01',
        );

        final json = dto.toJson();

        expect(json['uuid'], '123');
        expect(json['firstName'], 'John');
        expect(json['lastName'], 'Doe');
        expect(json['email'], 'john@example.com');
        expect(json['phone'], '+1234567890');
        expect(json['mobilePhone'], '+0987654321');
        expect(json['birthDate'], '1990-01-01');
      });

      test('serializes to JSON with null optional fields', () {
        final dto = UserDTO(
          uuid: '456',
          firstName: 'Jane',
          lastName: 'Smith',
          email: null,
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        final json = dto.toJson();

        expect(json['uuid'], '456');
        expect(json['firstName'], 'Jane');
        expect(json['lastName'], 'Smith');
        expect(json['email'], isNull);
        expect(json['phone'], isNull);
        expect(json['mobilePhone'], isNull);
        expect(json['birthDate'], isNull);
      });

      test('handles empty strings', () {
        final dto = UserDTO(
          uuid: '',
          firstName: '',
          lastName: '',
          email: '',
          phone: '',
          mobilePhone: '',
          birthDate: '',
        );

        final json = dto.toJson();

        expect(json['uuid'], '');
        expect(json['firstName'], '');
        expect(json['lastName'], '');
        expect(json['email'], '');
        expect(json['phone'], '');
        expect(json['mobilePhone'], '');
        expect(json['birthDate'], '');
      });
    });

    group('round-trip serialization', () {
      test('toJson -> fromJson maintains data integrity', () {
        final original = UserDTO(
          uuid: 'roundtrip-123',
          firstName: 'Round',
          lastName: 'Trip',
          email: 'roundtrip@test.com',
          phone: '+1111111111',
          mobilePhone: '+2222222222',
          birthDate: '1985-06-15',
        );

        final json = original.toJson();
        final deserialized = UserDTO.fromJson(json);

        expect(deserialized.uuid, original.uuid);
        expect(deserialized.firstName, original.firstName);
        expect(deserialized.lastName, original.lastName);
        expect(deserialized.email, original.email);
        expect(deserialized.phone, original.phone);
        expect(deserialized.mobilePhone, original.mobilePhone);
        expect(deserialized.birthDate, original.birthDate);
      });

      test('toJson -> fromJson with nulls maintains data integrity', () {
        final original = UserDTO(
          uuid: 'roundtrip-456',
          firstName: 'Null',
          lastName: 'Test',
          email: null,
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        final json = original.toJson();
        final deserialized = UserDTO.fromJson(json);

        expect(deserialized.uuid, original.uuid);
        expect(deserialized.firstName, original.firstName);
        expect(deserialized.lastName, original.lastName);
        expect(deserialized.email, isNull);
        expect(deserialized.phone, isNull);
        expect(deserialized.mobilePhone, isNull);
        expect(deserialized.birthDate, isNull);
      });
    });
  });
}
