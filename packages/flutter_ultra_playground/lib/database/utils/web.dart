// ignore: deprecated_member_use
import 'package:drift/web.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../database.dart';

Database constructDb({bool logStatements = false, required Ref ref}) {
  return Database(WebDatabase('db', logStatements: logStatements), ref);
}
