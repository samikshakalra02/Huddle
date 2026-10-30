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

abstract class StudentBadge
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudentBadge._({
    required this.title,
    required this.description,
    required this.category,
    required this.isVolt,
    required this.isUnlocked,
    this.unlockedDate,
  });

  factory StudentBadge({
    required String title,
    required String description,
    required String category,
    required bool isVolt,
    required bool isUnlocked,
    String? unlockedDate,
  }) = _StudentBadgeImpl;

  factory StudentBadge.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentBadge(
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      category: jsonSerialization['category'] as String,
      isVolt: _isc.BoolJsonExtension.fromJson(jsonSerialization['isVolt']),
      isUnlocked: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isUnlocked'],
      ),
      unlockedDate: jsonSerialization['unlockedDate'] as String?,
    );
  }

  String title;

  String description;

  String category;

  bool isVolt;

  bool isUnlocked;

  String? unlockedDate;

  /// Returns a shallow copy of this [StudentBadge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudentBadge copyWith({
    String? title,
    String? description,
    String? category,
    bool? isVolt,
    bool? isUnlocked,
    String? unlockedDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentBadge',
      'title': title,
      'description': description,
      'category': category,
      'isVolt': isVolt,
      'isUnlocked': isUnlocked,
      if (unlockedDate != null) 'unlockedDate': unlockedDate,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentBadge',
      'title': title,
      'description': description,
      'category': category,
      'isVolt': isVolt,
      'isUnlocked': isUnlocked,
      if (unlockedDate != null) 'unlockedDate': unlockedDate,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentBadgeImpl extends StudentBadge {
  _StudentBadgeImpl({
    required String title,
    required String description,
    required String category,
    required bool isVolt,
    required bool isUnlocked,
    String? unlockedDate,
  }) : super._(
         title: title,
         description: description,
         category: category,
         isVolt: isVolt,
         isUnlocked: isUnlocked,
         unlockedDate: unlockedDate,
       );

  /// Returns a shallow copy of this [StudentBadge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudentBadge copyWith({
    String? title,
    String? description,
    String? category,
    bool? isVolt,
    bool? isUnlocked,
    Object? unlockedDate = _Undefined,
  }) {
    return StudentBadge(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isVolt: isVolt ?? this.isVolt,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedDate: unlockedDate is String? ? unlockedDate : this.unlockedDate,
    );
  }
}
