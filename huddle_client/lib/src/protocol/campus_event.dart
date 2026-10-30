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

abstract class CampusEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CampusEvent._({
    this.id,
    required this.title,
    required this.organizer,
    required this.venue,
    required this.eventTime,
    required this.description,
    required this.tag,
  });

  factory CampusEvent({
    int? id,
    required String title,
    required String organizer,
    required String venue,
    required DateTime eventTime,
    required String description,
    required String tag,
  }) = _CampusEventImpl;

  factory CampusEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return CampusEvent(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      organizer: jsonSerialization['organizer'] as String,
      venue: jsonSerialization['venue'] as String,
      eventTime: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['eventTime'],
      ),
      description: jsonSerialization['description'] as String,
      tag: jsonSerialization['tag'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String organizer;

  String venue;

  DateTime eventTime;

  String description;

  String tag;

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CampusEvent copyWith({
    int? id,
    String? title,
    String? organizer,
    String? venue,
    DateTime? eventTime,
    String? description,
    String? tag,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CampusEvent',
      if (id != null) 'id': id,
      'title': title,
      'organizer': organizer,
      'venue': venue,
      'eventTime': eventTime.toJson(),
      'description': description,
      'tag': tag,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CampusEvent',
      if (id != null) 'id': id,
      'title': title,
      'organizer': organizer,
      'venue': venue,
      'eventTime': eventTime.toJson(),
      'description': description,
      'tag': tag,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CampusEventImpl extends CampusEvent {
  _CampusEventImpl({
    int? id,
    required String title,
    required String organizer,
    required String venue,
    required DateTime eventTime,
    required String description,
    required String tag,
  }) : super._(
         id: id,
         title: title,
         organizer: organizer,
         venue: venue,
         eventTime: eventTime,
         description: description,
         tag: tag,
       );

  /// Returns a shallow copy of this [CampusEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CampusEvent copyWith({
    Object? id = _Undefined,
    String? title,
    String? organizer,
    String? venue,
    DateTime? eventTime,
    String? description,
    String? tag,
  }) {
    return CampusEvent(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      organizer: organizer ?? this.organizer,
      venue: venue ?? this.venue,
      eventTime: eventTime ?? this.eventTime,
      description: description ?? this.description,
      tag: tag ?? this.tag,
    );
  }
}
