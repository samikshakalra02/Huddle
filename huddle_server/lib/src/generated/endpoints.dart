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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/feed_endpoint.dart' as _i8rwrucy;
import '../endpoints/profile_endpoint.dart' as _i2cx2pww;
import '../endpoints/reel_endpoint.dart' as _i16s5vx1;
import '../endpoints/squad_endpoint.dart' as _ieljk2ry;
import '../greetings/greeting_endpoint.dart' as _il624ik7;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'feed': _i8rwrucy.FeedEndpoint()
        ..initialize(
          server,
          'feed',
          null,
        ),
      'profile': _i2cx2pww.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'reel': _i16s5vx1.ReelEndpoint()
        ..initialize(
          server,
          'reel',
          null,
        ),
      'squad': _ieljk2ry.SquadEndpoint()
        ..initialize(
          server,
          'squad',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['feed'] = _is.EndpointConnector(
      name: 'feed',
      endpoint: endpoints['feed']!,
      methodConnectors: {
        'get': _is.MethodConnector(
          name: 'get',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['feed'] as _i8rwrucy.FeedEndpoint).get(session),
        ),
      },
    );
    connectors['profile'] = _is.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'getPersonas': _is.MethodConnector(
          name: 'getPersonas',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getPersonas(session),
        ),
        'getPersonaByName': _is.MethodConnector(
          name: 'getPersonaByName',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getPersonaByName(
                    session,
                    params['name'],
                  ),
        ),
        'endorsePersona': _is.MethodConnector(
          name: 'endorsePersona',
          params: {
            'targetName': _is.ParameterDescription(
              name: 'targetName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'tag': _is.ParameterDescription(
              name: 'tag',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'quote': _is.ParameterDescription(
              name: 'quote',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'authorName': _is.ParameterDescription(
              name: 'authorName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .endorsePersona(
                    session,
                    targetName: params['targetName'],
                    tag: params['tag'],
                    quote: params['quote'],
                    authorName: params['authorName'],
                  ),
        ),
        'updateGoal': _is.MethodConnector(
          name: 'updateGoal',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newGoal': _is.ParameterDescription(
              name: 'newGoal',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .updateGoal(
                    session,
                    name: params['name'],
                    newGoal: params['newGoal'],
                  ),
        ),
      },
    );
    connectors['reel'] = _is.EndpointConnector(
      name: 'reel',
      endpoint: endpoints['reel']!,
      methodConnectors: {
        'submitQuiz': _is.MethodConnector(
          name: 'submitQuiz',
          params: {
            'reelId': _is.ParameterDescription(
              name: 'reelId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'selectedAnswers': _is.ParameterDescription(
              name: 'selectedAnswers',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reel'] as _i16s5vx1.ReelEndpoint).submitQuiz(
                    session,
                    reelId: params['reelId'],
                    selectedAnswers: params['selectedAnswers'],
                  ),
        ),
      },
    );
    connectors['squad'] = _is.EndpointConnector(
      name: 'squad',
      endpoint: endpoints['squad']!,
      methodConnectors: {
        'sendChat': _is.MethodConnector(
          name: 'sendChat',
          params: {
            'squadId': _is.ParameterDescription(
              name: 'squadId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userName': _is.ParameterDescription(
              name: 'userName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['squad'] as _ieljk2ry.SquadEndpoint).sendChat(
                    session,
                    squadId: params['squadId'],
                    userName: params['userName'],
                    message: params['message'],
                  ),
        ),
        'updatePresence': _is.MethodConnector(
          name: 'updatePresence',
          params: {
            'squadId': _is.ParameterDescription(
              name: 'squadId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userName': _is.ParameterDescription(
              name: 'userName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'isFocusing': _is.ParameterDescription(
              name: 'isFocusing',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['squad'] as _ieljk2ry.SquadEndpoint)
                  .updatePresence(
                    session,
                    squadId: params['squadId'],
                    userName: params['userName'],
                    isFocusing: params['isFocusing'],
                  ),
        ),
        'suggest': _is.MethodConnector(
          name: 'suggest',
          params: {
            'topic': _is.ParameterDescription(
              name: 'topic',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'exam': _is.ParameterDescription(
              name: 'exam',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'timeSlot': _is.ParameterDescription(
              name: 'timeSlot',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['squad'] as _ieljk2ry.SquadEndpoint).suggest(
                    session,
                    topic: params['topic'],
                    exam: params['exam'],
                    timeSlot: params['timeSlot'],
                  ),
        ),
        'join': _is.MethodConnector(
          name: 'join',
          params: {
            'squadId': _is.ParameterDescription(
              name: 'squadId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userName': _is.ParameterDescription(
              name: 'userName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'avatarUrl': _is.ParameterDescription(
              name: 'avatarUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['squad'] as _ieljk2ry.SquadEndpoint).join(
                session,
                squadId: params['squadId'],
                userName: params['userName'],
                avatarUrl: params['avatarUrl'],
              ),
        ),
        'startTimer': _is.MethodConnector(
          name: 'startTimer',
          params: {
            'squadId': _is.ParameterDescription(
              name: 'squadId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'durationSeconds': _is.ParameterDescription(
              name: 'durationSeconds',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['squad'] as _ieljk2ry.SquadEndpoint).startTimer(
                    session,
                    squadId: params['squadId'],
                    durationSeconds: params['durationSeconds'],
                  ),
        ),
        'getSquad': _is.MethodConnector(
          name: 'getSquad',
          params: {
            'squadId': _is.ParameterDescription(
              name: 'squadId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['squad'] as _ieljk2ry.SquadEndpoint).getSquad(
                    session,
                    squadId: params['squadId'],
                  ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['squad'] as _ieljk2ry.SquadEndpoint).list(session),
        ),
        'room': _is.MethodStreamConnector(
          name: 'room',
          params: {
            'squadId': _is.ParameterDescription(
              name: 'squadId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['squad'] as _ieljk2ry.SquadEndpoint).room(
                session,
                params['squadId'],
              ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
