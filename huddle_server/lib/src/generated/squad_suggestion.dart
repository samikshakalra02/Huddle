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

abstract class SquadSuggestion
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SquadSuggestion._({
    required this.squad,
    required this.matchScore,
    required this.matchReason,
    required this.memberCount,
  });

  factory SquadSuggestion({
    required _i1svoism.Squad squad,
    required int matchScore,
    required String matchReason,
    required int memberCount,
  }) = _SquadSuggestionImpl;

  factory SquadSuggestion.fromJson(Map<String, dynamic> jsonSerialization) {
    return SquadSuggestion(
      squad: _i8h64kwd.Protocol().deserialize<_i1svoism.Squad>(
        jsonSerialization['squad'],
      ),
      matchScore: jsonSerialization['matchScore'] as int,
      matchReason: jsonSerialization['matchReason'] as String,
      memberCount: jsonSerialization['memberCount'] as int,
    );
  }

  _i1svoism.Squad squad;

  int matchScore;

  String matchReason;

  int memberCount;

  /// Returns a shallow copy of this [SquadSuggestion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SquadSuggestion copyWith({
    _i1svoism.Squad? squad,
    int? matchScore,
    String? matchReason,
    int? memberCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SquadSuggestion',
      'squad': squad.toJson(),
      'matchScore': matchScore,
      'matchReason': matchReason,
      'memberCount': memberCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SquadSuggestion',
      'squad': squad.toJsonForProtocol(),
      'matchScore': matchScore,
      'matchReason': matchReason,
      'memberCount': memberCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SquadSuggestionImpl extends SquadSuggestion {
  _SquadSuggestionImpl({
    required _i1svoism.Squad squad,
    required int matchScore,
    required String matchReason,
    required int memberCount,
  }) : super._(
         squad: squad,
         matchScore: matchScore,
         matchReason: matchReason,
         memberCount: memberCount,
       );

  /// Returns a shallow copy of this [SquadSuggestion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SquadSuggestion copyWith({
    _i1svoism.Squad? squad,
    int? matchScore,
    String? matchReason,
    int? memberCount,
  }) {
    return SquadSuggestion(
      squad: squad ?? this.squad.copyWith(),
      matchScore: matchScore ?? this.matchScore,
      matchReason: matchReason ?? this.matchReason,
      memberCount: memberCount ?? this.memberCount,
    );
  }
}
