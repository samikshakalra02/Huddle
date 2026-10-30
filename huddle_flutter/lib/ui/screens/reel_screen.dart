import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:huddle_client/huddle_client.dart';
import '../../data/fake_data.dart';
import '../../services/api_service.dart';
import '../../theme.dart';
import '../widgets/huddle_button.dart';
import '../widgets/huddle_card.dart';
import '../widgets/huddle_chip.dart';
import '../widgets/reel_card.dart';
import '../widgets/reel_upload_modal.dart';
import 'try_it_sheet.dart';

class ReelScreen extends StatefulWidget {
  final int initialReelId;

  const ReelScreen({super.key, this.initialReelId = 1});

  @override
  State<ReelScreen> createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  late PageController _pageController;
  List<Reel> _reels = [];
  bool _isLoading = true;
  String? _errorMessage;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadReels();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadReels() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final feed = await ApiService.instance.getFeed();
      if (mounted) {
        setState(() {
          _reels = feed.reels.isNotEmpty ? feed.reels : FakeData.reels;
          _isLoading = false;
        });
        _jumpToInitial();
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _reels = FakeData.reels;
          _isLoading = false;
        });
        _jumpToInitial();
      }
    }
  }

  void _jumpToInitial() {
    final idx = _reels.indexWhere((r) => r.id == widget.initialReelId);
    if (idx != -1 && idx != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          _pageController.jumpToPage(idx);
        }
      });
    }
  }

  void _onStudyTogether(String topic) {
    context.go('/match?topic=${Uri.encodeComponent(topic)}');
  }

  void _openQuiz(Reel reel) {
    TryItSheet.show(
      context,
      reel: reel,
      onFindSquad: _onStudyTogether,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HuddleTheme.neonBg,
      appBar: AppBar(
        backgroundColor: HuddleTheme.neonBg,
        title: Text(
          'REEL VIEWER',
          style: HuddleTheme.monoLabel(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: HuddleButton(
              text: 'Upload Tech Reel',
              icon: Icons.add_circle_outline_rounded,
              variant: HuddleButtonVariant.neon,
              onPressed: () => ReelUploadModal.show(
                context,
                onReelCreated: (newReel) {
                  setState(() {
                    _reels.insert(0, newReel);
                    _currentIndex = 0;
                  });
                  _jumpToInitial();
                },
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/feed'),
        ),
      ),
      body: CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          const SingleActivator(LogicalKeyboardKey.arrowDown): () {
            if (_currentIndex < _reels.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
              );
            }
          },
          const SingleActivator(LogicalKeyboardKey.arrowUp): () {
            if (_currentIndex > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
              );
            }
          },
        },
        child: Focus(
          autofocus: true,
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: Container(
          width: 380,
          height: 560,
          decoration: BoxDecoration(
            color: HuddleTheme.neonCard,
            borderRadius: HuddleTheme.radius14,
            border: Border.all(color: HuddleTheme.neonCyan, width: 1.5),
            boxShadow: const [HuddleTheme.shadowCyanGlow],
          ),
          child: Center(
            child: Text(
              'LOADING REELS...',
              style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan),
            ),
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'FAILED TO LOAD REEL',
              style: HuddleTheme.heading20(color: Colors.white),
            ),
            const SizedBox(height: 12),
            HuddleButton(
              text: 'Run it back',
              icon: Icons.refresh_outlined,
              variant: HuddleButtonVariant.neon,
              onPressed: _loadReels,
            ),
          ],
        ),
      );
    }

    if (_reels.isEmpty) {
      return Center(
        child: Text(
          'NO REELS AVAILABLE',
          style: HuddleTheme.heading20(color: Colors.white),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLaptop = constraints.maxWidth >= 960;

        if (isLaptop) {
          final activeReel = _reels.isNotEmpty ? _reels[_currentIndex] : null;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Campus Playlist (Flex 4)
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CAMPUS MICRO-LESSONS',
                          style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan)
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        for (int i = 0; i < _reels.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () {
                                _pageController.jumpToPage(i);
                                setState(() => _currentIndex = i);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: i == _currentIndex
                                      ? HuddleTheme.neonCyan.withValues(alpha: 0.18)
                                      : HuddleTheme.neonCard,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: i == _currentIndex
                                        ? HuddleTheme.neonCyan
                                        : Colors.white12,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: i == _currentIndex
                                            ? HuddleTheme.neonCyan
                                            : HuddleTheme.neonCardAlt,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        i == _currentIndex
                                            ? Icons.play_arrow_rounded
                                            : Icons.movie_outlined,
                                        color: i == _currentIndex
                                            ? HuddleTheme.neonBg
                                            : Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _reels[i].title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: HuddleTheme.body14(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            '${_reels[i].subject} · ${_reels[i].durationSeconds}s · by ${_reels[i].creatorName}',
                                            style: HuddleTheme.monoLabel(
                                              color: HuddleTheme.neonTextMuted,
                                            ).copyWith(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),

                // Center Column: Active Reel Player Card (440px)
                SizedBox(
                  width: 440,
                  height: constraints.maxHeight - 32,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: _reels.length,
                    onPageChanged: (idx) => setState(() => _currentIndex = idx),
                    itemBuilder: (context, index) {
                      final reel = _reels[index];
                      return ReelCard(
                        reel: reel,
                        onStudyTogether: _onStudyTogether,
                        onOpenQuiz: () => _openQuiz(reel),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 24),

                // Right Column: Study Sprint & Instant Quiz Actions (Flex 4)
                if (activeReel != null)
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HuddleCard(
                            color: HuddleTheme.neonCard,
                            border: HuddleTheme.borderCyanSubtle,
                            boxShadow: const [HuddleTheme.shadowCyanGlow],
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const HuddleChip(
                                      label: 'TRY IT QUIZ',
                                      variant: HuddleChipVariant.neon,
                                    ),
                                    Text(
                                      '${activeReel.quizQuestions.length} QUESTIONS',
                                      style: HuddleTheme.monoLabel(
                                        color: HuddleTheme.neonTextMuted,
                                      ).copyWith(fontSize: 10),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  activeReel.title,
                                  style: HuddleTheme.heading20(color: Colors.white),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Taught by @${activeReel.creatorName.toLowerCase()} · ${activeReel.subject}',
                                  style: HuddleTheme.monoLabel(
                                    color: HuddleTheme.neonCyan,
                                  ).copyWith(fontSize: 11),
                                ),
                                const SizedBox(height: 18),
                                HuddleButton(
                                  text: 'Take Try It Quiz',
                                  icon: Icons.psychology_outlined,
                                  variant: HuddleButtonVariant.neon,
                                  onPressed: () => _openQuiz(activeReel),
                                ),
                                const SizedBox(height: 12),
                                HuddleButton(
                                  text: 'Study This Together',
                                  icon: Icons.groups_rounded,
                                  variant: HuddleButtonVariant.neonSubtle,
                                  onPressed: () => _onStudyTogether(
                                    activeReel.suggestedSquadTopic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          HuddleCard(
                            color: HuddleTheme.neonCardAlt,
                            border: Border.all(color: const Color(0x3300F0FF)),
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.smart_toy_rounded,
                                      color: HuddleTheme.neonCyan,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'ML DOMAIN GUARDIAN',
                                      style: HuddleTheme.monoLabel(
                                        color: HuddleTheme.neonCyan,
                                      ).copyWith(fontSize: 11),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Only Computer Science & Engineering reels are accepted. Test the ML classifier or upload your own.',
                                  style: HuddleTheme.body14(
                                    color: HuddleTheme.neonTextMuted,
                                  ).copyWith(fontSize: 12),
                                ),
                                const SizedBox(height: 14),
                                HuddleButton(
                                  text: 'Upload & Validate Reel',
                                  icon: Icons.upload_file_rounded,
                                  variant: HuddleButtonVariant.neon,
                                  onPressed: () => ReelUploadModal.show(
                                    context,
                                    onReelCreated: (newReel) {
                                      setState(() {
                                        _reels.insert(0, newReel);
                                        _currentIndex = 0;
                                      });
                                      _jumpToInitial();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 420,
              maxHeight: constraints.maxHeight,
            ),
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: _reels.length,
              onPageChanged: (idx) => setState(() => _currentIndex = idx),
              itemBuilder: (context, index) {
                final reel = _reels[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ReelCard(
                    reel: reel,
                    onStudyTogether: _onStudyTogether,
                    onOpenQuiz: () => _openQuiz(reel),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
