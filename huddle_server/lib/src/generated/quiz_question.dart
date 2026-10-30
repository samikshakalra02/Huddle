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

abstract class QuizQuestion
    implements _is.SerializableModel, _is.ProtocolSerialization {
  QuizQuestion._({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    this.explanation,
  });

  factory QuizQuestion({
    required String question,
    required List<String> options,
    required int correctOptionIndex,
    String? explanation,
  }) = _QuizQuestionImpl;

  factory QuizQuestion.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizQuestion(
      question: jsonSerialization['question'] as String,
      options: _i8h64kwd.Protocol().deserialize<List<String>>(
        jsonSerialization['options'],
      ),
      correctOptionIndex: jsonSerialization['correctOptionIndex'] as int,
      explanation: jsonSerialization['explanation'] as String?,
    );
  }

  String question;

  List<String> options;

  int correctOptionIndex;

  String? explanation;

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuizQuestion copyWith({
    String? question,
    List<String>? options,
    int? correctOptionIndex,
    String? explanation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizQuestion',
      'question': question,
      'options': options.toJson(),
      'correctOptionIndex': correctOptionIndex,
      if (explanation != null) 'explanation': explanation,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizQuestion',
      'question': question,
      'options': options.toJson(),
      'correctOptionIndex': correctOptionIndex,
      if (explanation != null) 'explanation': explanation,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizQuestionImpl extends QuizQuestion {
  _QuizQuestionImpl({
    required String question,
    required List<String> options,
    required int correctOptionIndex,
    String? explanation,
  }) : super._(
         question: question,
         options: options,
         correctOptionIndex: correctOptionIndex,
         explanation: explanation,
       );

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuizQuestion copyWith({
    String? question,
    List<String>? options,
    int? correctOptionIndex,
    Object? explanation = _Undefined,
  }) {
    return QuizQuestion(
      question: question ?? this.question,
      options: options ?? this.options.map((e0) => e0).toList(),
      correctOptionIndex: correctOptionIndex ?? this.correctOptionIndex,
      explanation: explanation is String? ? explanation : this.explanation,
    );
  }
}
