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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:huddle_client/src/protocol/feed_response.dart' as _iwytu3ze;
import 'package:huddle_client/src/protocol/greetings/greeting.dart'
    as _ii60tda0;
import 'package:huddle_client/src/protocol/quiz_result.dart' as _irvwqrsp;
import 'package:huddle_client/src/protocol/reel.dart' as _iotke41f;
import 'package:huddle_client/src/protocol/reel_validation_result.dart'
    as _i9h0k2ux;
import 'package:huddle_client/src/protocol/squad.dart' as _i1r9in2t;
import 'package:huddle_client/src/protocol/squad_chat_message.dart'
    as _ifnfqe9v;
import 'package:huddle_client/src/protocol/squad_details.dart' as _ishbnsri;
import 'package:huddle_client/src/protocol/squad_member.dart' as _iariawr2;
import 'package:huddle_client/src/protocol/squad_room_event.dart' as _ifi3b4wy;
import 'package:huddle_client/src/protocol/squad_suggestion.dart' as _ik57hy4d;
import 'package:huddle_client/src/protocol/student_persona.dart' as _i829aubc;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// {@category Endpoint}
class EndpointFeed extends _isc.EndpointRef {
  EndpointFeed(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'feed';

  /// Returns all peer reels and campus events in one feed.
  _ida.Future<_iwytu3ze.FeedResponse> get() =>
      caller.callServerEndpoint<_iwytu3ze.FeedResponse>(
        'feed',
        'get',
        {},
      );
}

/// {@category Endpoint}
class EndpointProfile extends _isc.EndpointRef {
  EndpointProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  /// Get all campus student personas
  _ida.Future<List<_i829aubc.StudentPersona>> getPersonas() =>
      caller.callServerEndpoint<List<_i829aubc.StudentPersona>>(
        'profile',
        'getPersonas',
        {},
      );

  /// Get persona by exact or partial name
  _ida.Future<_i829aubc.StudentPersona?> getPersonaByName(String name) =>
      caller.callServerEndpoint<_i829aubc.StudentPersona?>(
        'profile',
        'getPersonaByName',
        {'name': name},
      );

  /// Endorse a peer's campus karma
  _ida.Future<_i829aubc.StudentPersona> endorsePersona({
    required String targetName,
    required String tag,
    required String quote,
    required String authorName,
  }) => caller.callServerEndpoint<_i829aubc.StudentPersona>(
    'profile',
    'endorsePersona',
    {
      'targetName': targetName,
      'tag': tag,
      'quote': quote,
      'authorName': authorName,
    },
  );

