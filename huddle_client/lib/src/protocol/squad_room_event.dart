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
import 'package:huddle_client/src/protocol/protocol.dart' as _ik53ze0v;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'squad.dart' as _i1svoism;
import 'squad_member.dart' as _il862mk4;

abstract class SquadRoomEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SquadRoomEvent._({
    this.squadId,
    required this.type,
    this.userName,
    this.message,
    this.squad,
    this.members,
    required this.timestamp,
  });

  factory SquadRoomEvent({
    int? squadId,
    required String type,
    String? userName,
    String? message,
    _i1svoism.Squad? squad,
    List<_il862mk4.SquadMember>? members,
    required DateTime timestamp,
  }) = _SquadRoomEventImpl;

  factory SquadRoomEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return SquadRoomEvent(
      squadId: jsonSerialization['squadId'] as int?,
      type: jsonSerialization['type'] as String,
      userName: jsonSerialization['userName'] as String?,
      message: jsonSerialization['message'] as String?,
      squad: jsonSerialization['squad'] == null
          ? null
          : _ik53ze0v.Protocol().deserialize<_i1svoism.Squad>(
              jsonSerialization['squad'],
            ),
      members: jsonSerialization['members'] == null
          ? null
          : _ik53ze0v.Protocol().deserialize<List<_il862mk4.SquadMember>>(
              jsonSerialization['members'],
            ),
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  int? squadId;

  String type;

  String? userName;

  String? message;

  _i1svoism.Squad? squad;

  List<_il862mk4.SquadMember>? members;

  DateTime timestamp;

  /// Returns a shallow copy of this [SquadRoomEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SquadRoomEvent copyWith({
    int? squadId,
    String? type,
    String? userName,
    String? message,
    _i1svoism.Squad? squad,
    List<_il862mk4.SquadMember>? members,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SquadRoomEvent',
      if (squadId != null) 'squadId': squadId,
      'type': type,
      if (userName != null) 'userName': userName,
      if (message != null) 'message': message,
      if (squad != null) 'squad': squad?.toJson(),
      if (members != null)
        'members': members?.toJson(valueToJson: (v) => v.toJson()),
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SquadRoomEvent',
      if (squadId != null) 'squadId': squadId,
      'type': type,
      if (userName != null) 'userName': userName,
      if (message != null) 'message': message,
      if (squad != null) 'squad': squad?.toJsonForProtocol(),
      if (members != null)
        'members': members?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SquadRoomEventImpl extends SquadRoomEvent {
  _SquadRoomEventImpl({
    int? squadId,
    required String type,
    String? userName,
    String? message,
    _i1svoism.Squad? squad,
    List<_il862mk4.SquadMember>? members,
    required DateTime timestamp,
  }) : super._(
         squadId: squadId,
         type: type,
         userName: userName,
         message: message,
         squad: squad,
         members: members,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [SquadRoomEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SquadRoomEvent copyWith({
    Object? squadId = _Undefined,
    String? type,
    Object? userName = _Undefined,
    Object? message = _Undefined,
    Object? squad = _Undefined,
    Object? members = _Undefined,
    DateTime? timestamp,
  }) {
    return SquadRoomEvent(
      squadId: squadId is int? ? squadId : this.squadId,
      type: type ?? this.type,
      userName: userName is String? ? userName : this.userName,
      message: message is String? ? message : this.message,
      squad: squad is _i1svoism.Squad? ? squad : this.squad?.copyWith(),
      members: members is List<_il862mk4.SquadMember>?
          ? members
          : this.members?.map((e0) => e0.copyWith()).toList(),
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
