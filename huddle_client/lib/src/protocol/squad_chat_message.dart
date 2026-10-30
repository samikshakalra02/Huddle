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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class SquadChatMessage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int squadId;

  String userName;

  String message;

  DateTime sentAt;

  /// Returns a shallow copy of this [SquadChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
