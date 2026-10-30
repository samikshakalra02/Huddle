/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:huddle_client/src/protocol/squad.dart' as _i1r9in2t;
import 'package:huddle_client/src/protocol/squad_suggestion.dart' as _ik57hy4d;
import 'package:huddle_client/src/protocol/student_persona.dart' as _i829aubc;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'campus_event.dart' as _ieh998j0;
import 'feed_response.dart' as _iriswu3w;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'karma_activity.dart' as _i7i1375o;
import 'peer_endorsement.dart' as _i9iommci;
import 'quiz_question.dart' as _i6b38qpb;
import 'quiz_result.dart' as _isjq8qs8;
import 'reel.dart' as _i3xjypah;
import 'squad.dart' as _i1svoism;
import 'squad_chat_message.dart' as _ijharqf9;
import 'squad_details.dart' as _i29qtu7j;
import 'squad_member.dart' as _il862mk4;
import 'squad_room_event.dart' as _iks396cf;
import 'squad_suggestion.dart' as _ieviavxt;
import 'student_badge.dart' as _ih1itj7p;
import 'student_persona.dart' as _i0ubnxua;
export 'campus_event.dart';
export 'feed_response.dart';
export 'greetings/greeting.dart';
export 'karma_activity.dart';
export 'peer_endorsement.dart';
export 'quiz_question.dart';
export 'quiz_result.dart';
export 'reel.dart';
export 'squad.dart';
export 'squad_chat_message.dart';
export 'squad_details.dart';
export 'squad_member.dart';
export 'squad_room_event.dart';
export 'squad_suggestion.dart';
export 'student_badge.dart';
export 'student_persona.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ieh998j0.CampusEvent) {
      return _ieh998j0.CampusEvent.fromJson(data) as T;
    }
    if (t == _iriswu3w.FeedResponse) {
      return _iriswu3w.FeedResponse.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _i7i1375o.KarmaActivity) {
      return _i7i1375o.KarmaActivity.fromJson(data) as T;
    }
    if (t == _i9iommci.PeerEndorsement) {
      return _i9iommci.PeerEndorsement.fromJson(data) as T;
    }
    if (t == _i6b38qpb.QuizQuestion) {
      return _i6b38qpb.QuizQuestion.fromJson(data) as T;
    }
    if (t == _isjq8qs8.QuizResult) {
      return _isjq8qs8.QuizResult.fromJson(data) as T;
    }
    if (t == _i3xjypah.Reel) {
      return _i3xjypah.Reel.fromJson(data) as T;
    }
    if (t == _i1svoism.Squad) {
      return _i1svoism.Squad.fromJson(data) as T;
    }
    if (t == _ijharqf9.SquadChatMessage) {
      return _ijharqf9.SquadChatMessage.fromJson(data) as T;
    }
    if (t == _i29qtu7j.SquadDetails) {
      return _i29qtu7j.SquadDetails.fromJson(data) as T;
    }
    if (t == _il862mk4.SquadMember) {
      return _il862mk4.SquadMember.fromJson(data) as T;
    }
    if (t == _iks396cf.SquadRoomEvent) {
      return _iks396cf.SquadRoomEvent.fromJson(data) as T;
    }
    if (t == _ieviavxt.SquadSuggestion) {
      return _ieviavxt.SquadSuggestion.fromJson(data) as T;
    }
    if (t == _ih1itj7p.StudentBadge) {
      return _ih1itj7p.StudentBadge.fromJson(data) as T;
    }
    if (t == _i0ubnxua.StudentPersona) {
      return _i0ubnxua.StudentPersona.fromJson(data) as T;
    }
    if (t == _isc.getType<_ieh998j0.CampusEvent?>()) {
      return (data != null ? _ieh998j0.CampusEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iriswu3w.FeedResponse?>()) {
      return (data != null ? _iriswu3w.FeedResponse.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7i1375o.KarmaActivity?>()) {
      return (data != null ? _i7i1375o.KarmaActivity.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9iommci.PeerEndorsement?>()) {
      return (data != null ? _i9iommci.PeerEndorsement.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6b38qpb.QuizQuestion?>()) {
      return (data != null ? _i6b38qpb.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isjq8qs8.QuizResult?>()) {
      return (data != null ? _isjq8qs8.QuizResult.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i3xjypah.Reel?>()) {
      return (data != null ? _i3xjypah.Reel.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1svoism.Squad?>()) {
      return (data != null ? _i1svoism.Squad.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijharqf9.SquadChatMessage?>()) {
      return (data != null ? _ijharqf9.SquadChatMessage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i29qtu7j.SquadDetails?>()) {
      return (data != null ? _i29qtu7j.SquadDetails.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_il862mk4.SquadMember?>()) {
      return (data != null ? _il862mk4.SquadMember.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iks396cf.SquadRoomEvent?>()) {
      return (data != null ? _iks396cf.SquadRoomEvent.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ieviavxt.SquadSuggestion?>()) {
      return (data != null ? _ieviavxt.SquadSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ih1itj7p.StudentBadge?>()) {
      return (data != null ? _ih1itj7p.StudentBadge.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0ubnxua.StudentPersona?>()) {
      return (data != null ? _i0ubnxua.StudentPersona.fromJson(data) : null)
          as T;
    }
    if (t == List<_i3xjypah.Reel>) {
      return (data as List).map((e) => deserialize<_i3xjypah.Reel>(e)).toList()
          as T;
    }
    if (t == List<_ieh998j0.CampusEvent>) {
      return (data as List)
              .map((e) => deserialize<_ieh998j0.CampusEvent>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i6b38qpb.QuizQuestion>) {
      return (data as List)
              .map((e) => deserialize<_i6b38qpb.QuizQuestion>(e))
              .toList()
          as T;
    }
    if (t == List<_il862mk4.SquadMember>) {
      return (data as List)
              .map((e) => deserialize<_il862mk4.SquadMember>(e))
              .toList()
          as T;
    }
    if (t == List<_ijharqf9.SquadChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_ijharqf9.SquadChatMessage>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ijharqf9.SquadChatMessage>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ijharqf9.SquadChatMessage>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == _isc.getType<List<_il862mk4.SquadMember>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_il862mk4.SquadMember>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ih1itj7p.StudentBadge>) {
      return (data as List)
              .map((e) => deserialize<_ih1itj7p.StudentBadge>(e))
              .toList()
          as T;
    }
    if (t == List<_i7i1375o.KarmaActivity>) {
      return (data as List)
              .map((e) => deserialize<_i7i1375o.KarmaActivity>(e))
              .toList()
          as T;
    }
    if (t == List<_i9iommci.PeerEndorsement>) {
      return (data as List)
              .map((e) => deserialize<_i9iommci.PeerEndorsement>(e))
              .toList()
          as T;
    }
    if (t == List<_i829aubc.StudentPersona>) {
      return (data as List)
              .map((e) => deserialize<_i829aubc.StudentPersona>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_ik57hy4d.SquadSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_ik57hy4d.SquadSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<_i1r9in2t.Squad>) {
      return (data as List).map((e) => deserialize<_i1r9in2t.Squad>(e)).toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ieh998j0.CampusEvent => 'CampusEvent',
      _iriswu3w.FeedResponse => 'FeedResponse',
      _izw8z7ou.Greeting => 'Greeting',
      _i7i1375o.KarmaActivity => 'KarmaActivity',
      _i9iommci.PeerEndorsement => 'PeerEndorsement',
      _i6b38qpb.QuizQuestion => 'QuizQuestion',
      _isjq8qs8.QuizResult => 'QuizResult',
      _i3xjypah.Reel => 'Reel',
      _i1svoism.Squad => 'Squad',
      _ijharqf9.SquadChatMessage => 'SquadChatMessage',
      _i29qtu7j.SquadDetails => 'SquadDetails',
      _il862mk4.SquadMember => 'SquadMember',
      _iks396cf.SquadRoomEvent => 'SquadRoomEvent',
      _ieviavxt.SquadSuggestion => 'SquadSuggestion',
      _ih1itj7p.StudentBadge => 'StudentBadge',
      _i0ubnxua.StudentPersona => 'StudentPersona',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('huddle.', '');
    }

    switch (data) {
      case _ieh998j0.CampusEvent():
        return 'CampusEvent';
      case _iriswu3w.FeedResponse():
        return 'FeedResponse';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _i7i1375o.KarmaActivity():
        return 'KarmaActivity';
      case _i9iommci.PeerEndorsement():
        return 'PeerEndorsement';
      case _i6b38qpb.QuizQuestion():
        return 'QuizQuestion';
      case _isjq8qs8.QuizResult():
        return 'QuizResult';
      case _i3xjypah.Reel():
        return 'Reel';
      case _i1svoism.Squad():
        return 'Squad';
      case _ijharqf9.SquadChatMessage():
        return 'SquadChatMessage';
      case _i29qtu7j.SquadDetails():
        return 'SquadDetails';
      case _il862mk4.SquadMember():
        return 'SquadMember';
      case _iks396cf.SquadRoomEvent():
        return 'SquadRoomEvent';
      case _ieviavxt.SquadSuggestion():
        return 'SquadSuggestion';
      case _ih1itj7p.StudentBadge():
        return 'StudentBadge';
      case _i0ubnxua.StudentPersona():
        return 'StudentPersona';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'CampusEvent') {
      return deserialize<_ieh998j0.CampusEvent>(data['data']);
    }
    if (dataClassName == 'FeedResponse') {
      return deserialize<_iriswu3w.FeedResponse>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'KarmaActivity') {
      return deserialize<_i7i1375o.KarmaActivity>(data['data']);
    }
    if (dataClassName == 'PeerEndorsement') {
      return deserialize<_i9iommci.PeerEndorsement>(data['data']);
    }
    if (dataClassName == 'QuizQuestion') {
      return deserialize<_i6b38qpb.QuizQuestion>(data['data']);
    }
    if (dataClassName == 'QuizResult') {
      return deserialize<_isjq8qs8.QuizResult>(data['data']);
    }
    if (dataClassName == 'Reel') {
      return deserialize<_i3xjypah.Reel>(data['data']);
    }
    if (dataClassName == 'Squad') {
      return deserialize<_i1svoism.Squad>(data['data']);
    }
    if (dataClassName == 'SquadChatMessage') {
      return deserialize<_ijharqf9.SquadChatMessage>(data['data']);
    }
    if (dataClassName == 'SquadDetails') {
      return deserialize<_i29qtu7j.SquadDetails>(data['data']);
    }
    if (dataClassName == 'SquadMember') {
      return deserialize<_il862mk4.SquadMember>(data['data']);
    }
    if (dataClassName == 'SquadRoomEvent') {
      return deserialize<_iks396cf.SquadRoomEvent>(data['data']);
    }
    if (dataClassName == 'SquadSuggestion') {
      return deserialize<_ieviavxt.SquadSuggestion>(data['data']);
    }
    if (dataClassName == 'StudentBadge') {
      return deserialize<_ih1itj7p.StudentBadge>(data['data']);
    }
    if (dataClassName == 'StudentPersona') {
      return deserialize<_i0ubnxua.StudentPersona>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('huddle', this);
    _iacc.Protocol().registerHostProtocol('huddle', this);
  }

  @override
  String getModuleName() => 'huddle';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
