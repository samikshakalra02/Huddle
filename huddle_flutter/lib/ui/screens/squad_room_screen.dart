import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:huddle_client/huddle_client.dart';
import '../../data/fake_data.dart';
import '../../services/api_service.dart';
import '../../services/user_service.dart';
import '../../theme.dart';
import '../widgets/huddle_avatar.dart';
import '../widgets/huddle_button.dart';
import '../widgets/huddle_card.dart';
import '../widgets/huddle_chip.dart';
import '../widgets/section_label.dart';
import '../widgets/streak_counter.dart';
import '../widgets/timer_ring.dart';

class SquadRoomScreen extends StatefulWidget {
  final int squadId;

  const SquadRoomScreen({super.key, this.squadId = 1});

  @override
  State<SquadRoomScreen> createState() => _SquadRoomScreenState();
}

class _SquadRoomScreenState extends State<SquadRoomScreen> {
  Squad? _squad;
  List<SquadMember> _members = [];
  final List<SquadChatMessage> _messages = [];
  bool _isLoading = true;

  StreamSubscription<SquadRoomEvent>? _roomSub;
  Timer? _ticker;
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isLocalFocusing = false;

  @override
  void initState() {
    super.initState();
    _connectRoom();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final started = _squad?.timerStartedAt;
      if (mounted && started != null) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _roomSub?.cancel();
    _ticker?.cancel();
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _connectRoom() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final details = await ApiService.instance.getSquad(
        squadId: widget.squadId,
      );
      if (mounted) {
        setState(() {
          _squad = details.squad;
          _members = details.members;
          final msgs = details.recentMessages;
          if (msgs != null && msgs.isNotEmpty) {
            _messages.clear();
            _messages.addAll(msgs);
          }
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _squad = FakeData.squadSuggestions.first.squad;
          _members = FakeData.roomMembers;
          _messages.clear();
          _messages.addAll(FakeData.roomMessages);
          _isLoading = false;
        });
      }
    }

