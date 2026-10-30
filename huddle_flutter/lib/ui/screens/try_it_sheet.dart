import 'dart:async';
import 'package:flutter/material.dart';
import 'package:huddle_client/huddle_client.dart';
import '../../services/api_service.dart';
import '../../theme.dart';
import '../widgets/huddle_button.dart';
import '../widgets/huddle_chip.dart';
import '../widgets/quiz_option.dart';

class TryItSheet extends StatefulWidget {
  final Reel reel;
  final ValueChanged<String> onFindSquad;

  const TryItSheet({
    super.key,
    required this.reel,
    required this.onFindSquad,
  });

  static Future<void> show(
    BuildContext context, {
    required Reel reel,
    required ValueChanged<String> onFindSquad,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TryItSheet(
        reel: reel,
        onFindSquad: onFindSquad,
      ),
    );
  }

  @override
  State<TryItSheet> createState() => _TryItSheetState();
}

class _TryItSheetState extends State<TryItSheet> {
  int _currentQuestionIndex = 0;
  int? _selectedOption;
  bool _hasSubmitted = false;
  int _score = 0;
  bool _isFinished = false;

  void _selectOption(int index) {
    if (_hasSubmitted) return;
    setState(() => _selectedOption = index);
  }

  void _submitAnswer() {
    final selected = _selectedOption;
    if (selected == null || _hasSubmitted) return;

    final q = widget.reel.quizQuestions[_currentQuestionIndex];
    final isCorrect = selected == q.correctOptionIndex;

    setState(() {
      _hasSubmitted = true;
      if (isCorrect) _score++;
    });

    final reelId = widget.reel.id ?? 1;
    unawaited(
      ApiService.instance.submitQuiz(
        reelId: reelId,
        selectedAnswers: [selected],
        reel: widget.reel,
      ),
    );
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.reel.quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
        _hasSubmitted = false;
      });
    } else {
      setState(() => _isFinished = true);
    }
  }

  void _runItBack() {
    setState(() {
      _currentQuestionIndex = 0;
      _selectedOption = null;
      _hasSubmitted = false;
      _score = 0;
      _isFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.reel.quizQuestions;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: HuddleTheme.neonCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(
          top: BorderSide(color: HuddleTheme.neonCyan, width: 1.5),
          left: BorderSide(color: HuddleTheme.neonCyan, width: 1.5),
          right: BorderSide(color: HuddleTheme.neonCyan, width: 1.5),
        ),
        boxShadow: const [HuddleTheme.shadowCyanGlow],
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: _isFinished
              ? _buildResultView()
              : _buildQuestionView(questions),
        ),
      ),
    );
  }

  Widget _buildQuestionView(List<QuizQuestion> questions) {
    if (questions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'NO QUESTIONS FOR THIS REEL',
            style: HuddleTheme.heading20(color: Colors.white),
          ),
        ),
      );
    }

    final q = questions[_currentQuestionIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Sheet Drag Handle
        Center(
          child: Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: HuddleTheme.neonCyan.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Header: TRY IT QUIZ + Score Counter
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const HuddleChip.sticker(
                  label: 'TRY IT QUIZ',
                  variant: HuddleChipVariant.neon,
                ),
                const SizedBox(width: 8),
                Text(
                  'Q${_currentQuestionIndex + 1} OF ${questions.length}',
                  style: HuddleTheme.monoLabel(color: HuddleTheme.neonTextMuted),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: HuddleTheme.neonCardAlt,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: HuddleTheme.neonCyan, width: 1.5),
              ),
              child: Text(
                '$_score/${questions.length} PTS',
                style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Question Headline
        Semantics(
          header: true,
          label:
              'Question ${_currentQuestionIndex + 1} of ${questions.length}: ${q.question}',
          child: Text(
            'Q${_currentQuestionIndex + 1}. ${q.question}',
            style: HuddleTheme.heading20(color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),

        // Option Cards
        for (int idx = 0; idx < q.options.length; idx++) ...[
          QuizOption(
            index: idx,
            text: q.options[idx],
            isSelected: _selectedOption == idx,
            isCorrect: idx == q.correctOptionIndex,
            hasSubmitted: _hasSubmitted,
            onTap: () => _selectOption(idx),
          ),
          const SizedBox(height: 10),
        ],

        // Explanation text on submit
        if (_hasSubmitted) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: HuddleTheme.neonCardAlt,
              borderRadius: HuddleTheme.radius14,
              border: Border.all(
                color: HuddleTheme.neonCyan.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: HuddleTheme.neonCyan,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    q.explanation ?? '',
                    style: HuddleTheme.body14(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 16),

        // Bottom CTA Button
        SizedBox(
          width: double.infinity,
          child: _hasSubmitted
              ? HuddleButton(
                  text: _currentQuestionIndex < questions.length - 1
                      ? 'Next Question'
                      : 'See Results',
                  icon: Icons.arrow_forward_rounded,
                  variant: HuddleButtonVariant.neon,
                  onPressed: _nextQuestion,
                )
              : HuddleButton(
                  text: 'Lock In Answer',
                  icon: Icons.check_rounded,
                  variant: _selectedOption != null
                      ? HuddleButtonVariant.neon
                      : HuddleButtonVariant.neonSubtle,
                  onPressed: _selectedOption != null ? _submitAnswer : null,
                ),
        ),
      ],
    );
  }

  Widget _buildResultView() {
    final total = widget.reel.quizQuestions.length;
    final passed = _score >= (total * 0.6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: HuddleTheme.neonCyan.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
        const SizedBox(height: 18),

        Center(
          child: HuddleChip.sticker(
            label: passed ? 'LOCKED IN · MASTERED' : 'KEEP GRINDING',
            variant: HuddleChipVariant.neon,
          ),
        ),
        const SizedBox(height: 14),

        Center(
          child: Text(
            '$_score OF $total SCORED',
            style: HuddleTheme.displayTitle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),

        Center(
          child: Text(
            passed
                ? 'High recall! You locked in this concept.'
                : 'Run it back or study this with a squad to master it.',
            textAlign: TextAlign.center,
            style: HuddleTheme.body16(color: HuddleTheme.neonTextMuted),
          ),
        ),
        const SizedBox(height: 20),

        // Action Buttons Row
        Row(
          children: [
            Expanded(
              child: HuddleButton(
                text: 'Run it back',
                icon: Icons.refresh_rounded,
                variant: HuddleButtonVariant.neonSubtle,
                onPressed: _runItBack,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: HuddleButton(
                text: 'Find squad',
                icon: Icons.groups_rounded,
                variant: HuddleButtonVariant.neon,
                onPressed: () {
                  Navigator.pop(context);
                  widget.onFindSquad(widget.reel.suggestedSquadTopic);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
