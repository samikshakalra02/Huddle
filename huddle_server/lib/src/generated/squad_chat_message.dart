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

abstract class SquadChatMessage
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SquadChatMessage._({
    this.id,
    required this.squadId,
    required this.userName,
    required this.message,
    DateTime? sentAt,
  }) : sentAt = sentAt ?? DateTime.now();

  factory SquadChatMessage({
    int? id,
    required int squadId,
    required String userName,
    required String message,
    DateTime? sentAt,
  }) = _SquadChatMessageImpl;

  factory SquadChatMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return SquadChatMessage(
      id: jsonSerialization['id'] as int?,
      squadId: jsonSerialization['squadId'] as int,
      userName: jsonSerialization['userName'] as String,
      message: jsonSerialization['message'] as String,
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
    );
  }

  static final t = SquadChatMessageTable();

  static const db = SquadChatMessageRepository._();

  @override
  int? id;

  int squadId;

  String userName;

  String message;

  DateTime sentAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SquadChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SquadChatMessage copyWith({
    int? id,
    int? squadId,
    String? userName,
    String? message,
    DateTime? sentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SquadChatMessage',
      if (id != null) 'id': id,
      'squadId': squadId,
      'userName': userName,
      'message': message,
      'sentAt': sentAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SquadChatMessage',
      if (id != null) 'id': id,
      'squadId': squadId,
      'userName': userName,
      'message': message,
      'sentAt': sentAt.toJson(),
    };
  }

  static SquadChatMessageInclude include() {
    return SquadChatMessageInclude._();
  }

  static SquadChatMessageIncludeList includeList({
    _is.WhereExpressionBuilder<SquadChatMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SquadChatMessageTable>? orderBy,
    _is.OrderByListBuilder<SquadChatMessageTable>? orderByList,
    SquadChatMessageInclude? include,
  }) {
    return SquadChatMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SquadChatMessage.t),
      orderByList: orderByList?.call(SquadChatMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SquadChatMessageImpl extends SquadChatMessage {
  _SquadChatMessageImpl({
    int? id,
    required int squadId,
    required String userName,
    required String message,
    DateTime? sentAt,
  }) : super._(
         id: id,
         squadId: squadId,
         userName: userName,
         message: message,
         sentAt: sentAt,
       );

  /// Returns a shallow copy of this [SquadChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SquadChatMessage copyWith({
    Object? id = _Undefined,
    int? squadId,
    String? userName,
    String? message,
    DateTime? sentAt,
  }) {
    return SquadChatMessage(
      id: id is int? ? id : this.id,
      squadId: squadId ?? this.squadId,
      userName: userName ?? this.userName,
      message: message ?? this.message,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}

class SquadChatMessageUpdateTable
    extends _is.UpdateTable<SquadChatMessageTable> {
  SquadChatMessageUpdateTable(super.table);

  _is.ColumnValue<int, int> squadId(int value) => _is.ColumnValue(
    table.squadId,
    value,
  );

  _is.ColumnValue<String, String> userName(String value) => _is.ColumnValue(
    table.userName,
    value,
  );

  _is.ColumnValue<String, String> message(String value) => _is.ColumnValue(
    table.message,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> sentAt(DateTime value) => _is.ColumnValue(
    table.sentAt,
    value,
  );
}

class SquadChatMessageTable extends _is.Table<int?> {
  SquadChatMessageTable({super.tableRelation})
    : super(tableName: 'squad_chat_message') {
    updateTable = SquadChatMessageUpdateTable(this);
    squadId = _is.ColumnInt(
      'squadId',
      this,
    );
    userName = _is.ColumnString(
      'userName',
      this,
    );
    message = _is.ColumnString(
      'message',
      this,
    );
    sentAt = _is.ColumnDateTime(
      'sentAt',
      this,
      hasDefault: true,
    );
  }

  late final SquadChatMessageUpdateTable updateTable;

  late final _is.ColumnInt squadId;

  late final _is.ColumnString userName;

  late final _is.ColumnString message;

  late final _is.ColumnDateTime sentAt;

  @override
  List<_is.Column> get columns => [
    id,
    squadId,
    userName,
    message,
    sentAt,
  ];
}

class SquadChatMessageInclude extends _is.IncludeObject {
  SquadChatMessageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SquadChatMessage.t;
}

class SquadChatMessageIncludeList extends _is.IncludeList {
  SquadChatMessageIncludeList._({
    _is.WhereExpressionBuilder<SquadChatMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SquadChatMessage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SquadChatMessage.t;
}

class SquadChatMessageRepository {
  const SquadChatMessageRepository._();

  /// Returns a list of [SquadChatMessage]s matching the given query parameters.
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
  Future<List<SquadChatMessage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SquadChatMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SquadChatMessageTable>? orderBy,
    _is.OrderByListBuilder<SquadChatMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SquadChatMessage>(
      where: where?.call(SquadChatMessage.t),
      orderBy: orderBy?.call(SquadChatMessage.t),
      orderByList: orderByList?.call(SquadChatMessage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SquadChatMessage] matching the given query parameters.
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
  Future<SquadChatMessage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SquadChatMessageTable>? where,
    int? offset,
    _is.OrderByBuilder<SquadChatMessageTable>? orderBy,
    _is.OrderByListBuilder<SquadChatMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SquadChatMessage>(
      where: where?.call(SquadChatMessage.t),
      orderBy: orderBy?.call(SquadChatMessage.t),
      orderByList: orderByList?.call(SquadChatMessage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SquadChatMessage] by its [id] or null if no such row exists.
  Future<SquadChatMessage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SquadChatMessage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SquadChatMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [SquadChatMessage]s will have their `id` fields set.
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
  Future<List<SquadChatMessage>> insert(
    _is.DatabaseSession session,
    List<SquadChatMessage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SquadChatMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SquadChatMessage] and returns the inserted row.
  ///
  /// The returned [SquadChatMessage] will have its `id` field set.
  Future<SquadChatMessage> insertRow(
    _is.DatabaseSession session,
    SquadChatMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SquadChatMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SquadChatMessage]s in the list and returns the resulting rows.
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
  /// The returned [SquadChatMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SquadChatMessage>> upsert(
    _is.DatabaseSession session,
    List<SquadChatMessage> rows, {
    required _is.ColumnSelections<SquadChatMessageTable> conflictColumns,
    _is.ColumnSelections<SquadChatMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<SquadChatMessageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SquadChatMessage>(
      rows,
      conflictColumns: conflictColumns(SquadChatMessage.t),
      updateColumns: updateColumns?.call(SquadChatMessage.t),
      updateWhere: updateWhere?.call(SquadChatMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SquadChatMessage] and returns the resulting row.
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
  /// The returned [SquadChatMessage] will have its `id` field set.
  Future<SquadChatMessage?> upsertRow(
    _is.DatabaseSession session,
    SquadChatMessage row, {
    required _is.ColumnSelections<SquadChatMessageTable> conflictColumns,
    _is.ColumnSelections<SquadChatMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<SquadChatMessageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SquadChatMessage>(
      row,
      conflictColumns: conflictColumns(SquadChatMessage.t),
      updateColumns: updateColumns?.call(SquadChatMessage.t),
      updateWhere: updateWhere?.call(SquadChatMessage.t),
      transaction: transaction,
    );
  }

  /// Updates all [SquadChatMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SquadChatMessage>> update(
    _is.DatabaseSession session,
    List<SquadChatMessage> rows, {
    _is.ColumnSelections<SquadChatMessageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SquadChatMessage>(
      rows,
      columns: columns?.call(SquadChatMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SquadChatMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SquadChatMessage> updateRow(
    _is.DatabaseSession session,
    SquadChatMessage row, {
    _is.ColumnSelections<SquadChatMessageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SquadChatMessage>(
      row,
      columns: columns?.call(SquadChatMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SquadChatMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SquadChatMessage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SquadChatMessageUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SquadChatMessage>(
      id,
      columnValues: columnValues(SquadChatMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SquadChatMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SquadChatMessage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SquadChatMessageUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SquadChatMessageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SquadChatMessageTable>? orderBy,
    _is.OrderByListBuilder<SquadChatMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SquadChatMessage>(
      columnValues: columnValues(SquadChatMessage.t.updateTable),
      where: where(SquadChatMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SquadChatMessage.t),
      orderByList: orderByList?.call(SquadChatMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SquadChatMessage]s in the list and returns the deleted rows.
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
  Future<List<SquadChatMessage>> delete(
    _is.DatabaseSession session,
    List<SquadChatMessage> rows, {
    _is.OrderByBuilder<SquadChatMessageTable>? orderBy,
    _is.OrderByListBuilder<SquadChatMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SquadChatMessage>(
      rows,
      orderBy: orderBy?.call(SquadChatMessage.t),
      orderByList: orderByList?.call(SquadChatMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SquadChatMessage].
  Future<SquadChatMessage> deleteRow(
    _is.DatabaseSession session,
    SquadChatMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SquadChatMessage>(
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
  Future<List<SquadChatMessage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SquadChatMessageTable> where,
    _is.OrderByBuilder<SquadChatMessageTable>? orderBy,
    _is.OrderByListBuilder<SquadChatMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SquadChatMessage>(
      where: where(SquadChatMessage.t),
      orderBy: orderBy?.call(SquadChatMessage.t),
      orderByList: orderByList?.call(SquadChatMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SquadChatMessageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SquadChatMessage>(
      where: where?.call(SquadChatMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SquadChatMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SquadChatMessageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SquadChatMessage>(
      where: where(SquadChatMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
