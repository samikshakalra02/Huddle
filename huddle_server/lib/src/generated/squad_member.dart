/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

abstract class SquadMember
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SquadMember._({
    this.id,
    required this.squadId,
    required this.userName,
    this.avatarUrl,
    bool? isFocusing,
    double? karma,
    DateTime? joinedAt,
  }) : isFocusing = isFocusing ?? true,
       karma = karma ?? 4.8,
       joinedAt = joinedAt ?? DateTime.now();

  factory SquadMember({
    int? id,
    required int squadId,
    required String userName,
    String? avatarUrl,
    bool? isFocusing,
    double? karma,
    DateTime? joinedAt,
  }) = _SquadMemberImpl;

  factory SquadMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return SquadMember(
      id: jsonSerialization['id'] as int?,
      squadId: jsonSerialization['squadId'] as int,
      userName: jsonSerialization['userName'] as String,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      isFocusing: jsonSerialization['isFocusing'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isFocusing']),
      karma: (jsonSerialization['karma'] as num?)?.toDouble(),
      joinedAt: jsonSerialization['joinedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  static final t = SquadMemberTable();

  static const db = SquadMemberRepository._();

  @override
  int? id;

  int squadId;

  String userName;

  String? avatarUrl;

  bool isFocusing;

  double karma;

  DateTime joinedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SquadMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SquadMember copyWith({
    int? id,
    int? squadId,
    String? userName,
    String? avatarUrl,
    bool? isFocusing,
    double? karma,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SquadMember',
      if (id != null) 'id': id,
      'squadId': squadId,
      'userName': userName,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'isFocusing': isFocusing,
      'karma': karma,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SquadMember',
      if (id != null) 'id': id,
      'squadId': squadId,
      'userName': userName,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'isFocusing': isFocusing,
      'karma': karma,
      'joinedAt': joinedAt.toJson(),
    };
  }

  static SquadMemberInclude include() {
    return SquadMemberInclude._();
  }

  static SquadMemberIncludeList includeList({
    _is.WhereExpressionBuilder<SquadMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SquadMemberTable>? orderBy,
    _is.OrderByListBuilder<SquadMemberTable>? orderByList,
    SquadMemberInclude? include,
  }) {
    return SquadMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SquadMember.t),
      orderByList: orderByList?.call(SquadMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SquadMemberImpl extends SquadMember {
  _SquadMemberImpl({
    int? id,
    required int squadId,
    required String userName,
    String? avatarUrl,
    bool? isFocusing,
    double? karma,
    DateTime? joinedAt,
  }) : super._(
         id: id,
         squadId: squadId,
         userName: userName,
         avatarUrl: avatarUrl,
         isFocusing: isFocusing,
         karma: karma,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [SquadMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SquadMember copyWith({
    Object? id = _Undefined,
    int? squadId,
    String? userName,
    Object? avatarUrl = _Undefined,
    bool? isFocusing,
    double? karma,
    DateTime? joinedAt,
  }) {
    return SquadMember(
      id: id is int? ? id : this.id,
      squadId: squadId ?? this.squadId,
      userName: userName ?? this.userName,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      isFocusing: isFocusing ?? this.isFocusing,
      karma: karma ?? this.karma,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}

class SquadMemberUpdateTable extends _is.UpdateTable<SquadMemberTable> {
  SquadMemberUpdateTable(super.table);

  _is.ColumnValue<int, int> squadId(int value) => _is.ColumnValue(
    table.squadId,
    value,
  );

  _is.ColumnValue<String, String> userName(String value) => _is.ColumnValue(
    table.userName,
    value,
  );

  _is.ColumnValue<String, String> avatarUrl(String? value) => _is.ColumnValue(
    table.avatarUrl,
    value,
  );

  _is.ColumnValue<bool, bool> isFocusing(bool value) => _is.ColumnValue(
    table.isFocusing,
    value,
  );

  _is.ColumnValue<double, double> karma(double value) => _is.ColumnValue(
    table.karma,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _is.ColumnValue(
        table.joinedAt,
        value,
      );
}

class SquadMemberTable extends _is.Table<int?> {
  SquadMemberTable({super.tableRelation}) : super(tableName: 'squad_member') {
    updateTable = SquadMemberUpdateTable(this);
    squadId = _is.ColumnInt(
      'squadId',
      this,
    );
    userName = _is.ColumnString(
      'userName',
      this,
    );
    avatarUrl = _is.ColumnString(
      'avatarUrl',
      this,
    );
    isFocusing = _is.ColumnBool(
      'isFocusing',
      this,
      hasDefault: true,
    );
    karma = _is.ColumnDouble(
      'karma',
      this,
      hasDefault: true,
    );
    joinedAt = _is.ColumnDateTime(
      'joinedAt',
      this,
      hasDefault: true,
    );
  }

  late final SquadMemberUpdateTable updateTable;

  late final _is.ColumnInt squadId;

  late final _is.ColumnString userName;

  late final _is.ColumnString avatarUrl;

  late final _is.ColumnBool isFocusing;

  late final _is.ColumnDouble karma;

  late final _is.ColumnDateTime joinedAt;

  @override
  List<_is.Column> get columns => [
    id,
    squadId,
    userName,
    avatarUrl,
    isFocusing,
    karma,
    joinedAt,
  ];
}

class SquadMemberInclude extends _is.IncludeObject {
  SquadMemberInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SquadMember.t;
}

class SquadMemberIncludeList extends _is.IncludeList {
  SquadMemberIncludeList._({
    _is.WhereExpressionBuilder<SquadMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SquadMember.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SquadMember.t;
}

class SquadMemberRepository {
  const SquadMemberRepository._();

  /// Returns a list of [SquadMember]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<SquadMember>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SquadMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SquadMemberTable>? orderBy,
    _is.OrderByListBuilder<SquadMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SquadMember>(
      where: where?.call(SquadMember.t),
      orderBy: orderBy?.call(SquadMember.t),
      orderByList: orderByList?.call(SquadMember.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SquadMember] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<SquadMember?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SquadMemberTable>? where,
    int? offset,
    _is.OrderByBuilder<SquadMemberTable>? orderBy,
    _is.OrderByListBuilder<SquadMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SquadMember>(
      where: where?.call(SquadMember.t),
      orderBy: orderBy?.call(SquadMember.t),
      orderByList: orderByList?.call(SquadMember.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SquadMember] by its [id] or null if no such row exists.
  Future<SquadMember?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SquadMember>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SquadMember]s in the list and returns the inserted rows.
  ///
  /// The returned [SquadMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SquadMember>> insert(
    _is.DatabaseSession session,
    List<SquadMember> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SquadMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SquadMember] and returns the inserted row.
  ///
  /// The returned [SquadMember] will have its `id` field set.
  Future<SquadMember> insertRow(
    _is.DatabaseSession session,
    SquadMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SquadMember>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SquadMember]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [SquadMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SquadMember>> upsert(
    _is.DatabaseSession session,
    List<SquadMember> rows, {
    required _is.ColumnSelections<SquadMemberTable> conflictColumns,
    _is.ColumnSelections<SquadMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<SquadMemberTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SquadMember>(
      rows,
      conflictColumns: conflictColumns(SquadMember.t),
      updateColumns: updateColumns?.call(SquadMember.t),
      updateWhere: updateWhere?.call(SquadMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SquadMember] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [SquadMember] will have its `id` field set.
  Future<SquadMember?> upsertRow(
    _is.DatabaseSession session,
    SquadMember row, {
    required _is.ColumnSelections<SquadMemberTable> conflictColumns,
    _is.ColumnSelections<SquadMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<SquadMemberTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SquadMember>(
      row,
      conflictColumns: conflictColumns(SquadMember.t),
      updateColumns: updateColumns?.call(SquadMember.t),
      updateWhere: updateWhere?.call(SquadMember.t),
      transaction: transaction,
    );
  }

  /// Updates all [SquadMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SquadMember>> update(
    _is.DatabaseSession session,
    List<SquadMember> rows, {
    _is.ColumnSelections<SquadMemberTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SquadMember>(
      rows,
      columns: columns?.call(SquadMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SquadMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SquadMember> updateRow(
    _is.DatabaseSession session,
    SquadMember row, {
    _is.ColumnSelections<SquadMemberTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SquadMember>(
      row,
      columns: columns?.call(SquadMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SquadMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SquadMember?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SquadMemberUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SquadMember>(
      id,
      columnValues: columnValues(SquadMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SquadMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SquadMember>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SquadMemberUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SquadMemberTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SquadMemberTable>? orderBy,
    _is.OrderByListBuilder<SquadMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SquadMember>(
      columnValues: columnValues(SquadMember.t.updateTable),
      where: where(SquadMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SquadMember.t),
      orderByList: orderByList?.call(SquadMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SquadMember]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SquadMember>> delete(
    _is.DatabaseSession session,
    List<SquadMember> rows, {
    _is.OrderByBuilder<SquadMemberTable>? orderBy,
    _is.OrderByListBuilder<SquadMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SquadMember>(
      rows,
      orderBy: orderBy?.call(SquadMember.t),
      orderByList: orderByList?.call(SquadMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SquadMember].
  Future<SquadMember> deleteRow(
    _is.DatabaseSession session,
    SquadMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SquadMember>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SquadMember>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SquadMemberTable> where,
    _is.OrderByBuilder<SquadMemberTable>? orderBy,
    _is.OrderByListBuilder<SquadMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SquadMember>(
      where: where(SquadMember.t),
      orderBy: orderBy?.call(SquadMember.t),
      orderByList: orderByList?.call(SquadMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SquadMemberTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SquadMember>(
      where: where?.call(SquadMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SquadMember] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SquadMemberTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SquadMember>(
      where: where(SquadMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
