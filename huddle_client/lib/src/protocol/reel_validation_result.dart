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
import 'reel.dart' as _i3xjypah;

abstract class ReelValidationResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReelValidationResult._({
    required this.isValid,
    required this.isTechDomain,
    required this.confidenceScore,
    required this.detectedDomain,
    required this.technicalKeywords,
    required this.reason,
    this.suggestion,
    this.validatedReel,
  });

  factory ReelValidationResult({
    required bool isValid,
    required bool isTechDomain,
    required double confidenceScore,
    required String detectedDomain,
    required List<String> technicalKeywords,
    required String reason,
    String? suggestion,
    _i3xjypah.Reel? validatedReel,
  }) = _ReelValidationResultImpl;

  factory ReelValidationResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ReelValidationResult(
      isValid: _isc.BoolJsonExtension.fromJson(jsonSerialization['isValid']),
      isTechDomain: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isTechDomain'],
      ),
      confidenceScore: (jsonSerialization['confidenceScore'] as num).toDouble(),
      detectedDomain: jsonSerialization['detectedDomain'] as String,
      technicalKeywords: _ik53ze0v.Protocol().deserialize<List<String>>(
        jsonSerialization['technicalKeywords'],
      ),
      reason: jsonSerialization['reason'] as String,
      suggestion: jsonSerialization['suggestion'] as String?,
      validatedReel: jsonSerialization['validatedReel'] == null
          ? null
          : _ik53ze0v.Protocol().deserialize<_i3xjypah.Reel>(
              jsonSerialization['validatedReel'],
            ),
    );
  }

  bool isValid;

  bool isTechDomain;

  double confidenceScore;

  String detectedDomain;

  List<String> technicalKeywords;

  String reason;

  String? suggestion;

  _i3xjypah.Reel? validatedReel;

  /// Returns a shallow copy of this [ReelValidationResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReelValidationResult copyWith({
    bool? isValid,
    bool? isTechDomain,
    double? confidenceScore,
    String? detectedDomain,
    List<String>? technicalKeywords,
    String? reason,
    String? suggestion,
    _i3xjypah.Reel? validatedReel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReelValidationResult',
      'isValid': isValid,
      'isTechDomain': isTechDomain,
      'confidenceScore': confidenceScore,
      'detectedDomain': detectedDomain,
      'technicalKeywords': technicalKeywords.toJson(),
      'reason': reason,
      if (suggestion != null) 'suggestion': suggestion,
      if (validatedReel != null) 'validatedReel': validatedReel?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReelValidationResult',
      'isValid': isValid,
      'isTechDomain': isTechDomain,
      'confidenceScore': confidenceScore,
      'detectedDomain': detectedDomain,
      'technicalKeywords': technicalKeywords.toJson(),
      'reason': reason,
      if (suggestion != null) 'suggestion': suggestion,
      if (validatedReel != null)
        'validatedReel': validatedReel?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReelValidationResultImpl extends ReelValidationResult {
  _ReelValidationResultImpl({
    required bool isValid,
    required bool isTechDomain,
    required double confidenceScore,
    required String detectedDomain,
    required List<String> technicalKeywords,
    required String reason,
    String? suggestion,
    _i3xjypah.Reel? validatedReel,
  }) : super._(
         isValid: isValid,
         isTechDomain: isTechDomain,
         confidenceScore: confidenceScore,
         detectedDomain: detectedDomain,
         technicalKeywords: technicalKeywords,
         reason: reason,
         suggestion: suggestion,
         validatedReel: validatedReel,
       );

  /// Returns a shallow copy of this [ReelValidationResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReelValidationResult copyWith({
    bool? isValid,
    bool? isTechDomain,
    double? confidenceScore,
    String? detectedDomain,
    List<String>? technicalKeywords,
    String? reason,
    Object? suggestion = _Undefined,
    Object? validatedReel = _Undefined,
  }) {
    return ReelValidationResult(
      isValid: isValid ?? this.isValid,
      isTechDomain: isTechDomain ?? this.isTechDomain,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      detectedDomain: detectedDomain ?? this.detectedDomain,
      technicalKeywords:
          technicalKeywords ?? this.technicalKeywords.map((e0) => e0).toList(),
      reason: reason ?? this.reason,
      suggestion: suggestion is String? ? suggestion : this.suggestion,
      validatedReel: validatedReel is _i3xjypah.Reel?
          ? validatedReel
          : this.validatedReel?.copyWith(),
    );
  }
}
