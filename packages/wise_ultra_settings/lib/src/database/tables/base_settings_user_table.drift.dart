// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:wise_ultra_settings/src/database/tables/base_settings_user_table.drift.dart'
    as i1;
import 'package:wise_ultra_settings/src/database/tables/base_settings_user_table.dart'
    as i2;

typedef $$BaseSettingsUserTableTableCreateCompanionBuilder
    = i1.BaseSettingsUserTableCompanion Function({
  required String id,
  required String firstName,
  required String lastName,
  i0.Value<String?> primaryEmail,
  i0.Value<String?> phone,
  i0.Value<String?> mobilePhone,
  i0.Value<DateTime?> birthDate,
  i0.Value<int> rowid,
});
typedef $$BaseSettingsUserTableTableUpdateCompanionBuilder
    = i1.BaseSettingsUserTableCompanion Function({
  i0.Value<String> id,
  i0.Value<String> firstName,
  i0.Value<String> lastName,
  i0.Value<String?> primaryEmail,
  i0.Value<String?> phone,
  i0.Value<String?> mobilePhone,
  i0.Value<DateTime?> birthDate,
  i0.Value<int> rowid,
});

class $$BaseSettingsUserTableTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$BaseSettingsUserTableTable> {
  $$BaseSettingsUserTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get primaryEmail => $composableBuilder(
      column: $table.primaryEmail,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get mobilePhone => $composableBuilder(
      column: $table.mobilePhone,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<DateTime> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => i0.ColumnFilters(column));
}

class $$BaseSettingsUserTableTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$BaseSettingsUserTableTable> {
  $$BaseSettingsUserTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get primaryEmail => $composableBuilder(
      column: $table.primaryEmail,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get mobilePhone => $composableBuilder(
      column: $table.mobilePhone,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<DateTime> get birthDate => $composableBuilder(
      column: $table.birthDate,
      builder: (column) => i0.ColumnOrderings(column));
}

class $$BaseSettingsUserTableTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$BaseSettingsUserTableTable> {
  $$BaseSettingsUserTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  i0.GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  i0.GeneratedColumn<String> get primaryEmail => $composableBuilder(
      column: $table.primaryEmail, builder: (column) => column);

  i0.GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  i0.GeneratedColumn<String> get mobilePhone => $composableBuilder(
      column: $table.mobilePhone, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);
}

class $$BaseSettingsUserTableTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.$BaseSettingsUserTableTable,
    i1.BaseSettingsUser,
    i1.$$BaseSettingsUserTableTableFilterComposer,
    i1.$$BaseSettingsUserTableTableOrderingComposer,
    i1.$$BaseSettingsUserTableTableAnnotationComposer,
    $$BaseSettingsUserTableTableCreateCompanionBuilder,
    $$BaseSettingsUserTableTableUpdateCompanionBuilder,
    (
      i1.BaseSettingsUser,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$BaseSettingsUserTableTable,
          i1.BaseSettingsUser>
    ),
    i1.BaseSettingsUser,
    i0.PrefetchHooks Function()> {
  $$BaseSettingsUserTableTableTableManager(
      i0.GeneratedDatabase db, i1.$BaseSettingsUserTableTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$BaseSettingsUserTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$BaseSettingsUserTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$BaseSettingsUserTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> id = const i0.Value.absent(),
            i0.Value<String> firstName = const i0.Value.absent(),
            i0.Value<String> lastName = const i0.Value.absent(),
            i0.Value<String?> primaryEmail = const i0.Value.absent(),
            i0.Value<String?> phone = const i0.Value.absent(),
            i0.Value<String?> mobilePhone = const i0.Value.absent(),
            i0.Value<DateTime?> birthDate = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.BaseSettingsUserTableCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            primaryEmail: primaryEmail,
            phone: phone,
            mobilePhone: mobilePhone,
            birthDate: birthDate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String firstName,
            required String lastName,
            i0.Value<String?> primaryEmail = const i0.Value.absent(),
            i0.Value<String?> phone = const i0.Value.absent(),
            i0.Value<String?> mobilePhone = const i0.Value.absent(),
            i0.Value<DateTime?> birthDate = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.BaseSettingsUserTableCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            primaryEmail: primaryEmail,
            phone: phone,
            mobilePhone: mobilePhone,
            birthDate: birthDate,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BaseSettingsUserTableTableProcessedTableManager
    = i0.ProcessedTableManager<
        i0.GeneratedDatabase,
        i1.$BaseSettingsUserTableTable,
        i1.BaseSettingsUser,
        i1.$$BaseSettingsUserTableTableFilterComposer,
        i1.$$BaseSettingsUserTableTableOrderingComposer,
        i1.$$BaseSettingsUserTableTableAnnotationComposer,
        $$BaseSettingsUserTableTableCreateCompanionBuilder,
        $$BaseSettingsUserTableTableUpdateCompanionBuilder,
        (
          i1.BaseSettingsUser,
          i0.BaseReferences<i0.GeneratedDatabase,
              i1.$BaseSettingsUserTableTable, i1.BaseSettingsUser>
        ),
        i1.BaseSettingsUser,
        i0.PrefetchHooks Function()>;

class $BaseSettingsUserTableTable extends i2.BaseSettingsUserTable
    with i0.TableInfo<$BaseSettingsUserTableTable, i1.BaseSettingsUser> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BaseSettingsUserTableTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _firstNameMeta =
      const i0.VerificationMeta('firstName');
  @override
  late final i0.GeneratedColumn<String> firstName = i0.GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _lastNameMeta =
      const i0.VerificationMeta('lastName');
  @override
  late final i0.GeneratedColumn<String> lastName = i0.GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _primaryEmailMeta =
      const i0.VerificationMeta('primaryEmail');
  @override
  late final i0.GeneratedColumn<String> primaryEmail =
      i0.GeneratedColumn<String>('primary_email', aliasedName, true,
          type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _phoneMeta =
      const i0.VerificationMeta('phone');
  @override
  late final i0.GeneratedColumn<String> phone = i0.GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _mobilePhoneMeta =
      const i0.VerificationMeta('mobilePhone');
  @override
  late final i0.GeneratedColumn<String> mobilePhone =
      i0.GeneratedColumn<String>('mobile_phone', aliasedName, true,
          type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _birthDateMeta =
      const i0.VerificationMeta('birthDate');
  @override
  late final i0.GeneratedColumn<DateTime> birthDate =
      i0.GeneratedColumn<DateTime>('birth_date', aliasedName, true,
          type: i0.DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<i0.GeneratedColumn> get $columns =>
      [id, firstName, lastName, primaryEmail, phone, mobilePhone, birthDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'base_settings_user_table';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.BaseSettingsUser> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('primary_email')) {
      context.handle(
          _primaryEmailMeta,
          primaryEmail.isAcceptableOrUnknown(
              data['primary_email']!, _primaryEmailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('mobile_phone')) {
      context.handle(
          _mobilePhoneMeta,
          mobilePhone.isAcceptableOrUnknown(
              data['mobile_phone']!, _mobilePhoneMeta));
    }
    if (data.containsKey('birth_date')) {
      context.handle(_birthDateMeta,
          birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.BaseSettingsUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.BaseSettingsUser(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}id'])!,
      firstName: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      primaryEmail: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}primary_email']),
      phone: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}phone']),
      mobilePhone: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}mobile_phone']),
      birthDate: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.dateTime, data['${effectivePrefix}birth_date']),
    );
  }

  @override
  $BaseSettingsUserTableTable createAlias(String alias) {
    return $BaseSettingsUserTableTable(attachedDatabase, alias);
  }
}

class BaseSettingsUser extends i0.DataClass
    implements i0.Insertable<i1.BaseSettingsUser> {
  final String id;
  final String firstName;
  final String lastName;
  final String? primaryEmail;
  final String? phone;
  final String? mobilePhone;
  final DateTime? birthDate;
  const BaseSettingsUser(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.primaryEmail,
      this.phone,
      this.mobilePhone,
      this.birthDate});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    map['first_name'] = i0.Variable<String>(firstName);
    map['last_name'] = i0.Variable<String>(lastName);
    if (!nullToAbsent || primaryEmail != null) {
      map['primary_email'] = i0.Variable<String>(primaryEmail);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = i0.Variable<String>(phone);
    }
    if (!nullToAbsent || mobilePhone != null) {
      map['mobile_phone'] = i0.Variable<String>(mobilePhone);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = i0.Variable<DateTime>(birthDate);
    }
    return map;
  }

  i1.BaseSettingsUserTableCompanion toCompanion(bool nullToAbsent) {
    return i1.BaseSettingsUserTableCompanion(
      id: i0.Value(id),
      firstName: i0.Value(firstName),
      lastName: i0.Value(lastName),
      primaryEmail: primaryEmail == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(primaryEmail),
      phone: phone == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(phone),
      mobilePhone: mobilePhone == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(mobilePhone),
      birthDate: birthDate == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(birthDate),
    );
  }

  factory BaseSettingsUser.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return BaseSettingsUser(
      id: serializer.fromJson<String>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      primaryEmail: serializer.fromJson<String?>(json['primaryEmail']),
      phone: serializer.fromJson<String?>(json['phone']),
      mobilePhone: serializer.fromJson<String?>(json['mobilePhone']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'primaryEmail': serializer.toJson<String?>(primaryEmail),
      'phone': serializer.toJson<String?>(phone),
      'mobilePhone': serializer.toJson<String?>(mobilePhone),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
    };
  }

  i1.BaseSettingsUser copyWith(
          {String? id,
          String? firstName,
          String? lastName,
          i0.Value<String?> primaryEmail = const i0.Value.absent(),
          i0.Value<String?> phone = const i0.Value.absent(),
          i0.Value<String?> mobilePhone = const i0.Value.absent(),
          i0.Value<DateTime?> birthDate = const i0.Value.absent()}) =>
      i1.BaseSettingsUser(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        primaryEmail:
            primaryEmail.present ? primaryEmail.value : this.primaryEmail,
        phone: phone.present ? phone.value : this.phone,
        mobilePhone: mobilePhone.present ? mobilePhone.value : this.mobilePhone,
        birthDate: birthDate.present ? birthDate.value : this.birthDate,
      );
  BaseSettingsUser copyWithCompanion(i1.BaseSettingsUserTableCompanion data) {
    return BaseSettingsUser(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      primaryEmail: data.primaryEmail.present
          ? data.primaryEmail.value
          : this.primaryEmail,
      phone: data.phone.present ? data.phone.value : this.phone,
      mobilePhone:
          data.mobilePhone.present ? data.mobilePhone.value : this.mobilePhone,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BaseSettingsUser(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('primaryEmail: $primaryEmail, ')
          ..write('phone: $phone, ')
          ..write('mobilePhone: $mobilePhone, ')
          ..write('birthDate: $birthDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, firstName, lastName, primaryEmail, phone, mobilePhone, birthDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.BaseSettingsUser &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.primaryEmail == this.primaryEmail &&
          other.phone == this.phone &&
          other.mobilePhone == this.mobilePhone &&
          other.birthDate == this.birthDate);
}

class BaseSettingsUserTableCompanion
    extends i0.UpdateCompanion<i1.BaseSettingsUser> {
  final i0.Value<String> id;
  final i0.Value<String> firstName;
  final i0.Value<String> lastName;
  final i0.Value<String?> primaryEmail;
  final i0.Value<String?> phone;
  final i0.Value<String?> mobilePhone;
  final i0.Value<DateTime?> birthDate;
  final i0.Value<int> rowid;
  const BaseSettingsUserTableCompanion({
    this.id = const i0.Value.absent(),
    this.firstName = const i0.Value.absent(),
    this.lastName = const i0.Value.absent(),
    this.primaryEmail = const i0.Value.absent(),
    this.phone = const i0.Value.absent(),
    this.mobilePhone = const i0.Value.absent(),
    this.birthDate = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  BaseSettingsUserTableCompanion.insert({
    required String id,
    required String firstName,
    required String lastName,
    this.primaryEmail = const i0.Value.absent(),
    this.phone = const i0.Value.absent(),
    this.mobilePhone = const i0.Value.absent(),
    this.birthDate = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  })  : id = i0.Value(id),
        firstName = i0.Value(firstName),
        lastName = i0.Value(lastName);
  static i0.Insertable<i1.BaseSettingsUser> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? firstName,
    i0.Expression<String>? lastName,
    i0.Expression<String>? primaryEmail,
    i0.Expression<String>? phone,
    i0.Expression<String>? mobilePhone,
    i0.Expression<DateTime>? birthDate,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (primaryEmail != null) 'primary_email': primaryEmail,
      if (phone != null) 'phone': phone,
      if (mobilePhone != null) 'mobile_phone': mobilePhone,
      if (birthDate != null) 'birth_date': birthDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.BaseSettingsUserTableCompanion copyWith(
      {i0.Value<String>? id,
      i0.Value<String>? firstName,
      i0.Value<String>? lastName,
      i0.Value<String?>? primaryEmail,
      i0.Value<String?>? phone,
      i0.Value<String?>? mobilePhone,
      i0.Value<DateTime?>? birthDate,
      i0.Value<int>? rowid}) {
    return i1.BaseSettingsUserTableCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      primaryEmail: primaryEmail ?? this.primaryEmail,
      phone: phone ?? this.phone,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      birthDate: birthDate ?? this.birthDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<String>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = i0.Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = i0.Variable<String>(lastName.value);
    }
    if (primaryEmail.present) {
      map['primary_email'] = i0.Variable<String>(primaryEmail.value);
    }
    if (phone.present) {
      map['phone'] = i0.Variable<String>(phone.value);
    }
    if (mobilePhone.present) {
      map['mobile_phone'] = i0.Variable<String>(mobilePhone.value);
    }
    if (birthDate.present) {
      map['birth_date'] = i0.Variable<DateTime>(birthDate.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BaseSettingsUserTableCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('primaryEmail: $primaryEmail, ')
          ..write('phone: $phone, ')
          ..write('mobilePhone: $mobilePhone, ')
          ..write('birthDate: $birthDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}
