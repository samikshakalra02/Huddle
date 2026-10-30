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
import 'package:huddle_server/src/generated/protocol.dart' as _i8h64kwd;
import 'package:serverpod/serverpod.dart' as _is;
import 'squad.dart' as _i1svoism;
import 'squad_chat_message.dart' as _ijharqf9;
import 'squad_member.dart' as _il862mk4;

abstract class SquadDetails
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SquadDetails._({
    required this.squad,
    required this.members,
    this.recentMessages,
  });

  factory SquadDetails({
    required _i1svoism.Squad squad,
    required List<_il862mk4.SquadMember> members,
    List<_ijharqf9.SquadChatMessage>? recentMessages,
  }) = _SquadDetailsImpl;

  factory SquadDetails.fromJson(Map<String, dynamic> jsonSerialization) {
    return SquadDetails(
      squad: _i8h64kwd.Protocol().deserialize<_i1svoism.Squad>(
        jsonSerialization['squad'],
      ),
      members: _i8h64kwd.Protocol().deserialize<List<_il862mk4.SquadMember>>(
        jsonSerialization['members'],
      ),
      recentMessages: jsonSerialization['recentMessages'] == null
          ? null
          : _i8h64kwd.Protocol().deserialize<List<_ijharqf9.SquadChatMessage>>(
              jsonSerialization['recentMessages'],
            ),
    );
  }

  _i1svoism.Squad squad;

  List<_il862mk4.SquadMember> members;

  List<_ijharqf9.SquadChatMessage>? recentMessages;

  /// Returns a shallow copy of this [SquadDetails]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SquadDetails copyWith({
    _i1svoism.Squad? squad,
    List<_il862mk4.SquadMember>? members,
    List<_ijharqf9.SquadChatMessage>? recentMessages,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SquadDetails',
      'squad': squad.toJson(),
      'members': members.toJson(valueToJson: (v) => v.toJson()),
      if (recentMessages != null)
        'recentMessages': recentMessages?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SquadDetails',
      'squad': squad.toJsonForProtocol(),
      'members': members.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (recentMessages != null)
        'recentMessages': recentMessages?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SquadDetailsImpl extends SquadDetails {
  _SquadDetailsImpl({
    required _i1svoism.Squad squad,
    required List<_il862mk4.SquadMember> members,
    List<_ijharqf9.SquadChatMessage>? recentMessages,
  }) : super._(
         squad: squad,
         members: members,
         recentMessages: recentMessages,
       );

  /// Returns a shallow copy of this [SquadDetails]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SquadDetails copyWith({
    _i1svoism.Squad? squad,
    List<_il862mk4.SquadMember>? members,
    Object? recentMessages = _Undefined,
  }) {
    return SquadDetails(
      squad: squad ?? this.squad.copyWith(),
      members: members ?? this.members.map((e0) => e0.copyWith()).toList(),
      recentMessages: recentMessages is List<_ijharqf9.SquadChatMessage>?
          ? recentMessages
          : this.recentMessages?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
