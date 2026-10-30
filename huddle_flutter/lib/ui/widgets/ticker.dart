import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme.dart';

/// Horizontal live ticker strip for campus updates and study alerts.
class Ticker extends StatefulWidget {
  final List<String> items;
  final double height;

  const Ticker({
    super.key,
    required this.items,
    this.height = 36,
  });

  @override
  State<Ticker> createState() => _TickerState();
}

class _TickerState extends State<Ticker> {
  late ScrollController _scrollController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduceMotion) return;

    _timer = Timer.periodic(const Duration(milliseconds: 35), (timer) {
      if (!mounted || !_scrollController.hasClients) return;
      final max = _scrollController.position.maxScrollExtent;
      final current = _scrollController.offset;
      if (current >= max) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(current + 1.2);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayItems = [...widget.items, ...widget.items, ...widget.items];

    return Semantics(
      label: 'Campus live updates: ${widget.items.join(" · ")}',
      child: Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: HuddleTheme.highlight,
          border: Border(
            top: BorderSide(color: HuddleTheme.ink, width: 1.5),
            bottom: BorderSide(color: HuddleTheme.ink, width: 1.5),
          ),
        ),
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayItems.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    displayItems[index],
                    style: HuddleTheme.monoLabel(color: HuddleTheme.ink)
                        .copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                  ),
                ),
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: HuddleTheme.ink,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
