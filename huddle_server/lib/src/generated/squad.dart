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

abstract class Squad implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Squad._({
    this.id,
    required this.name,
    required this.topic,
    required this.targetExam,
    required this.timeSlot,
    int? streak,
    String? goal,
    int? currentGoalCount,
    int? maxMembers,
    this.timerStartedAt,
    int? timerDurationSeconds,
    bool? isFocusing,
  }) : streak = streak ?? 1,
       goal = goal ?? '40 problems',
       currentGoalCount = currentGoalCount ?? 28,
       maxMembers = maxMembers ?? 6,
       timerDurationSeconds = timerDurationSeconds ?? 1500,
       isFocusing = isFocusing ?? false;

  factory Squad({
    int? id,
    required String name,
    required String topic,
    required String targetExam,
    required String timeSlot,
    int? streak,
    String? goal,
    int? currentGoalCount,
    int? maxMembers,
    DateTime? timerStartedAt,
    int? timerDurationSeconds,
    bool? isFocusing,
  }) = _SquadImpl;

  factory Squad.fromJson(Map<String, dynamic> jsonSerialization) {
    return Squad(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      topic: jsonSerialization['topic'] as String,
      targetExam: jsonSerialization['targetExam'] as String,
      timeSlot: jsonSerialization['timeSlot'] as String,
      streak: jsonSerialization['streak'] as int?,
      goal: jsonSerialization['goal'] as String?,
      currentGoalCount: jsonSerialization['currentGoalCount'] as int?,
      maxMembers: jsonSerialization['maxMembers'] as int?,
      timerStartedAt: jsonSerialization['timerStartedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['timerStartedAt'],
            ),
      timerDurationSeconds: jsonSerialization['timerDurationSeconds'] as int?,
      isFocusing: jsonSerialization['isFocusing'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isFocusing']),
    );
  }

  static final t = SquadTable();

  static const db = SquadRepository._();

  @override
  int? id;

  String name;

  String topic;

  String targetExam;

  String timeSlot;

  int streak;

  String goal;

  int currentGoalCount;

  int maxMembers;

  DateTime? timerStartedAt;

  int timerDurationSeconds;

  bool isFocusing;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Squad]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Squad copyWith({
    int? id,
    String? name,
    String? topic,
    String? targetExam,
    String? timeSlot,
    int? streak,
    String? goal,
    int? currentGoalCount,
    int? maxMembers,
    DateTime? timerStartedAt,
    int? timerDurationSeconds,
    bool? isFocusing,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Squad',
      if (id != null) 'id': id,
      'name': name,
      'topic': topic,
      'targetExam': targetExam,
      'timeSlot': timeSlot,
      'streak': streak,
      'goal': goal,
      'currentGoalCount': currentGoalCount,
      'maxMembers': maxMembers,
      if (timerStartedAt != null) 'timerStartedAt': timerStartedAt?.toJson(),
      'timerDurationSeconds': timerDurationSeconds,
      'isFocusing': isFocusing,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Squad',
      if (id != null) 'id': id,
      'name': name,
      'topic': topic,
      'targetExam': targetExam,
      'timeSlot': timeSlot,
      'streak': streak,
      'goal': goal,
      'currentGoalCount': currentGoalCount,
      'maxMembers': maxMembers,
      if (timerStartedAt != null) 'timerStartedAt': timerStartedAt?.toJson(),
      'timerDurationSeconds': timerDurationSeconds,
      'isFocusing': isFocusing,
    };
  }

  static SquadInclude include() {
    return SquadInclude._();
  }

  static SquadIncludeList includeList({
    _is.WhereExpressionBuilder<SquadTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SquadTable>? orderBy,
    _is.OrderByListBuilder<SquadTable>? orderByList,
    SquadInclude? include,
  }) {
    return SquadIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Squad.t),
      orderByList: orderByList?.call(Squad.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SquadImpl extends Squad {
  _SquadImpl({
    int? id,
    required String name,
    required String topic,
    required String targetExam,
    required String timeSlot,
    int? streak,
    String? goal,
    int? currentGoalCount,
    int? maxMembers,
    DateTime? timerStartedAt,
    int? timerDurationSeconds,
    bool? isFocusing,
  }) : super._(
         id: id,
         name: name,
         topic: topic,
         targetExam: targetExam,
         timeSlot: timeSlot,
         streak: streak,
         goal: goal,
         currentGoalCount: currentGoalCount,
         maxMembers: maxMembers,
         timerStartedAt: timerStartedAt,
         timerDurationSeconds: timerDurationSeconds,
         isFocusing: isFocusing,
       );

  /// Returns a shallow copy of this [Squad]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Squad copyWith({
    Object? id = _Undefined,
    String? name,
    String? topic,
    String? targetExam,
    String? timeSlot,
    int? streak,
    String? goal,
    int? currentGoalCount,
    int? maxMembers,
    Object? timerStartedAt = _Undefined,
    int? timerDurationSeconds,
    bool? isFocusing,
  }) {
    return Squad(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      topic: topic ?? this.topic,
      targetExam: targetExam ?? this.targetExam,
      timeSlot: timeSlot ?? this.timeSlot,
      streak: streak ?? this.streak,
      goal: goal ?? this.goal,
      currentGoalCount: currentGoalCount ?? this.currentGoalCount,
      maxMembers: maxMembers ?? this.maxMembers,
      timerStartedAt: timerStartedAt is DateTime?
          ? timerStartedAt
          : this.timerStartedAt,
      timerDurationSeconds: timerDurationSeconds ?? this.timerDurationSeconds,
      isFocusing: isFocusing ?? this.isFocusing,
    );
  }
}

