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

abstract class PeerEndorsement
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PeerEndorsement._({
    required this.authorName,
    required this.authorMajor,
    required this.tag,
    required this.quote,
    required this.timeAgo,
  });

  factory PeerEndorsement({
    required String authorName,
    required String authorMajor,
    required String tag,
    required String quote,
    required String timeAgo,
  }) = _PeerEndorsementImpl;

  factory PeerEndorsement.fromJson(Map<String, dynamic> jsonSerialization) {
    return PeerEndorsement(
      authorName: jsonSerialization['authorName'] as String,
      authorMajor: jsonSerialization['authorMajor'] as String,
      tag: jsonSerialization['tag'] as String,
      quote: jsonSerialization['quote'] as String,
      timeAgo: jsonSerialization['timeAgo'] as String,
    );
  }

  String authorName;

  String authorMajor;

  String tag;

  String quote;

  String timeAgo;

  /// Returns a shallow copy of this [PeerEndorsement]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PeerEndorsement copyWith({
    String? authorName,
    String? authorMajor,
    String? tag,
    String? quote,
    String? timeAgo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PeerEndorsement',
      'authorName': authorName,
      'authorMajor': authorMajor,
      'tag': tag,
      'quote': quote,
      'timeAgo': timeAgo,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PeerEndorsement',
      'authorName': authorName,
      'authorMajor': authorMajor,
      'tag': tag,
      'quote': quote,
      'timeAgo': timeAgo,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _PeerEndorsementImpl extends PeerEndorsement {
  _PeerEndorsementImpl({
    required String authorName,
    required String authorMajor,
    required String tag,
    required String quote,
    required String timeAgo,
  }) : super._(
         authorName: authorName,
         authorMajor: authorMajor,
         tag: tag,
         quote: quote,
         timeAgo: timeAgo,
       );

  /// Returns a shallow copy of this [PeerEndorsement]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PeerEndorsement copyWith({
    String? authorName,
    String? authorMajor,
    String? tag,
    String? quote,
    String? timeAgo,
  }) {
    return PeerEndorsement(
      authorName: authorName ?? this.authorName,
      authorMajor: authorMajor ?? this.authorMajor,
      tag: tag ?? this.tag,
      quote: quote ?? this.quote,
      timeAgo: timeAgo ?? this.timeAgo,
    );
  }
}
