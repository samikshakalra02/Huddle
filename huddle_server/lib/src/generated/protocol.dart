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
import 'package:huddle_server/src/generated/squad.dart' as _ioqogg9q;
import 'package:huddle_server/src/generated/squad_suggestion.dart' as _i5a6zh2j;
import 'package:huddle_server/src/generated/student_persona.dart' as _i227n00v;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'campus_event.dart' as _ieh998j0;
import 'feed_response.dart' as _iriswu3w;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'karma_activity.dart' as _i7i1375o;
import 'peer_endorsement.dart' as _i9iommci;
import 'quiz_question.dart' as _i6b38qpb;
import 'quiz_result.dart' as _isjq8qs8;
import 'reel.dart' as _i3xjypah;
import 'reel_validation_result.dart' as _i3l924vf;
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
export 'reel_validation_result.dart';
export 'squad.dart';
export 'squad_chat_message.dart';
export 'squad_details.dart';
export 'squad_member.dart';
export 'squad_room_event.dart';
export 'squad_suggestion.dart';
export 'student_badge.dart';
export 'student_persona.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'campus_event',
      dartName: 'CampusEvent',
      schema: 'public',
      module: 'huddle',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'organizer',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'venue',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'eventTime',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'tag',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'reel',
      dartName: 'Reel',
      schema: 'public',
      module: 'huddle',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'creatorName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'subject',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'videoUrl',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'durationSeconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '45',
        ),
        _isp.ColumnDefinition(
          name: 'suggestedSquadTopic',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'quizQuestions',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:QuizQuestion>',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'squad',
      dartName: 'Squad',
      schema: 'public',
      module: 'huddle',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'topic',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetExam',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'timeSlot',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'streak',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'goal',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'40 problems\'',
        ),
        _isp.ColumnDefinition(
          name: 'currentGoalCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '28',
        ),
        _isp.ColumnDefinition(
          name: 'maxMembers',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '6',
        ),
        _isp.ColumnDefinition(
          name: 'timerStartedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'timerDurationSeconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1500',
        ),
        _isp.ColumnDefinition(
          name: 'isFocusing',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'squad_chat_message',
      dartName: 'SquadChatMessage',
      schema: 'public',
      module: 'huddle',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'squadId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'message',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sentAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'squad_member',
      dartName: 'SquadMember',
      schema: 'public',
      module: 'huddle',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'squadId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'avatarUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'isFocusing',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'karma',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '4.8',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _i3l924vf.ReelValidationResult) {
      return _i3l924vf.ReelValidationResult.fromJson(data) as T;
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
    if (t == _is.getType<_ieh998j0.CampusEvent?>()) {
      return (data != null ? _ieh998j0.CampusEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iriswu3w.FeedResponse?>()) {
      return (data != null ? _iriswu3w.FeedResponse.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7i1375o.KarmaActivity?>()) {
      return (data != null ? _i7i1375o.KarmaActivity.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9iommci.PeerEndorsement?>()) {
      return (data != null ? _i9iommci.PeerEndorsement.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6b38qpb.QuizQuestion?>()) {
      return (data != null ? _i6b38qpb.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_isjq8qs8.QuizResult?>()) {
      return (data != null ? _isjq8qs8.QuizResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3xjypah.Reel?>()) {
      return (data != null ? _i3xjypah.Reel.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3l924vf.ReelValidationResult?>()) {
      return (data != null
              ? _i3l924vf.ReelValidationResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i1svoism.Squad?>()) {
      return (data != null ? _i1svoism.Squad.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ijharqf9.SquadChatMessage?>()) {
      return (data != null ? _ijharqf9.SquadChatMessage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i29qtu7j.SquadDetails?>()) {
      return (data != null ? _i29qtu7j.SquadDetails.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_il862mk4.SquadMember?>()) {
      return (data != null ? _il862mk4.SquadMember.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iks396cf.SquadRoomEvent?>()) {
      return (data != null ? _iks396cf.SquadRoomEvent.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ieviavxt.SquadSuggestion?>()) {
      return (data != null ? _ieviavxt.SquadSuggestion.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ih1itj7p.StudentBadge?>()) {
      return (data != null ? _ih1itj7p.StudentBadge.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i0ubnxua.StudentPersona?>()) {
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
    if (t == _is.getType<List<_ijharqf9.SquadChatMessage>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ijharqf9.SquadChatMessage>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == _is.getType<List<_il862mk4.SquadMember>?>()) {
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
    if (t == List<_i227n00v.StudentPersona>) {
      return (data as List)
              .map((e) => deserialize<_i227n00v.StudentPersona>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i5a6zh2j.SquadSuggestion>) {
      return (data as List)
              .map((e) => deserialize<_i5a6zh2j.SquadSuggestion>(e))
              .toList()
          as T;
    }
    if (t == List<_ioqogg9q.Squad>) {
      return (data as List).map((e) => deserialize<_ioqogg9q.Squad>(e)).toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
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
      _i3l924vf.ReelValidationResult => 'ReelValidationResult',
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
      case _i3l924vf.ReelValidationResult():
        return 'ReelValidationResult';
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
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
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
    if (dataClassName == 'ReelValidationResult') {
      return deserialize<_i3l924vf.ReelValidationResult>(data['data']);
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
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('huddle', this);
    _iacs.Protocol().registerHostProtocol('huddle', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _ieh998j0.CampusEvent:
        return _ieh998j0.CampusEvent.t;
      case _i3xjypah.Reel:
        return _i3xjypah.Reel.t;
      case _i1svoism.Squad:
        return _i1svoism.Squad.t;
      case _ijharqf9.SquadChatMessage:
        return _ijharqf9.SquadChatMessage.t;
      case _il862mk4.SquadMember:
        return _il862mk4.SquadMember.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

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
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
