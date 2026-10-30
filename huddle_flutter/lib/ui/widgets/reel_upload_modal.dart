import 'dart:async';
import 'package:flutter/material.dart';
import 'package:huddle_client/huddle_client.dart';
import '../../services/api_service.dart';
import '../../services/tech_domain_validator.dart';
import '../../services/user_service.dart';
import '../../theme.dart';
import 'huddle_button.dart';
import 'huddle_card.dart';
import 'huddle_chip.dart';

/// Modal dialog for uploading a new micro-lesson Reel with real-time
/// Machine Learning domain validation that strictly enforces technical content.
class ReelUploadModal extends StatefulWidget {
  final Function(Reel newReel)? onReelCreated;

  const ReelUploadModal({super.key, this.onReelCreated});

  static Future<void> show(
    BuildContext context, {
    Function(Reel newReel)? onReelCreated,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ReelUploadModal(onReelCreated: onReelCreated),
      ),
    );
  }

  @override
  State<ReelUploadModal> createState() => _ReelUploadModalState();
}

class _ReelUploadModalState extends State<ReelUploadModal> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _examController = TextEditingController(text: 'Placements');
  final _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  int _correctOptionIndex = 0;
  String _selectedSubject = 'DSA';

  final List<String> _availableSubjects = [
    'DSA',
    'Machine Learning',
    'Systems & OS',
    'Database & SQL',
    'Web & Mobile',
    'Cloud & Security',
  ];

  ReelValidationResult? _validationResult;
  bool _isAnalyzing = false;
  bool _isPublishing = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    // Default initial tech template
    _loadPresetTechDSA();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _titleController.dispose();
    _contentController.dispose();
    _examController.dispose();
    _questionController.dispose();
    for (final c in _optionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onInputChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 280), () {
      _runMLValidation();
    });
  }

  void _runMLValidation() {
    if (!mounted) return;
    setState(() => _isAnalyzing = true);

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    final result = TechDomainValidator.validateContent(
      title: title,
      subject: _selectedSubject,
      content: content,
    );

    if (mounted) {
      setState(() {
        _validationResult = result;
        _isAnalyzing = false;
      });
    }
  }

  // Presets for quick evaluation of ML Gatekeeper
  void _loadPresetTechDSA() {
    _selectedSubject = 'DSA';
    _titleController.text = 'LRU Cache implementation with Doubly Linked List';
    _contentController.text =
        'An LRU (Least Recently Used) cache organizes items in order of use. '
        'Using a hash map for O(1) key-node lookup combined with a doubly linked list '
        'allows O(1) eviction of the tail and moving accessed nodes to the head. '
        'Time complexity: O(1) for both get and put operations.';
    _examController.text = 'LeetCode Sprint';
    _questionController.text =
        'What data structure enables O(1) node relocation in an LRU cache?';
    _optionControllers[0].text = 'Doubly Linked List';
    _optionControllers[1].text = 'Min-Heap Priority Queue';
    _optionControllers[2].text = 'Sorted Binary Array';
    _optionControllers[3].text = 'Adjacency Matrix';
    _correctOptionIndex = 0;
    _runMLValidation();
  }

  void _loadPresetTechML() {
    _selectedSubject = 'Machine Learning';
    _titleController.text = 'Gradient Descent & Learning Rate Explained';
    _contentController.text =
        'Gradient Descent optimizes neural network weights by minimizing the loss function. '
        'We calculate the partial derivatives via backpropagation and update parameters in the '
        'opposite direction of the gradient. A high learning rate causes divergence, while a low '
        'rate slows convergence.';
    _examController.text = 'Deep Learning Lab';
    _questionController.text =
        'What happens when the learning rate is set excessively high?';
    _optionControllers[0].text = 'Loss diverges or oscillates wildly';
    _optionControllers[1].text = 'Weights vanish to exact zero';
    _optionControllers[2].text = 'Batch normalization is skipped';
    _optionControllers[3].text = 'Model overfits instantly';
    _correctOptionIndex = 0;
    _runMLValidation();
  }

  void _loadPresetNonTechLifestyle() {
    _selectedSubject = 'DSA';
    _titleController.text = 'My college morning routine & outfit of the day';
    _contentController.text =
        'Get ready with me for college! Sharing my daily morning routine, aesthetic room decor, '
        'favorite skincare products, and outfit haul before heading out for coffee with friends.';
    _examController.text = 'Campus Life';
    _questionController.text = 'What is the best part of the morning?';
    _optionControllers[0].text = 'Coffee';
    _optionControllers[1].text = 'Outfit check';
    _optionControllers[2].text = 'Skincare';
    _optionControllers[3].text = 'Music';
    _correctOptionIndex = 0;
    _runMLValidation();
  }

  void _loadPresetNonTechGaming() {
    _selectedSubject = 'Systems & OS';
    _titleController.text = 'Insane 1v5 clutch gameplay montage in BGMI';
    _contentController.text =
        'Watch this crazy battle royale gameplay! Headshot montage, squad wipe clutch, '
        'and winning the chicken dinner in ranked lobby with high killstreak.';
    _examController.text = 'Esports';
    _questionController.text = 'Which weapon had the fastest kill time?';
    _optionControllers[0].text = 'Sniper Rifle';
    _optionControllers[1].text = 'Shotgun';
    _optionControllers[2].text = 'Assault Rifle';
    _optionControllers[3].text = 'SMG';
    _correctOptionIndex = 0;
    _runMLValidation();
  }

  Future<void> _publishReel() async {
    final result = _validationResult;
    if (result == null || !result.isTechDomain) return;

    setState(() => _isPublishing = true);

    final questions = [
      QuizQuestion(
        question: _questionController.text.trim().isNotEmpty
            ? _questionController.text.trim()
            : 'Key takeaway of this micro-lesson?',
        options: _optionControllers.map((c) => c.text.trim()).toList(),
        correctOptionIndex: _correctOptionIndex,
        explanation: 'Core concept verified by ML tech classifier.',
      ),
    ];

    final newReel = Reel(
      title: _titleController.text.trim(),
      creatorName: UserService.instance.currentUser.value,
      subject: _selectedSubject,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      durationSeconds: 50,
      suggestedSquadTopic: _examController.text.trim().isNotEmpty
          ? _examController.text.trim()
          : _selectedSubject,
      quizQuestions: questions,
    );

    final uploadRes = await ApiService.instance.uploadReel(
      reel: newReel,
      content: _contentController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isPublishing = false);

    if (uploadRes.isValid && uploadRes.validatedReel != null) {
      widget.onReelCreated?.call(uploadRes.validatedReel!);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: HuddleTheme.neonCard,
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: HuddleTheme.neonCyan),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Tech Reel Approved & Published (${uploadRes.detectedDomain})!',
                  style: HuddleTheme.monoLabel(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF3B0715),
          content: Text(
            uploadRes.reason,
            style: HuddleTheme.monoLabel(color: HuddleTheme.neonMagenta),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = _validationResult;
    final isApproved = result != null && result.isTechDomain;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820, maxHeight: 780),
        child: Container(
          decoration: BoxDecoration(
            color: HuddleTheme.neonBg,
            borderRadius: HuddleTheme.radius14,
            border: Border.all(
              color: isApproved ? HuddleTheme.neonCyan : HuddleTheme.neonMagenta,
              width: 1.8,
            ),
            boxShadow: [
              BoxShadow(
                color: (isApproved
                        ? HuddleTheme.neonCyan
                        : HuddleTheme.neonMagenta)
                    .withValues(alpha: 0.35),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Header with ML Guardian Badge
              _buildHeader(),

              // 2. Quick Presets Bar
              _buildPresetsBar(),

              // 3. Scrollable Form & ML Analysis Engine
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Live ML Status Card
                      _buildMLStatusCard(result),
                      const SizedBox(height: 20),

                      // Form Fields
                      _buildFormFields(),
                    ],
                  ),
                ),
              ),

              // 4. Modal Footer with Actions
              _buildFooter(isApproved),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: HuddleTheme.neonCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        border: Border(
          bottom: BorderSide(color: Color(0x3300F0FF), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: HuddleTheme.navy,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: HuddleTheme.neonCyan),
                ),
                child: const Icon(
                  Icons.smart_toy_rounded,
                  color: HuddleTheme.neonCyan,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UPLOAD PEER REEL',
                    style: HuddleTheme.heading20(color: Colors.white)
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'AI ML DOMAIN GUARDIAN · STRICT TECH POLICY',
                    style: HuddleTheme.monoLabel(
                      color: HuddleTheme.neonTextMuted,
                    ).copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.white70),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      color: HuddleTheme.neonCardAlt,
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'TEST PRESETS:',
            style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan)
                .copyWith(fontSize: 10),
          ),
          ActionChip(
            backgroundColor: const Color(0xFF162547),
            side: const BorderSide(color: HuddleTheme.neonCyan, width: 1),
            label: Text(
              '✅ Tech: DSA Cache',
              style: HuddleTheme.monoLabel(color: Colors.white).copyWith(fontSize: 11),
            ),
            onPressed: _loadPresetTechDSA,
          ),
          ActionChip(
            backgroundColor: const Color(0xFF162547),
            side: const BorderSide(color: HuddleTheme.neonCyan, width: 1),
            label: Text(
              '✅ Tech: ML Gradients',
              style: HuddleTheme.monoLabel(color: Colors.white).copyWith(fontSize: 11),
            ),
            onPressed: _loadPresetTechML,
          ),
          ActionChip(
            backgroundColor: const Color(0xFF3A1224),
            side: const BorderSide(color: HuddleTheme.neonMagenta, width: 1),
            label: Text(
              '❌ Non-Tech: Outfit Vlog',
              style: HuddleTheme.monoLabel(color: Colors.white).copyWith(fontSize: 11),
            ),
            onPressed: _loadPresetNonTechLifestyle,
          ),
          ActionChip(
            backgroundColor: const Color(0xFF3A1224),
            side: const BorderSide(color: HuddleTheme.neonMagenta, width: 1),
            label: Text(
              '❌ Non-Tech: Gaming Stream',
              style: HuddleTheme.monoLabel(color: Colors.white).copyWith(fontSize: 11),
            ),
            onPressed: _loadPresetNonTechGaming,
          ),
        ],
      ),
    );
  }

  Widget _buildMLStatusCard(ReelValidationResult? result) {
    if (result == null) {
      return const SizedBox.shrink();
    }

    final isApproved = result.isTechDomain;
    final accentColor = isApproved ? HuddleTheme.neonCyan : HuddleTheme.neonMagenta;
    final bgColor = isApproved ? const Color(0xFF071F2D) : const Color(0xFF2C091A);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: HuddleTheme.radius14,
        border: Border.all(color: accentColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.25),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isApproved ? Icons.verified_rounded : Icons.gpp_bad_rounded,
                color: accentColor,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  isApproved
                      ? 'ML DOMAIN VERIFIED · APPROVED FOR UPLOAD'
                      : 'ML GUARDIAN REJECTION · NON-TECH DOMAIN',
                  style: HuddleTheme.monoLabel(color: accentColor).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              if (_isAnalyzing)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: HuddleTheme.neonCyan,
                  ),
                )
              else
                HuddleChip(
                  label: '${(result.confidenceScore * 100).toInt()}% CONFIDENCE',
                  variant: isApproved
                      ? HuddleChipVariant.neon
                      : HuddleChipVariant.neonDark,
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            result.reason,
            style: HuddleTheme.body14(color: Colors.white).copyWith(fontSize: 13),
          ),
          if (result.suggestion != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0x44FF2A85)),
              ),
              child: Text(
                result.suggestion!,
                style: HuddleTheme.monoLabel(color: const Color(0xFFFFB3D1))
                    .copyWith(fontSize: 11),
              ),
            ),
          ],
          if (result.technicalKeywords.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: result.technicalKeywords
                  .take(6)
                  .map(
                    (kw) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: HuddleTheme.navy,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0x5500F0FF)),
                      ),
                      child: Text(
                        '#$kw',
                        style: HuddleTheme.monoLabel(
                          color: HuddleTheme.neonCyan,
                        ).copyWith(fontSize: 10),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Subject Selector
        Text(
          'TECH CATEGORY',
          style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan)
              .copyWith(fontSize: 11),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: HuddleTheme.neonCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0x4400F0FF)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSubject,
              dropdownColor: HuddleTheme.neonCard,
              isExpanded: true,
              style: HuddleTheme.body14(color: Colors.white),
              items: _availableSubjects
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedSubject = val);
                  _onInputChanged();
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Title Input
        Text(
          'REEL TITLE',
          style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan)
              .copyWith(fontSize: 11),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _titleController,
          onChanged: (_) => _onInputChanged(),
          style: HuddleTheme.body14(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'e.g. Dijkstra algorithm in 45s',
            hintStyle: HuddleTheme.body14(color: Colors.white30),
            filled: true,
            fillColor: HuddleTheme.neonCard,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0x4400F0FF)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0x4400F0FF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: HuddleTheme.neonCyan, width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Content / Transcript
        Text(
          'LESSON TRANSCRIPT / EXPLANATION (MONITORED BY ML)',
          style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan)
              .copyWith(fontSize: 11),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _contentController,
          onChanged: (_) => _onInputChanged(),
          maxLines: 4,
          style: HuddleTheme.body14(color: Colors.white),
          decoration: InputDecoration(
            hintText:
                'Write or paste your micro-lesson explanation, code summary, or algorithm breakdown...',
            hintStyle: HuddleTheme.body14(color: Colors.white30),
            filled: true,
            fillColor: HuddleTheme.neonCard,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0x4400F0FF)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0x4400F0FF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: HuddleTheme.neonCyan, width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Quiz Question Section
        HuddleCard(
          color: HuddleTheme.neonCard,
          border: Border.all(color: const Color(0x3300F0FF)),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TRY IT QUIZ QUESTION',
                style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan)
                    .copyWith(fontSize: 11),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _questionController,
                style: HuddleTheme.body14(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter a 1-question check for peers...',
                  hintStyle: HuddleTheme.body14(color: Colors.white30),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'OPTIONS (SELECT CORRECT ANSWER):',
                style: HuddleTheme.monoLabel(color: HuddleTheme.neonTextMuted)
                    .copyWith(fontSize: 10),
              ),
              const SizedBox(height: 6),
              ...List.generate(4, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      // ignore: deprecated_member_use
                      Radio<int>(
                        value: i,
                        // ignore: deprecated_member_use
                        groupValue: _correctOptionIndex,
                        activeColor: HuddleTheme.neonCyan,
                        // ignore: deprecated_member_use
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _correctOptionIndex = val);
                          }
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: _optionControllers[i],
                          style: HuddleTheme.body14(color: Colors.white)
                              .copyWith(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Option ${i + 1}',
                            hintStyle: HuddleTheme.body14(color: Colors.white30),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(bool isApproved) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: HuddleTheme.neonCard,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        border: Border(
          top: BorderSide(color: Color(0x3300F0FF), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isApproved
                ? '✅ AI Approved: Ready to publish'
                : '⛔ Locked: Non-tech content disallowed',
            style: HuddleTheme.monoLabel(
              color: isApproved ? HuddleTheme.neonCyan : HuddleTheme.neonMagenta,
            ).copyWith(fontSize: 11),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: HuddleTheme.monoLabel(color: Colors.white70),
                ),
              ),
              const SizedBox(width: 12),
              HuddleButton(
                text: _isPublishing ? 'Publishing...' : 'Publish Tech Reel',
                icon: Icons.cloud_upload_rounded,
                variant: isApproved
                    ? HuddleButtonVariant.neon
                    : HuddleButtonVariant.subtle,
                onPressed: isApproved && !_isPublishing ? _publishReel : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

