import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../seed.dart';
import '../services/tech_domain_validator.dart';

class ReelEndpoint extends Endpoint {
  /// Evaluates submitted quiz answers, computes score, and returns suggested squad topic.
  Future<QuizResult> submitQuiz(
    Session session, {
    required int reelId,
    required List<int> selectedAnswers,
  }) async {
    await Seed.seedIfNeeded(session);

    final reel = await Reel.db.findById(session, reelId);
    if (reel == null) {
      throw ArgumentError('Reel with id $reelId not found');
    }

    int score = 0;
    final questions = reel.quizQuestions;
    for (var i = 0; i < questions.length && i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == questions[i].correctOptionIndex) {
        score++;
      }
    }

    final total = questions.length;
    final passed = total > 0 && (score >= (total * 0.6));
    final feedback = passed
        ? 'Great job! You mastered this concept.'
        : 'Keep practicing! Join a squad to study ${reel.suggestedSquadTopic} together.';

    return QuizResult(
      score: score,
      totalQuestions: total,
      passed: passed,
      suggestedSquadTopic: reel.suggestedSquadTopic,
      feedback: feedback,
    );
  }

  /// ML-Powered Tech Domain Pre-Validation
  /// Analyzes the reel title, subject, and transcript/content summary before upload.
  /// Rejects non-tech domains (lifestyle, dance, gaming streams, gossip) and approves
  /// verified engineering/CS topics with confidence scores.
  Future<ReelValidationResult> validateReel(
    Session session, {
    required String title,
    required String subject,
    required String content,
  }) async {
    return TechDomainValidator.validateContent(
      title: title,
      subject: subject,
      content: content,
    );
  }

  /// Validates and securely uploads a new micro-lesson Reel.
  /// Enforces that only verified tech-domain reels pass the ML gatekeeper.
  Future<ReelValidationResult> uploadReel(
    Session session, {
    required Reel reel,
    required String content,
  }) async {
    await Seed.seedIfNeeded(session);

    // 1. Run ML domain validation
    final validation = TechDomainValidator.validateContent(
      title: reel.title,
      subject: reel.subject,
      content: content,
      reel: reel,
    );

    // 2. Reject non-tech uploads
    if (!validation.isTechDomain || !validation.isValid) {
      return validation;
    }

    // 3. Persist approved tech reel to database
    final inserted = await Reel.db.insertRow(session, reel);

    return ReelValidationResult(
      isValid: true,
      isTechDomain: true,
      confidenceScore: validation.confidenceScore,
      detectedDomain: validation.detectedDomain,
      technicalKeywords: validation.technicalKeywords,
      reason: validation.reason,
      suggestion: null,
      validatedReel: inserted,
    );
  }
}
