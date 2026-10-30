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
import 'campus_event.dart' as _ieh998j0;
import 'reel.dart' as _i3xjypah;

abstract class FeedResponse
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FeedResponse._({
    required this.reels,
    required this.events,
  });

  factory FeedResponse({
    required List<_i3xjypah.Reel> reels,
    required List<_ieh998j0.CampusEvent> events,
  }) = _FeedResponseImpl;

  factory FeedResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedResponse(
      reels: _i8h64kwd.Protocol().deserialize<List<_i3xjypah.Reel>>(
        jsonSerialization['reels'],
      ),
      events: _i8h64kwd.Protocol().deserialize<List<_ieh998j0.CampusEvent>>(
        jsonSerialization['events'],
      ),
    );
  }

  List<_i3xjypah.Reel> reels;

  List<_ieh998j0.CampusEvent> events;

  /// Returns a shallow copy of this [FeedResponse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeedResponse copyWith({
    List<_i3xjypah.Reel>? reels,
    List<_ieh998j0.CampusEvent>? events,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedResponse',
      'reels': reels.toJson(valueToJson: (v) => v.toJson()),
      'events': events.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedResponse',
      'reels': reels.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'events': events.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _FeedResponseImpl extends FeedResponse {
  _FeedResponseImpl({
    required List<_i3xjypah.Reel> reels,
    required List<_ieh998j0.CampusEvent> events,
  }) : super._(
         reels: reels,
         events: events,
       );

  /// Returns a shallow copy of this [FeedResponse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeedResponse copyWith({
    List<_i3xjypah.Reel>? reels,
    List<_ieh998j0.CampusEvent>? events,
  }) {
    return FeedResponse(
      reels: reels ?? this.reels.map((e0) => e0.copyWith()).toList(),
      events: events ?? this.events.map((e0) => e0.copyWith()).toList(),
    );
  }
}
