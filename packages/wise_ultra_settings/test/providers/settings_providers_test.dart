import 'package:drift/drift.dart' hide isNull;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';

import '../utils/fake_implementations.dart';

class MockDatabase extends Mock implements GeneratedDatabase {}

void main() {
  late MockSettingsRepository mockRepository;

  setUpAll(() {
    SettingsFeature.init(
      settingsLocalizations: FakeSettingsLocalizations(),
      settingsAssets: FakeSettingsAssets(),
      settingsNavigationManager: Provider<SettingsNavigationManager>(
        (ref) => FakeSettingsNavigationManager(),
      ),
      settingsFlavors: FakeSettingsFlavors(),
      settingsDatabase: Provider<GeneratedDatabase>((ref) => MockDatabase()),
    );
  });

  setUp(() {
    mockRepository = MockSettingsRepository();
  });

  group('CurrentUser provider', () {
    test('calls refreshCurrentUser on build', () {
      when(() => mockRepository.refreshCurrentUser()).thenAnswer((_) async => {});
      when(() => mockRepository.watchCurrentUser()).thenAnswer(
        (_) => Stream.value(null),
      );

      final container = ProviderContainer(
        overrides: [
          SettingsFeature.repository.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      container.read(currentUserProvider);

      verify(() => mockRepository.refreshCurrentUser()).called(1);
    });

    test('watches current user stream', () async {
      final testUser = User(
        uuid: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
      );

      when(() => mockRepository.refreshCurrentUser()).thenAnswer((_) async => {});
      when(() => mockRepository.watchCurrentUser()).thenAnswer(
        (_) => Stream.value(testUser),
      );

      final container = ProviderContainer(
        overrides: [
          SettingsFeature.repository.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      final stream = container.read(currentUserProvider.future);

      await expectLater(stream, completion(testUser));
    });

    test('handles null user', () async {
      when(() => mockRepository.refreshCurrentUser()).thenAnswer((_) async => {});
      when(() => mockRepository.watchCurrentUser()).thenAnswer(
        (_) => Stream.value(null),
      );

      final container = ProviderContainer(
        overrides: [
          SettingsFeature.repository.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      final stream = container.read(currentUserProvider.future);

      await expectLater(stream, completion(isNull));
    });
  });

  group('HasEditedUser provider', () {
    test('initial state is false', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final hasEdited = container.read(hasEditedUserProvider);

      expect(hasEdited, false);
    });

    test('changeValue updates state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(hasEditedUserProvider.notifier).changeValue(true);

      expect(container.read(hasEditedUserProvider), true);
    });

    test('changeValue can toggle state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(hasEditedUserProvider.notifier).changeValue(true);
      expect(container.read(hasEditedUserProvider), true);

      container.read(hasEditedUserProvider.notifier).changeValue(false);
      expect(container.read(hasEditedUserProvider), false);
    });
  });

  group('FirstName provider', () {
    test('initial state is user firstName', () {
      final testUser = User(
        uuid: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
      );

      when(() => mockRepository.refreshCurrentUser()).thenAnswer((_) async => {});
      when(() => mockRepository.watchCurrentUser()).thenAnswer(
        (_) => Stream.value(testUser),
      );

      final container = ProviderContainer(
        overrides: [
          SettingsFeature.repository.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      container.read(currentUserProvider);

      final firstName = container.read(firstNameProvider);

      expect(firstName, 'John');
    });

    test('changeValue updates state and marks as edited', () {
      final testUser = User(
        uuid: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
      );

      when(() => mockRepository.refreshCurrentUser()).thenAnswer((_) async => {});
      when(() => mockRepository.watchCurrentUser()).thenAnswer(
        (_) => Stream.value(testUser),
      );

      final container = ProviderContainer(
e        overrides: [
          SettingsFeature.repository.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      container.read(currentUserProvider);

      container.read(firstNameProvider.notifier).changeValue('Jane');

      expect(container.read(firstNameProvider), 'Jane');
      expect(container.read(hasEditedUserProvider), true);
    });
  });

  group('LastName provider', () {
    test('initial state is user lastName', () {
      final testUser = User(
        uuid: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
      );

      when(() => mockRepository.refreshCurrentUser()).thenAnswer((_) async => {});
      when(() => mockRepository.watchCurrentUser()).thenAnswer(
        (_) => Stream.value(testUser),
      );

      final container = ProviderContainer(
        overrides: [
          SettingsFeature.repository.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      container.read(currentUserProvider);

      final lastName = container.read(lastNameProvider);

      expect(lastName, 'Doe');
    });

    test('changeValue updates state and marks as edited', () {
      final testUser = User(
        uuid: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
      );

      when(() => mockRepository.refreshCurrentUser()).thenAnswer((_) async => {});
      when(() => mockRepository.watchCurrentUser()).thenAnswer(
        (_) => Stream.value(testUser),
      );

      final container = ProviderContainer(
        overrides: [
          SettingsFeature.repository.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      container.read(currentUserProvider);

      container.read(lastNameProvider.notifier).changeValue('Smith');

      expect(container.read(lastNameProvider), 'Smith');
      expect(container.read(hasEditedUserProvider), true);
    });
  });

  group('DateOfBirth provider', () {
    test('initial state is user birthDate', () {
      final birthDate = DateTime(1990);
      final testUser = User(
        uuid: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        birthDate: birthDate,
      );

      when(() => mockRepository.refreshCurrentUser()).thenAnswer((_) async => {});
      when(() => mockRepository.watchCurrentUser()).thenAnswer(
        (_) => Stream.value(testUser),
      );

      final container = ProviderContainer(
        overrides: [
          SettingsFeature.repository.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      container.read(currentUserProvider);

      final dob = container.read(dateOfBirthProvider);

      expect(dob, birthDate);
    });

    test('changeValue updates state and marks as edited', () {
      final testUser = User(
        uuid: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        birthDate: DateTime(1990),
      );

      when(() => mockRepository.refreshCurrentUser()).thenAnswer((_) async => {});
      when(() => mockRepository.watchCurrentUser()).thenAnswer(
        (_) => Stream.value(testUser),
      );

      final container = ProviderContainer(
        overrides: [
          SettingsFeature.repository.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      container.read(currentUserProvider);

      final newDate = DateTime(1995, 6, 15);
      container.read(dateOfBirthProvider.notifier).changeValue(newDate);

      expect(container.read(dateOfBirthProvider), newDate);
      expect(container.read(hasEditedUserProvider), true);
    });
  });
}