class SquadUpdateTable extends _is.UpdateTable<SquadTable> {
  SquadUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> topic(String value) => _is.ColumnValue(
    table.topic,
    value,
  );

  _is.ColumnValue<String, String> targetExam(String value) => _is.ColumnValue(
    table.targetExam,
    value,
  );

  _is.ColumnValue<String, String> timeSlot(String value) => _is.ColumnValue(
    table.timeSlot,
    value,
  );

  _is.ColumnValue<int, int> streak(int value) => _is.ColumnValue(
    table.streak,
    value,
  );

  _is.ColumnValue<String, String> goal(String value) => _is.ColumnValue(
    table.goal,
    value,
  );

  _is.ColumnValue<int, int> currentGoalCount(int value) => _is.ColumnValue(
    table.currentGoalCount,
    value,
  );

  _is.ColumnValue<int, int> maxMembers(int value) => _is.ColumnValue(
    table.maxMembers,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> timerStartedAt(DateTime? value) =>
      _is.ColumnValue(
        table.timerStartedAt,
        value,
      );

  _is.ColumnValue<int, int> timerDurationSeconds(int value) => _is.ColumnValue(
    table.timerDurationSeconds,
    value,
  );

  _is.ColumnValue<bool, bool> isFocusing(bool value) => _is.ColumnValue(
    table.isFocusing,
    value,
  );
}

class SquadTable extends _is.Table<int?> {
  SquadTable({super.tableRelation}) : super(tableName: 'squad') {
    updateTable = SquadUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    topic = _is.ColumnString(
      'topic',
      this,
    );
    targetExam = _is.ColumnString(
      'targetExam',
      this,
    );
    timeSlot = _is.ColumnString(
      'timeSlot',
      this,
    );
    streak = _is.ColumnInt(
      'streak',
      this,
      hasDefault: true,
    );
    goal = _is.ColumnString(
      'goal',
      this,
      hasDefault: true,
    );
    currentGoalCount = _is.ColumnInt(
      'currentGoalCount',
      this,
      hasDefault: true,
    );
    maxMembers = _is.ColumnInt(
      'maxMembers',
      this,
      hasDefault: true,
    );
    timerStartedAt = _is.ColumnDateTime(
      'timerStartedAt',
      this,
    );
    timerDurationSeconds = _is.ColumnInt(
      'timerDurationSeconds',
      this,
      hasDefault: true,
    );
    isFocusing = _is.ColumnBool(
      'isFocusing',
      this,
      hasDefault: true,
    );
  }

  late final SquadUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString topic;

  late final _is.ColumnString targetExam;

  late final _is.ColumnString timeSlot;

  late final _is.ColumnInt streak;

  late final _is.ColumnString goal;

  late final _is.ColumnInt currentGoalCount;

  late final _is.ColumnInt maxMembers;

  late final _is.ColumnDateTime timerStartedAt;

  late final _is.ColumnInt timerDurationSeconds;

  late final _is.ColumnBool isFocusing;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    topic,
    targetExam,
    timeSlot,
    streak,
    goal,
    currentGoalCount,
    maxMembers,
    timerStartedAt,
    timerDurationSeconds,
    isFocusing,
  ];
}

