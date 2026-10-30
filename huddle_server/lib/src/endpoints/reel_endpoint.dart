import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../seed.dart';

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
}