    try {
      final stream = ApiService.instance.getSquadRoomStream(widget.squadId);
      if (stream != null) {
        _roomSub = stream.listen(
          _handleEvent,
          onError: (_) {},
        );
      }
    } catch (_) {}
  }

  void _handleEvent(SquadRoomEvent event) {
    if (!mounted) return;
    setState(() {
      final eventSquad = event.squad;
      if (eventSquad != null) {
        _squad = eventSquad;
      }
      final eventMembers = event.members;
      if (eventMembers != null) {
        _members = eventMembers;
      }
      final msg = event.message;
      if (event.type == 'chat' && msg != null) {
        _messages.add(
          SquadChatMessage(
            squadId: event.squadId ?? widget.squadId,
            userName: event.userName ?? 'Anonymous',
            message: msg,
            sentAt: event.timestamp,
          ),
        );
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  int get _remainingSeconds {
    final started = _squad?.timerStartedAt;
    if (_squad == null || started == null) {
      return _squad?.timerDurationSeconds ?? 1500;
    }
    final elapsed = DateTime.now().toUtc().difference(started).inSeconds;
    final total = _squad?.timerDurationSeconds ?? 1500;
    final remaining = total - elapsed;
    return remaining > 0 ? remaining : 0;
  }

  void _startTimer() async {
    HapticFeedback.mediumImpact();
    setState(() {
      _squad = _squad?.copyWith(
        timerStartedAt: DateTime.now().toUtc(),
        isFocusing: true,
      );
      _isLocalFocusing = true;
    });

    await ApiService.instance.startTimer(
      squadId: widget.squadId,
      durationSeconds: 1500,
    );
  }

  void _toggleFocusPresence() async {
    HapticFeedback.lightImpact();
    setState(() => _isLocalFocusing = !_isLocalFocusing);

    await ApiService.instance.updatePresence(
      squadId: widget.squadId,
      userName: UserService.instance.currentUser.value,
      isFocusing: _isLocalFocusing,
    );
  }

  void _sendMessage([String? textToSend]) async {
    final text = (textToSend ?? _chatController.text).trim();
    if (text.isEmpty) return;

    if (textToSend == null) {
      _chatController.clear();
    }
    final user = UserService.instance.currentUser.value;

    final localMsg = SquadChatMessage(
      squadId: widget.squadId,
      userName: user,
      message: text,
      sentAt: DateTime.now(),
    );

    setState(() => _messages.add(localMsg));
    _scrollToBottom();

    await ApiService.instance.sendChat(
      squadId: widget.squadId,
      userName: user,
      message: text,
    );
  }

  void _showStickerSheet(SquadChatMessage msg) {
    HapticFeedback.selectionClick();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: HuddleTheme.cardBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          border: Border.all(color: HuddleTheme.cardBorder, width: 1.5),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: HuddleTheme.ink.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const SectionLabel(text: 'REACT WITH A STICKER'),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final sticker in [
                    'LOCKED IN',
                    'FIRE',
                    '100',
                    'COFFEE',
                    'RUN IT BACK',
                  ])
                    HuddleChip(
                      label: sticker,
                      variant: sticker == 'LOCKED IN'
                          ? HuddleChipVariant.highlight
                          : HuddleChipVariant.subtle,
                      icon: sticker == 'LOCKED IN'
                          ? Icons.lock_clock_outlined
                          : sticker == 'FIRE'
                          ? Icons.local_fire_department_outlined
                          : sticker == 'COFFEE'
                          ? Icons.coffee_outlined
                          : Icons.repeat_outlined,
                      onTap: () {
                        Navigator.pop(context);
                        _sendMessage('[$sticker]');
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: HuddleTheme.neonBg,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: HuddleTheme.neonBg,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          _squad?.name.toUpperCase() ?? 'SQUAD ROOM',
          style: HuddleTheme.monoLabel(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          color: Colors.white,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/feed'),
        ),
        actions: [
          if (_squad != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: StreakCounter(streakDays: _squad?.streak ?? 0),
            ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: HuddleTheme.neonCard,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: HuddleTheme.neonCyan,
                          width: 1.5,
                        ),
                        boxShadow: const [HuddleTheme.shadowCyanGlow],
                      ),
                      child: const Icon(
                        Icons.timer_outlined,
                        size: 36,
                        color: HuddleTheme.neonCyan,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'CONNECTING TO SQUAD ROOM...',
                      style: HuddleTheme.monoLabel(
                        color: HuddleTheme.neonTextMuted,
                      ),
                    ),
                  ],
                ),
              )
            : isDesktop
            ? _buildDesktopLayout()
            : _buildMobileLayout(keyboardOpen),
      ),
    );
  }

  // DESKTOP (>1024): Side-by-side Left panel (Timer, Members, Pinned Reel) + Right panel (Chat)
  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPinnedReelBanner(),
                  const SizedBox(height: 16),
                  _buildRosterCard(),
                  const SizedBox(height: 16),
                  _buildTimerCard(isCompact: false),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Right Column (Squad Chat)
          Expanded(
            flex: 6,
            child: _buildChatContainer(),
          ),
        ],
      ),
    );
  }

  // MOBILE (<1024): Stacked Layout
  Widget _buildMobileLayout(bool keyboardOpen) {
    return Column(
      children: [
        if (!keyboardOpen) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 8),
            child: _buildPinnedReelBanner(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: _buildRosterCard(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
            child: _buildTimerCard(isCompact: true),
          ),
        ],
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: _buildChatContainer(),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  // Pinned Lesson Reel Banner
  Widget _buildPinnedReelBanner() {
    return HuddleCard(
      color: HuddleTheme.neonCard,
      border: HuddleTheme.borderCyanSubtle,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: HuddleTheme.neonCyan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.play_circle_outline,
              color: HuddleTheme.neonCyan,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const HuddleChip(
                      label: 'PINNED REEL',
                      variant: HuddleChipVariant.neon,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        _squad?.topic ?? 'Bio 101 · Krebs Cycle',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: HuddleTheme.monoLabel(
                          color: Colors.white,
                        ).copyWith(fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '3-question Try It quiz tied to this squad study session',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: HuddleTheme.body14(
                    color: HuddleTheme.neonTextMuted,
                  ).copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          HuddleButton(
            text: 'Watch',
            variant: HuddleButtonVariant.neonSubtle,
            height: 34,
            icon: Icons.movie_outlined,
            onPressed: () => context.go('/reels/1'),
          ),
        ],
      ),
    );
  }

  // Roster Card with "X of Y focusing" & pulsing avatars
  Widget _buildRosterCard() {
    final focusingCount = _members.where((m) => m.isFocusing).length;

    return HuddleCard(
      color: HuddleTheme.neonCard,
      border: HuddleTheme.borderCyanSubtle,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '$focusingCount OF ${_members.length} FOCUSING',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: HuddleTheme.monoLabel(color: Colors.white).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              HuddleChip(
                label: _isLocalFocusing ? 'LOCKED IN' : 'TAP TO FOCUS',
                variant: _isLocalFocusing
                    ? HuddleChipVariant.neon
                    : HuddleChipVariant.neonDark,
                icon: _isLocalFocusing
                    ? Icons.lock_clock_outlined
                    : Icons.radio_button_checked_outlined,
                onTap: _toggleFocusPresence,
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final m in _members)
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Column(
                      children: [
                        HuddleAvatar(
                          seed: m.userName,
                          size: 40,
                          isFocusing: m.isFocusing,
                          showOnline: true,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          m.userName.split(' ').first,
                          style: HuddleTheme.monoLabel(
                            color: m.isFocusing
                                ? HuddleTheme.neonCyan
                                : Colors.white,
                          ).copyWith(
                            fontSize: 10,
                            fontWeight: m.isFocusing
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 25-minute Pomodoro Timer Card
  Widget _buildTimerCard({required bool isCompact}) {
    final squad = _squad ?? FakeData.squadSuggestions.first.squad;
    final totalSec = squad.timerDurationSeconds;
    final remSec = _remainingSeconds;
    final isTimerRunning = squad.timerStartedAt != null && remSec > 0;

    return HuddleCard(
      color: HuddleTheme.neonCard,
      border: HuddleTheme.borderCyanSubtle,
      padding: EdgeInsets.all(isCompact ? 14 : 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TimerRing(
            totalSeconds: totalSec,
            remainingSeconds: remSec,
            size: isCompact ? 104 : 136,
            isFocusing: isTimerRunning,
            isNeon: true,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '25M POMODORO',
                  style: HuddleTheme.monoLabel(color: Colors.white).copyWith(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isTimerRunning ? 'Synced room clock' : 'Ready to lock in',
                  style: HuddleTheme.body14(
                    color: HuddleTheme.neonTextMuted,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: HuddleButton(
                    text: isTimerRunning ? 'Locked in' : 'Start Focus',
                    icon: isTimerRunning
                        ? Icons.lock_clock_outlined
                        : Icons.play_arrow_outlined,
                    variant: isTimerRunning
                        ? HuddleButtonVariant.neonSubtle
                        : HuddleButtonVariant.neon,
                    height: isCompact ? 42 : 48,
                    onPressed: isTimerRunning ? null : _startTimer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Squad Chat Container
  Widget _buildChatContainer() {
    return HuddleCard(
      color: HuddleTheme.neonCard,
      border: HuddleTheme.borderCyanSubtle,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SectionLabel(
            text: 'LIVE CHAT · HOLD FOR STICKER',
            color: HuddleTheme.neonCyan,
            trailing: Text(
              '${_messages.length} msgs',
              style: HuddleTheme.monoLabel(color: HuddleTheme.neonTextMuted)
                  .copyWith(fontSize: 10),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              itemCount: _messages.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, idx) {
                final msg = _messages[idx];
                final isMine =
                    msg.userName == UserService.instance.currentUser.value;

                return GestureDetector(
                  onLongPress: () => _showStickerSheet(msg),
                  child: Align(
                    alignment: isMine
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: isMine
                            ? HuddleTheme.neonCyan.withValues(alpha: 0.22)
                            : HuddleTheme.neonCardAlt,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(14),
                          topRight: const Radius.circular(14),
                          bottomLeft: Radius.circular(isMine ? 14 : 2),
                          bottomRight: Radius.circular(isMine ? 2 : 14),
                        ),
                        border: Border.all(
                          color: isMine
                              ? HuddleTheme.neonCyan
                              : Colors.white12,
                          width: 1.5,
                        ),
                        boxShadow: isMine
                            ? const [HuddleTheme.shadowCyanGlow]
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: isMine
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.userName,
                            style: HuddleTheme.monoLabel(
                              color: isMine
                                  ? HuddleTheme.neonCyan
                                  : HuddleTheme.neonTextMuted,
                            ).copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            msg.message,
                            style: HuddleTheme.body14(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Quick sticker bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final tag in ['LOCKED IN', 'FIRE', '100', 'COFFEE'])
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: HuddleChip(
                      label: tag,
                      variant: HuddleChipVariant.neonDark,
                      onTap: () => _sendMessage('[$tag]'),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Chat input bar
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: HuddleTheme.neonCardAlt,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: HuddleTheme.neonCyan.withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                  ),
                  child: TextField(
                    controller: _chatController,
                    onSubmitted: (_) => _sendMessage(),
                    style: HuddleTheme.body14(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Chat with crew...',
                      hintStyle: HuddleTheme.body14(
                        color: HuddleTheme.neonTextMuted.withValues(alpha: 0.6),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              HuddleButton(
                text: 'Send',
                icon: Icons.send_outlined,
                variant: HuddleButtonVariant.neon,
                height: 44,
                onPressed: () => _sendMessage(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
