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
import 'package:serverpod/serverpod.dart' as _is;

abstract class KarmaActivity
    implements _is.SerializableModel, _is.ProtocolSerialization {
  KarmaActivity._({
    required this.title,
    required this.detail,
    required this.karmaDelta,
    required this.timeAgo,
    required this.iconName,
  });

  factory KarmaActivity({
    required String title,
    required String detail,
    required double karmaDelta,
    required String timeAgo,
    required String iconName,
  }) = _KarmaActivityImpl;

  factory KarmaActivity.fromJson(Map<String, dynamic> jsonSerialization) {
    return KarmaActivity(
      title: jsonSerialization['title'] as String,
      detail: jsonSerialization['detail'] as String,
      karmaDelta: (jsonSerialization['karmaDelta'] as num).toDouble(),
      timeAgo: jsonSerialization['timeAgo'] as String,
      iconName: jsonSerialization['iconName'] as String,
    );
  }

  String title;

  String detail;

  double karmaDelta;

  String timeAgo;

  String iconName;

  /// Returns a shallow copy of this [KarmaActivity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  KarmaActivity copyWith({
    String? title,
    String? detail,
    double? karmaDelta,
    String? timeAgo,
    String? iconName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KarmaActivity',
      'title': title,
      'detail': detail,
      'karmaDelta': karmaDelta,
      'timeAgo': timeAgo,
      'iconName': iconName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'KarmaActivity',
      'title': title,
      'detail': detail,
      'karmaDelta': karmaDelta,
      'timeAgo': timeAgo,
      'iconName': iconName,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _KarmaActivityImpl extends KarmaActivity {
  _KarmaActivityImpl({
    required String title,
    required String detail,
    required double karmaDelta,
    required String timeAgo,
    required String iconName,
  }) : super._(
         title: title,
         detail: detail,
         karmaDelta: karmaDelta,
         timeAgo: timeAgo,
         iconName: iconName,
       );

  /// Returns a shallow copy of this [KarmaActivity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  KarmaActivity copyWith({
    String? title,
    String? detail,
    double? karmaDelta,
    String? timeAgo,
    String? iconName,
  }) {
    return KarmaActivity(
      title: title ?? this.title,
      detail: detail ?? this.detail,
      karmaDelta: karmaDelta ?? this.karmaDelta,
      timeAgo: timeAgo ?? this.timeAgo,
      iconName: iconName ?? this.iconName,
    );
  }
}