  /// Update personal study goal
  _ida.Future<_i829aubc.StudentPersona> updateGoal({
    required String name,
    required String newGoal,
  }) => caller.callServerEndpoint<_i829aubc.StudentPersona>(
    'profile',
    'updateGoal',
    {
      'name': name,
      'newGoal': newGoal,
    },
  );
}

/// {@category Endpoint}
class EndpointReel extends _isc.EndpointRef {
  EndpointReel(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'reel';

  /// Evaluates submitted quiz answers, computes score, and returns suggested squad topic.
  _ida.Future<_irvwqrsp.QuizResult> submitQuiz({
    required int reelId,
    required List<int> selectedAnswers,
  }) => caller.callServerEndpoint<_irvwqrsp.QuizResult>(
    'reel',
    'submitQuiz',
    {
      'reelId': reelId,
      'selectedAnswers': selectedAnswers,
    },
  );

  /// ML-Powered Tech Domain Pre-Validation
  /// Analyzes the reel title, subject, and transcript/content summary before upload.
  /// Rejects non-tech domains (lifestyle, dance, gaming streams, gossip) and approves
  /// verified engineering/CS topics with confidence scores.
  _ida.Future<_i9h0k2ux.ReelValidationResult> validateReel({
    required String title,
    required String subject,
    required String content,
  }) => caller.callServerEndpoint<_i9h0k2ux.ReelValidationResult>(
    'reel',
    'validateReel',
    {
      'title': title,
      'subject': subject,
      'content': content,
    },
  );

  /// Validates and securely uploads a new micro-lesson Reel.
  /// Enforces that only verified tech-domain reels pass the ML gatekeeper.
  _ida.Future<_i9h0k2ux.ReelValidationResult> uploadReel({
    required _iotke41f.Reel reel,
    required String content,
  }) => caller.callServerEndpoint<_i9h0k2ux.ReelValidationResult>(
    'reel',
    'uploadReel',
    {
      'reel': reel,
      'content': content,
    },
  );
}

/// {@category Endpoint}
class EndpointSquad extends _isc.EndpointRef {
  EndpointSquad(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'squad';

  /// Streaming endpoint: provides live chat, presence, and timer events between squad members.
  _ida.Stream<_ifi3b4wy.SquadRoomEvent> room(int squadId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ifi3b4wy.SquadRoomEvent>,
        _ifi3b4wy.SquadRoomEvent
      >(
        'squad',
        'room',
        {'squadId': squadId},
        {},
      );

  /// Sends a chat message in the squad room, persists it, and broadcasts to listeners.
  _ida.Future<_ifnfqe9v.SquadChatMessage> sendChat({
    required int squadId,
    required String userName,
    required String message,
  }) => caller.callServerEndpoint<_ifnfqe9v.SquadChatMessage>(
    'squad',
    'sendChat',
    {
      'squadId': squadId,
      'userName': userName,
      'message': message,
    },
  );

  /// Updates a member's focus presence and broadcasts updated status.
  _ida.Future<_iariawr2.SquadMember> updatePresence({
    required int squadId,
    required String userName,
    required bool isFocusing,
  }) => caller.callServerEndpoint<_iariawr2.SquadMember>(
    'squad',
    'updatePresence',
    {
      'squadId': squadId,
      'userName': userName,
      'isFocusing': isFocusing,
    },
  );

  /// Suggests squads scored by topic, time slot, and target exam with a "why you matched" explanation.
  _ida.Future<List<_ik57hy4d.SquadSuggestion>> suggest({
    required String topic,
    String? exam,
    String? timeSlot,
  }) => caller.callServerEndpoint<List<_ik57hy4d.SquadSuggestion>>(
    'squad',
    'suggest',
    {
      'topic': topic,
      'exam': exam,
      'timeSlot': timeSlot,
    },
  );

  /// Adds a user to a squad or returns their existing membership.
  _ida.Future<_iariawr2.SquadMember> join({
    required int squadId,
    required String userName,
    String? avatarUrl,
  }) => caller.callServerEndpoint<_iariawr2.SquadMember>(
    'squad',
    'join',
    {
      'squadId': squadId,
      'userName': userName,
      'avatarUrl': avatarUrl,
    },
  );

  /// Server owns the clock: sets the start time and focus duration in database.
  _ida.Future<_i1r9in2t.Squad> startTimer({
    required int squadId,
    int? durationSeconds,
  }) => caller.callServerEndpoint<_i1r9in2t.Squad>(
    'squad',
    'startTimer',
    {
      'squadId': squadId,
      'durationSeconds': durationSeconds,
    },
  );

  /// Fallback: 2-second polling endpoint. Fetches squad, members, and recent chat messages.
  _ida.Future<_ishbnsri.SquadDetails?> getSquad({required int squadId}) =>
      caller.callServerEndpoint<_ishbnsri.SquadDetails?>(
        'squad',
        'getSquad',
        {'squadId': squadId},
      );

  /// Lists all squads.
  _ida.Future<List<_i1r9in2t.Squad>> list() =>
      caller.callServerEndpoint<List<_i1r9in2t.Squad>>(
        'squad',
        'list',
        {},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_ii60tda0.Greeting> hello(String name) =>
      caller.callServerEndpoint<_ii60tda0.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    feed = EndpointFeed(this);
    profile = EndpointProfile(this);
    reel = EndpointReel(this);
    squad = EndpointSquad(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointFeed feed;

  late final EndpointProfile profile;

  late final EndpointReel reel;

  late final EndpointSquad squad;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'feed': feed,
    'profile': profile,
    'reel': reel,
    'squad': squad,
    'greeting': greeting,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
