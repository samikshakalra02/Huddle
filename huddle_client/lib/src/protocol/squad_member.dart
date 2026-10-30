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

abstract class SquadMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isFocusing']),
      karma: (jsonSerialization['karma'] as num?)?.toDouble(),
      joinedAt: jsonSerialization['joinedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int squadId;

  String userName;

  String? avatarUrl;

  bool isFocusing;

  double karma;

  DateTime joinedAt;

  /// Returns a shallow copy of this [SquadMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
