import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../seed.dart';

class FeedEndpoint extends Endpoint {
  /// Returns all peer reels and campus events in one feed.
  Future<FeedResponse> get(Session session) async {
    await Seed.seedIfNeeded(session);

    final reels = await Reel.db.find(
      session,
      orderBy: (t) => t.id,
    );

    final events = await CampusEvent.db.find(
      session,
      orderBy: (t) => t.eventTime,
    );

    return FeedResponse(reels: reels, events: events);
  }
}