class SquadInclude extends _is.IncludeObject {
  SquadInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Squad.t;
}

class SquadIncludeList extends _is.IncludeList {
  SquadIncludeList._({
    _is.WhereExpressionBuilder<SquadTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Squad.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Squad.t;
}

class SquadRepository {
  const SquadRepository._();

  /// Returns a list of [Squad]s matching the given query parameters.
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
  Future<List<Squad>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SquadTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SquadTable>? orderBy,
    _is.OrderByListBuilder<SquadTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Squad>(
      where: where?.call(Squad.t),
      orderBy: orderBy?.call(Squad.t),
      orderByList: orderByList?.call(Squad.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Squad] matching the given query parameters.
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
  Future<Squad?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SquadTable>? where,
    int? offset,
    _is.OrderByBuilder<SquadTable>? orderBy,
    _is.OrderByListBuilder<SquadTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Squad>(
      where: where?.call(Squad.t),
      orderBy: orderBy?.call(Squad.t),
      orderByList: orderByList?.call(Squad.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Squad] by its [id] or null if no such row exists.
  Future<Squad?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Squad>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Squad]s in the list and returns the inserted rows.
  ///
  /// The returned [Squad]s will have their `id` fields set.
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
  Future<List<Squad>> insert(
    _is.DatabaseSession session,
    List<Squad> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Squad>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Squad] and returns the inserted row.
  ///
  /// The returned [Squad] will have its `id` field set.
  Future<Squad> insertRow(
    _is.DatabaseSession session,
    Squad row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Squad>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Squad]s in the list and returns the resulting rows.
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
  /// The returned [Squad]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Squad>> upsert(
    _is.DatabaseSession session,
    List<Squad> rows, {
    required _is.ColumnSelections<SquadTable> conflictColumns,
    _is.ColumnSelections<SquadTable>? updateColumns,
    _is.WhereExpressionBuilder<SquadTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Squad>(
      rows,
      conflictColumns: conflictColumns(Squad.t),
      updateColumns: updateColumns?.call(Squad.t),
      updateWhere: updateWhere?.call(Squad.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Squad] and returns the resulting row.
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
  /// The returned [Squad] will have its `id` field set.
  Future<Squad?> upsertRow(
    _is.DatabaseSession session,
    Squad row, {
    required _is.ColumnSelections<SquadTable> conflictColumns,
    _is.ColumnSelections<SquadTable>? updateColumns,
    _is.WhereExpressionBuilder<SquadTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Squad>(
      row,
      conflictColumns: conflictColumns(Squad.t),
      updateColumns: updateColumns?.call(Squad.t),
      updateWhere: updateWhere?.call(Squad.t),
      transaction: transaction,
    );
  }

  /// Updates all [Squad]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Squad>> update(
    _is.DatabaseSession session,
    List<Squad> rows, {
    _is.ColumnSelections<SquadTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Squad>(
      rows,
      columns: columns?.call(Squad.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Squad]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Squad> updateRow(
    _is.DatabaseSession session,
    Squad row, {
    _is.ColumnSelections<SquadTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Squad>(
      row,
      columns: columns?.call(Squad.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Squad] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Squad?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SquadUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Squad>(
      id,
      columnValues: columnValues(Squad.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Squad]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Squad>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SquadUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SquadTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SquadTable>? orderBy,
    _is.OrderByListBuilder<SquadTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Squad>(
      columnValues: columnValues(Squad.t.updateTable),
      where: where(Squad.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Squad.t),
      orderByList: orderByList?.call(Squad.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Squad]s in the list and returns the deleted rows.
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
  Future<List<Squad>> delete(
    _is.DatabaseSession session,
    List<Squad> rows, {
    _is.OrderByBuilder<SquadTable>? orderBy,
    _is.OrderByListBuilder<SquadTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Squad>(
      rows,
      orderBy: orderBy?.call(Squad.t),
      orderByList: orderByList?.call(Squad.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Squad].
  Future<Squad> deleteRow(
    _is.DatabaseSession session,
    Squad row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Squad>(
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
  Future<List<Squad>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SquadTable> where,
    _is.OrderByBuilder<SquadTable>? orderBy,
    _is.OrderByListBuilder<SquadTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Squad>(
      where: where(Squad.t),
      orderBy: orderBy?.call(Squad.t),
      orderByList: orderByList?.call(Squad.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SquadTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Squad>(
      where: where?.call(Squad.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Squad] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SquadTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Squad>(
      where: where(Squad.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
