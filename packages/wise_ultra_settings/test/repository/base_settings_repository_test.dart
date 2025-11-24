import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise_ultra_settings/wise_ultra_settings.dart';

import '../utils/fake_implementations.dart';

void main() {
  late MockUserService mockUserService;
  late MockUserDao mockUserDao;
  late ProviderContainer container;

  setUp(() {
    mockUserService = MockUserService();
    mockUserDao = MockUserDao();

    container = ProviderContainer(
      overrides: [
        userServiceProvider.overrideWithValue(mockUserService),
        userDaoProvider.overrideWithValue(mockUserDao),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  setUpAll(() {
    registerFallbackValue(BaseSettingsUserTableCompanion.insert(
      id: '',
      firstName: '',
      lastName: '',
    ));
  });

  group('BaseSettingsRepository', () {
    group('watchCurrentUser', () {
      test('returns stream of user from dao', () async {
        final testUser = BaseSettingsUser(
          id: '123',
          firstName: 'John',
          lastName: 'Doe',
          primaryEmail: 'john@example.com',
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        when(() => mockUserDao.watchUser()).thenAnswer(
          (_) => Stream.value(testUser),
        );

        final repository = container.read(baseSettingsRepositoryProvider);
        final stream = repository.watchCurrentUser();

        await expectLater(
          stream,
          emits(isA<User>().having((u) => u.uuid, 'uuid', '123')),
        );

        verify(() => mockUserDao.watchUser()).called(1);
      });

      test('returns stream with null when no user', () async {
        when(() => mockUserDao.watchUser()).thenAnswer(
          (_) => Stream.value(null),
        );

        final repository = container.read(baseSettingsRepositoryProvider);
        final stream = repository.watchCurrentUser();

        await expectLater(stream, emits(isNull));
        verify(() => mockUserDao.watchUser()).called(1);
      });

      test('maps database model to feature model correctly', () async {
        final testUser = BaseSettingsUser(
          id: '456',
          firstName: 'Jane',
          lastName: 'Smith',
          primaryEmail: 'jane@example.com',
          phone: '+1234567890',
          mobilePhone: '+0987654321',
          birthDate: DateTime(1990, 1, 1),
        );

        when(() => mockUserDao.watchUser()).thenAnswer(
          (_) => Stream.value(testUser),
        );

        final repository = container.read(baseSettingsRepositoryProvider);
        final stream = repository.watchCurrentUser();

        await expectLater(
          stream,
          emits(
            isA<User>()
                .having((u) => u.uuid, 'uuid', '456')
                .having((u) => u.firstName, 'firstName', 'Jane')
                .having((u) => u.lastName, 'lastName', 'Smith')
                .having((u) => u.email, 'email', 'jane@example.com')
                .having((u) => u.birthDate, 'birthDate', DateTime(1990, 1, 1)),
          ),
        );
      });
    });

    group('refreshCurrentUser', () {
      test('fetches user from service and saves to dao', () async {
        final userDto = UserDTO(
          uuid: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        when(() => mockUserService.getMe()).thenAnswer((_) async => userDto);
        when(() => mockUserDao.insertUser(userCompanion: any(named: 'userCompanion')))
            .thenAnswer((_) async => 1);

        final repository = container.read(baseSettingsRepositoryProvider);
        await repository.refreshCurrentUser();

        verify(() => mockUserService.getMe()).called(1);
        verify(() => mockUserDao.insertUser(userCompanion: any(named: 'userCompanion'))).called(1);
      });

      test('handles service errors', () async {
        when(() => mockUserService.getMe()).thenThrow(Exception('Network error'));

        final repository = container.read(baseSettingsRepositoryProvider);

        expect(
          () => repository.refreshCurrentUser(),
          throwsA(isA<Exception>()),
        );

        verify(() => mockUserService.getMe()).called(1);
        verifyNever(() => mockUserDao.insertUser(userCompanion: any(named: 'userCompanion')));
      });
    });

    group('updateUser', () {
      test('updates user via service and refreshes', () async {
        final userDto = UserDTO(
          uuid: '123',
          firstName: 'Updated',
          lastName: 'Name',
          email: 'updated@example.com',
          phone: null,
          mobilePhone: null,
          birthDate: '1995-06-15',
        );

        when(() => mockUserService.updateMe(
              firstName: any(named: 'firstName'),
              lastName: any(named: 'lastName'),
              birthDate: any(named: 'birthDate'),
            )).thenAnswer((_) async => {});
        when(() => mockUserService.getMe()).thenAnswer((_) async => userDto);
        when(() => mockUserDao.insertUser(userCompanion: any(named: 'userCompanion')))
            .thenAnswer((_) async => 1);

        final repository = container.read(baseSettingsRepositoryProvider);
        await repository.updateUser(
          firstName: 'Updated',
          lastName: 'Name',
          birthDate: DateTime(1995, 6, 15),
        );

        verify(() => mockUserService.updateMe(
              firstName: 'Updated',
              lastName: 'Name',
              birthDate: DateTime(1995, 6, 15),
            )).called(1);
        verify(() => mockUserService.getMe()).called(1);
        verify(() => mockUserDao.insertUser(userCompanion: any(named: 'userCompanion'))).called(1);
      });

      test('updates user without birthDate', () async {
        final userDto = UserDTO(
          uuid: '123',
          firstName: 'Updated',
          lastName: 'Name',
          email: 'updated@example.com',
          phone: null,
          mobilePhone: null,
          birthDate: null,
        );

        when(() => mockUserService.updateMe(
              firstName: any(named: 'firstName'),
              lastName: any(named: 'lastName'),
              birthDate: any(named: 'birthDate'),
            )).thenAnswer((_) async => {});
        when(() => mockUserService.getMe()).thenAnswer((_) async => userDto);
        when(() => mockUserDao.insertUser(userCompanion: any(named: 'userCompanion')))
            .thenAnswer((_) async => 1);

        final repository = container.read(baseSettingsRepositoryProvider);
        await repository.updateUser(
          firstName: 'Updated',
          lastName: 'Name',
        );

        verify(() => mockUserService.updateMe(
              firstName: 'Updated',
              lastName: 'Name',
              birthDate: null,
            )).called(1);
      });
    });
  });
}
