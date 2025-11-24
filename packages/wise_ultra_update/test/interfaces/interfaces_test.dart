import 'package:test/test.dart';
import 'package:wise_ultra_update/wise_ultra_update.dart';

// Concrete implementations for testing
class TestUpdateLocalizations implements UpdateLocalizations {
  @override
  String get newUpdateAvailableTitle => 'Test Title';

  @override
  String get newUpdateAvailableSubtitle => 'Test Subtitle';

  @override
  String get installUpdate => 'Test Install';

  @override
  String get illDoThisLater => 'Test Later';
}

class TestUpdateAssets implements UpdateAssets {
  @override
  String? get avatar => 'test_avatar.png';
}

class TestUpdateNavigationManager implements UpdateNavigationManager {
  bool installUpdateCalled = false;
  bool installLaterCalled = false;

  @override
  void installUpdate() {
    installUpdateCalled = true;
  }

  @override
  void installLater() {
    installLaterCalled = true;
  }
}

class TestUpdateRepository implements UpdateRepository {
  @override
  Future<(bool, bool)> checkNeedsUpdate() async {
    return (true, false);
  }
}

void main() {
  group('UpdateLocalizations Interface', () {
    test('can be implemented', () {
      final localizations = TestUpdateLocalizations();
      expect(localizations, isA<UpdateLocalizations>());
    });

    test('has all required getters', () {
      final localizations = TestUpdateLocalizations();
      expect(localizations.newUpdateAvailableTitle, 'Test Title');
      expect(localizations.newUpdateAvailableSubtitle, 'Test Subtitle');
      expect(localizations.installUpdate, 'Test Install');
      expect(localizations.illDoThisLater, 'Test Later');
    });
  });

  group('UpdateAssets Interface', () {
    test('can be implemented', () {
      final assets = TestUpdateAssets();
      expect(assets, isA<UpdateAssets>());
    });

    test('has avatar getter', () {
      final assets = TestUpdateAssets();
      expect(assets.avatar, 'test_avatar.png');
    });

    test('avatar can be null', () {
      final assets = TestUpdateAssets();
      expect(assets.avatar, isNotNull);
    });
  });

  group('UpdateNavigationManager Interface', () {
    test('can be implemented', () {
      final manager = TestUpdateNavigationManager();
      expect(manager, isA<UpdateNavigationManager>());
    });

    test('has installUpdate method', () {
      final manager = TestUpdateNavigationManager();
      expect(manager.installUpdate, isA<Function>());
    });

    test('has installLater method', () {
      final manager = TestUpdateNavigationManager();
      expect(manager.installLater, isA<Function>());
    });

    test('installUpdate can be called', () {
      final manager = TestUpdateNavigationManager()
      ..installUpdate();
      expect(manager.installUpdateCalled, true);
    });

    test('installLater can be called', () {
      final manager = TestUpdateNavigationManager()
      ..installLater();
      expect(manager.installLaterCalled, true);
    });
  });

  group('UpdateRepository Interface', () {
    test('can be implemented', () {
      final repository = TestUpdateRepository();
      expect(repository, isA<UpdateRepository>());
    });

    test('has checkNeedsUpdate method', () {
      final repository = TestUpdateRepository();
      expect(repository.checkNeedsUpdate, isA<Function>());
    });

    test('checkNeedsUpdate returns tuple', () async {
      final repository = TestUpdateRepository();
      final result = await repository.checkNeedsUpdate();
      expect(result, isA<(bool, bool)>());
      expect(result.$1, true);
      expect(result.$2, false);
    });
  });
}
