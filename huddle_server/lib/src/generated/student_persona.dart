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
import 'karma_activity.dart' as _i7i1375o;
import 'peer_endorsement.dart' as _i9iommci;
import 'student_badge.dart' as _ih1itj7p;

abstract class StudentPersona
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StudentPersona._({
    required this.name,
    required this.handle,
    required this.major,
    required this.year,
    required this.campus,
    required this.bio,
    required this.studyVibe,
    required this.currentGoal,
    required this.karmaScore,
    required this.karmaRank,
    required this.streakDays,
    required this.focusHours,
    required this.quizzesAced,
    required this.squadsJoined,
    required this.peerEndorsementsCount,
    required this.activeSquadName,
    required this.badges,
    required this.recentActivity,
    required this.endorsements,
  });

  factory StudentPersona({
    required String name,
    required String handle,
    required String major,
    required String year,
    required String campus,
    required String bio,
    required String studyVibe,
    required String currentGoal,
    required double karmaScore,
    required String karmaRank,
    required int streakDays,
    required double focusHours,
    required int quizzesAced,
    required int squadsJoined,
    required int peerEndorsementsCount,
    required String activeSquadName,
    required List<_ih1itj7p.StudentBadge> badges,
    required List<_i7i1375o.KarmaActivity> recentActivity,
    required List<_i9iommci.PeerEndorsement> endorsements,
  }) = _StudentPersonaImpl;

  factory StudentPersona.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentPersona(
      name: jsonSerialization['name'] as String,
      handle: jsonSerialization['handle'] as String,
      major: jsonSerialization['major'] as String,
      year: jsonSerialization['year'] as String,
      campus: jsonSerialization['campus'] as String,
      bio: jsonSerialization['bio'] as String,
      studyVibe: jsonSerialization['studyVibe'] as String,
      currentGoal: jsonSerialization['currentGoal'] as String,
      karmaScore: (jsonSerialization['karmaScore'] as num).toDouble(),
      karmaRank: jsonSerialization['karmaRank'] as String,
      streakDays: jsonSerialization['streakDays'] as int,
      focusHours: (jsonSerialization['focusHours'] as num).toDouble(),
      quizzesAced: jsonSerialization['quizzesAced'] as int,
      squadsJoined: jsonSerialization['squadsJoined'] as int,
      peerEndorsementsCount: jsonSerialization['peerEndorsementsCount'] as int,
      activeSquadName: jsonSerialization['activeSquadName'] as String,
      badges: _i8h64kwd.Protocol().deserialize<List<_ih1itj7p.StudentBadge>>(
        jsonSerialization['badges'],
      ),
      recentActivity: _i8h64kwd.Protocol()
          .deserialize<List<_i7i1375o.KarmaActivity>>(
            jsonSerialization['recentActivity'],
          ),
      endorsements: _i8h64kwd.Protocol()
          .deserialize<List<_i9iommci.PeerEndorsement>>(
            jsonSerialization['endorsements'],
          ),
    );
  }

  String name;

  String handle;

  String major;

  String year;

  String campus;

  String bio;

  String studyVibe;

  String currentGoal;

  double karmaScore;

  String karmaRank;

  int streakDays;

  double focusHours;

  int quizzesAced;

  int squadsJoined;

  int peerEndorsementsCount;

  String activeSquadName;

  List<_ih1itj7p.StudentBadge> badges;

  List<_i7i1375o.KarmaActivity> recentActivity;

  List<_i9iommci.PeerEndorsement> endorsements;

  /// Returns a shallow copy of this [StudentPersona]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StudentPersona copyWith({
    String? name,
    String? handle,
    String? major,
    String? year,
    String? campus,
    String? bio,
    String? studyVibe,
    String? currentGoal,
    double? karmaScore,
    String? karmaRank,
    int? streakDays,
    double? focusHours,
    int? quizzesAced,
    int? squadsJoined,
    int? peerEndorsementsCount,
    String? activeSquadName,
    List<_ih1itj7p.StudentBadge>? badges,
    List<_i7i1375o.KarmaActivity>? recentActivity,
    List<_i9iommci.PeerEndorsement>? endorsements,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentPersona',
      'name': name,
      'handle': handle,
      'major': major,
      'year': year,
      'campus': campus,
      'bio': bio,
      'studyVibe': studyVibe,
      'currentGoal': currentGoal,
      'karmaScore': karmaScore,
      'karmaRank': karmaRank,
      'streakDays': streakDays,
      'focusHours': focusHours,
      'quizzesAced': quizzesAced,
      'squadsJoined': squadsJoined,
      'peerEndorsementsCount': peerEndorsementsCount,
      'activeSquadName': activeSquadName,
      'badges': badges.toJson(valueToJson: (v) => v.toJson()),
      'recentActivity': recentActivity.toJson(valueToJson: (v) => v.toJson()),
      'endorsements': endorsements.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentPersona',
      'name': name,
      'handle': handle,
      'major': major,
      'year': year,
      'campus': campus,
      'bio': bio,
      'studyVibe': studyVibe,
      'currentGoal': currentGoal,
      'karmaScore': karmaScore,
      'karmaRank': karmaRank,
      'streakDays': streakDays,
      'focusHours': focusHours,
      'quizzesAced': quizzesAced,
      'squadsJoined': squadsJoined,
      'peerEndorsementsCount': peerEndorsementsCount,
      'activeSquadName': activeSquadName,
      'badges': badges.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'recentActivity': recentActivity.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'endorsements': endorsements.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _StudentPersonaImpl extends StudentPersona {
  _StudentPersonaImpl({
    required String name,
    required String handle,
    required String major,
    required String year,
    required String campus,
    required String bio,
    required String studyVibe,
    required String currentGoal,
    required double karmaScore,
    required String karmaRank,
    required int streakDays,
    required double focusHours,
    required int quizzesAced,
    required int squadsJoined,
    required int peerEndorsementsCount,
    required String activeSquadName,
    required List<_ih1itj7p.StudentBadge> badges,
    required List<_i7i1375o.KarmaActivity> recentActivity,
    required List<_i9iommci.PeerEndorsement> endorsements,
  }) : super._(
         name: name,
         handle: handle,
         major: major,
         year: year,
         campus: campus,
         bio: bio,
         studyVibe: studyVibe,
         currentGoal: currentGoal,
         karmaScore: karmaScore,
         karmaRank: karmaRank,
         streakDays: streakDays,
         focusHours: focusHours,
         quizzesAced: quizzesAced,
         squadsJoined: squadsJoined,
         peerEndorsementsCount: peerEndorsementsCount,
         activeSquadName: activeSquadName,
         badges: badges,
         recentActivity: recentActivity,
         endorsements: endorsements,
       );

  /// Returns a shallow copy of this [StudentPersona]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StudentPersona copyWith({
    String? name,
    String? handle,
    String? major,
    String? year,
    String? campus,
    String? bio,
    String? studyVibe,
    String? currentGoal,
    double? karmaScore,
    String? karmaRank,
    int? streakDays,
    double? focusHours,
    int? quizzesAced,
    int? squadsJoined,
    int? peerEndorsementsCount,
    String? activeSquadName,
    List<_ih1itj7p.StudentBadge>? badges,
    List<_i7i1375o.KarmaActivity>? recentActivity,
    List<_i9iommci.PeerEndorsement>? endorsements,
  }) {
    return StudentPersona(
      name: name ?? this.name,
      handle: handle ?? this.handle,
      major: major ?? this.major,
      year: year ?? this.year,
      campus: campus ?? this.campus,
      bio: bio ?? this.bio,
      studyVibe: studyVibe ?? this.studyVibe,
      currentGoal: currentGoal ?? this.currentGoal,
      karmaScore: karmaScore ?? this.karmaScore,
      karmaRank: karmaRank ?? this.karmaRank,
      streakDays: streakDays ?? this.streakDays,
      focusHours: focusHours ?? this.focusHours,
      quizzesAced: quizzesAced ?? this.quizzesAced,
      squadsJoined: squadsJoined ?? this.squadsJoined,
      peerEndorsementsCount:
          peerEndorsementsCount ?? this.peerEndorsementsCount,
      activeSquadName: activeSquadName ?? this.activeSquadName,
      badges: badges ?? this.badges.map((e0) => e0.copyWith()).toList(),
      recentActivity:
          recentActivity ??
          this.recentActivity.map((e0) => e0.copyWith()).toList(),
      endorsements:
          endorsements ?? this.endorsements.map((e0) => e0.copyWith()).toList(),
    );
  }
}
