import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huddle_client/huddle_client.dart';
import 'package:video_player/video_player.dart';
import '../../theme.dart';
import 'huddle_avatar.dart';
import 'huddle_button.dart';
import 'huddle_chip.dart';

/// 30-60s Peer Reel Card with video player, procedural creator avatar,
/// double-tap like pop, 3-question "Try it" quiz launcher, and "Study this together" CTA.
class ReelCard extends StatefulWidget {
  final Reel reel;
  final ValueChanged<String>? onStudyTogether;
  final VoidCallback? onOpenQuiz;

  const ReelCard({
    super.key,
    required this.reel,
    this.onStudyTogether,
    this.onOpenQuiz,
  });

  @override
  State<ReelCard> createState() => _ReelCardState();
}

class _ReelCardState extends State<ReelCard>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = true;
  bool _isLiked = false;

  late AnimationController _popController;
  late Animation<double> _popScale;
  late Animation<double> _popOpacity;
  bool _showPop = false;

  @override
  void initState() {
    super.initState();
    _popController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _popScale = Tween<double>(begin: 0.4, end: 1.4).animate(
      CurvedAnimation(parent: _popController, curve: Curves.easeOutBack),
    );
    _popOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _popController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    _popController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _showPop = false);
      }
    });

    _initVideo();
  }

  void _initVideo() async {
    try {
      final ctrl = VideoPlayerController.networkUrl(
        Uri.parse(widget.reel.videoUrl),
      );
      _controller = ctrl;
      await ctrl.initialize();
      await ctrl.setLooping(true);
      await ctrl.setVolume(1.0);
      await ctrl.play();
      if (mounted) setState(() => _isInitialized = true);
    } catch (_) {
      if (mounted) setState(() => _isInitialized = false);
    }
  }

  @override
  void dispose() {
    _popController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  void _onDoubleTap() {
    HapticFeedback.heavyImpact();
    setState(() {
      _isLiked = true;
      _showPop = true;
    });
    _popController.forward(from: 0.0);
  }

  void _togglePlay() {
    final ctrl = _controller;
    if (ctrl != null && _isInitialized) {
      setState(() {
        if (ctrl.value.isPlaying) {
          ctrl.pause();
          _isPlaying = false;
        } else {
          ctrl.play();
          _isPlaying = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = _controller;

    return Semantics(
      label:
          'Peer lesson: ${widget.reel.title} by ${widget.reel.creatorName}. Double tap to like.',
      child: Container(
        decoration: BoxDecoration(
          color: HuddleTheme.neonCard,
          borderRadius: HuddleTheme.radius14,
          border: HuddleTheme.borderCyanSubtle,
          boxShadow: const [HuddleTheme.shadowCyan],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Player Section
            GestureDetector(
              onTap: _togglePlay,
              onDoubleTap: _onDoubleTap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Container(
                      color: HuddleTheme.ink,
                      child: (_isInitialized && ctrl != null)
                          ? FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: ctrl.value.size.width,
                                height: ctrl.value.size.height,
                                child: VideoPlayer(ctrl),
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: HuddleTheme.highlight,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: HuddleTheme.ink,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.play_arrow_rounded,
                                      color: HuddleTheme.ink,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${widget.reel.subject.toUpperCase()} · ${widget.reel.durationSeconds}S',
                                    style: HuddleTheme.monoLabel(
                                      color: HuddleTheme.background,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),

                  // Pause indicator overlay
                  if (!_isPlaying && _isInitialized)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: HuddleTheme.ink.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: HuddleTheme.highlight,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.pause_rounded,
                        color: HuddleTheme.highlight,
                        size: 32,
                      ),
                    ),

                  // Double-tap Like Pop Animation
                  if (_showPop)
                    FadeTransition(
                      opacity: _popOpacity,
                      child: ScaleTransition(
                        scale: _popScale,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: HuddleTheme.highlight,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: HuddleTheme.ink,
                              width: 2,
                            ),
                            boxShadow: const [HuddleTheme.shadow],
                          ),
                          child: const Icon(
                            Icons.favorite_rounded,
                            color: HuddleTheme.ink,
                            size: 48,
                          ),
                        ),
                      ),
                    ),

                  // Top Chips: Subject + Duration
                  Positioned(
                    top: 14,
                    left: 14,
                    right: 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HuddleChip(
                          label: widget.reel.subject,
                          isHighlight: true,
                          icon: HuddleTheme.iconForTopic(widget.reel.subject),
                        ),
                        HuddleChip(
                          label: '${widget.reel.durationSeconds}S REEL',
                          icon: Icons.timer_rounded,
                        ),
                      ],
                    ),
                  ),

                  // Video scrubbing progress bar along the bottom of the video
                  if (_isInitialized && ctrl != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ValueListenableBuilder(
                        valueListenable: ctrl,
                        builder: (context, VideoPlayerValue val, _) {
                          final duration = val.duration.inMilliseconds;
                          final pos = val.position.inMilliseconds;
                          final ratio = duration > 0
                              ? (pos / duration).clamp(0.0, 1.0)
                              : 0.0;
                          return LinearProgressIndicator(
                            value: ratio,
                            minHeight: 4,
                            backgroundColor: HuddleTheme.ink.withValues(
                              alpha: 0.5,
                            ),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              HuddleTheme.accent,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),

            // Card Bottom Control & Context Panel
            Container(
              padding: const EdgeInsets.all(16),
              color: HuddleTheme.neonCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Creator Avatar & Info Row
                  Row(
                    children: [
                      HuddleAvatar.medium(
                        name: widget.reel.creatorName,
                        isOnline: true,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.reel.creatorName,
                              style: HuddleTheme.body14(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Peer Educator · Campus TA',
                              style: HuddleTheme.monoLabel(
                                color: HuddleTheme.neonTextMuted,
                              ).copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: _isLiked ? 'Liked' : 'Like reel',
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          setState(() => _isLiked = !_isLiked);
                        },
                        icon: Icon(
                          _isLiked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: _isLiked
                              ? HuddleTheme.neonMagenta
                              : HuddleTheme.neonTextMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Reel Title Headline
                  Text(
                    widget.reel.title,
                    style: HuddleTheme.heading20(color: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  // CTA Action Buttons: "Try it" & "Study this together"
                  Row(
                    children: [
                      Expanded(
                        child: HuddleButton(
                          text: 'Try it',
                          icon: Icons.quiz_rounded,
                          variant: HuddleButtonVariant.neon,
                          onPressed: widget.onOpenQuiz,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: HuddleButton(
                          text: 'Study together',
                          icon: Icons.groups_rounded,
                          variant: HuddleButtonVariant.neonSubtle,
                          onPressed: () => widget.onStudyTogether?.call(
                            widget.reel.suggestedSquadTopic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
