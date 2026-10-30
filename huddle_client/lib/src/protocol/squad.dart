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

abstract class Squad
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['timerStartedAt'],
            ),
      timerDurationSeconds: jsonSerialization['timerDurationSeconds'] as int?,
      isFocusing: jsonSerialization['isFocusing'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isFocusing']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [Squad]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
