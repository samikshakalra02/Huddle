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
import 'quiz_question.dart' as _i6b38qpb;

abstract class Reel
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Reel._({
    this.id,
    required this.title,
    required this.creatorName,
    required this.subject,
    required this.videoUrl,
    int? durationSeconds,
    required this.suggestedSquadTopic,
    required this.quizQuestions,
  }) : durationSeconds = durationSeconds ?? 45;

  factory Reel({
    int? id,
    required String title,
    required String creatorName,
    required String subject,
    required String videoUrl,
    int? durationSeconds,
    required String suggestedSquadTopic,
    required List<_i6b38qpb.QuizQuestion> quizQuestions,
  }) = _ReelImpl;

  factory Reel.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reel(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      creatorName: jsonSerialization['creatorName'] as String,
      subject: jsonSerialization['subject'] as String,
      videoUrl: jsonSerialization['videoUrl'] as String,
      durationSeconds: jsonSerialization['durationSeconds'] as int?,
      suggestedSquadTopic: jsonSerialization['suggestedSquadTopic'] as String,
      quizQuestions: _ik53ze0v.Protocol()
          .deserialize<List<_i6b38qpb.QuizQuestion>>(
            jsonSerialization['quizQuestions'],
          ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String creatorName;

  String subject;

  String videoUrl;

  int durationSeconds;

  String suggestedSquadTopic;

  List<_i6b38qpb.QuizQuestion> quizQuestions;

  /// Returns a shallow copy of this [Reel]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Reel copyWith({
    int? id,
    String? title,
    String? creatorName,
    String? subject,
    String? videoUrl,
    int? durationSeconds,
    String? suggestedSquadTopic,
    List<_i6b38qpb.QuizQuestion>? quizQuestions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Reel',
      if (id != null) 'id': id,
      'title': title,
      'creatorName': creatorName,
      'subject': subject,
      'videoUrl': videoUrl,
      'durationSeconds': durationSeconds,
      'suggestedSquadTopic': suggestedSquadTopic,
      'quizQuestions': quizQuestions.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Reel',
      if (id != null) 'id': id,
      'title': title,
      'creatorName': creatorName,
      'subject': subject,
      'videoUrl': videoUrl,
      'durationSeconds': durationSeconds,
      'suggestedSquadTopic': suggestedSquadTopic,
      'quizQuestions': quizQuestions.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReelImpl extends Reel {
  _ReelImpl({
    int? id,
    required String title,
    required String creatorName,
    required String subject,
    required String videoUrl,
    int? durationSeconds,
    required String suggestedSquadTopic,
    required List<_i6b38qpb.QuizQuestion> quizQuestions,
  }) : super._(
         id: id,
         title: title,
         creatorName: creatorName,
         subject: subject,
         videoUrl: videoUrl,
         durationSeconds: durationSeconds,
         suggestedSquadTopic: suggestedSquadTopic,
         quizQuestions: quizQuestions,
       );

  /// Returns a shallow copy of this [Reel]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Reel copyWith({
    Object? id = _Undefined,
    String? title,
    String? creatorName,
    String? subject,
    String? videoUrl,
    int? durationSeconds,
    String? suggestedSquadTopic,
    List<_i6b38qpb.QuizQuestion>? quizQuestions,
  }) {
    return Reel(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      creatorName: creatorName ?? this.creatorName,
      subject: subject ?? this.subject,
      videoUrl: videoUrl ?? this.videoUrl,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      suggestedSquadTopic: suggestedSquadTopic ?? this.suggestedSquadTopic,
      quizQuestions:
          quizQuestions ??
          this.quizQuestions.map((e0) => e0.copyWith()).toList(),
    );
  }
}
