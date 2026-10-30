import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme.dart';
import 'huddle_button.dart';

/// Serverpod Brand Badge & Explainer Sheet
/// Positioned top-left in Mobile AppBar and Desktop/Tablet Sidebar.
class ServerpodBadge extends StatelessWidget {
  final double height;
  final bool showLabel;

  const ServerpodBadge({
    super.key,
    double? height,
    double? size,
    this.showLabel = true,
  }) : height = size ?? height ?? 28;

  static void showExplainer(BuildContext context) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _ServerpodExplainerSheet(),
    );
  }

  static void showServerpodSheet(BuildContext context) =>
      showExplainer(context);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showExplainer(context),
      borderRadius: BorderRadius.circular(999),
      child: Tooltip(
        message: 'Built with Serverpod · Tap to learn more',
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: HuddleTheme.background,
            border: Border.all(color: HuddleTheme.ink, width: 1.5),
            borderRadius: BorderRadius.circular(999),
            boxShadow: const [HuddleTheme.shadowSmall],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Official Serverpod Logo or explicit download placeholder
              _buildLogo(context),
              if (showLabel) ...[
                const SizedBox(width: 8),
                Text(
                  'HUDDLE',
                  style: HuddleTheme.heading20().copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: HuddleTheme.highlight,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: HuddleTheme.ink, width: 1.0),
                  ),
                  child: Text(
                    'SERVERPOD',
                    style: HuddleTheme.monoLabel().copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/serverpod.svg',
      height: height,
      fit: BoxFit.contain,
      placeholderBuilder: (BuildContext context) => Container(
        height: height,
        width: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: HuddleTheme.highlight,
          shape: BoxShape.circle,
          border: Border.all(color: HuddleTheme.ink, width: 1.5),
        ),
        child: Text(
          'SP',
          style: HuddleTheme.monoLabel(color: HuddleTheme.ink).copyWith(
            fontSize: height * 0.4,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ServerpodExplainerSheet extends StatelessWidget {
  const _ServerpodExplainerSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: HuddleTheme.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(
          top: BorderSide(color: HuddleTheme.ink, width: 1.5),
          left: BorderSide(color: HuddleTheme.ink, width: 1.5),
          right: BorderSide(color: HuddleTheme.ink, width: 1.5),
        ),
        boxShadow: [HuddleTheme.shadow],
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Sheet Handle
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: HuddleTheme.ink,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Serverpod Logo & Header
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/serverpod.svg',
                    height: 36,
                    fit: BoxFit.contain,
                    placeholderBuilder: (_) => Container(
                      height: 36,
                      width: 36,
                      decoration: const BoxDecoration(
                        color: HuddleTheme.highlight,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text('SP'),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BUILT WITH SERVERPOD',
                          style: HuddleTheme.heading20(),
                        ),
                        Text(
                          'The Dart Backend Framework',
                          style: HuddleTheme.body14(color: HuddleTheme.ink),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                'Huddle runs on Serverpod to power high-performance campus peer learning with zero context switching:',
                style: HuddleTheme.body16(),
              ),
              const SizedBox(height: 16),

              _featureRow(
                icon: Icons.code_rounded,
                title: 'Typed RPC Endpoints',
                desc:
                    'Client and server share identical Dart data models declared in YAML (.spy.yaml). No manual JSON mapping or serialization bugs.',
              ),
              const SizedBox(height: 12),
              _featureRow(
                icon: Icons.stream_rounded,
                title: 'Live WebSocket Streaming',
                desc:
                    'Squad Focus Rooms use native Serverpod WebSocket streams for live chat, presence syncing, and synchronized 25-minute Pomodoro timer countdowns.',
              ),
              const SizedBox(height: 12),
              _featureRow(
                icon: Icons.storage_rounded,
                title: 'PostgreSQL Database & ORM',
                desc:
                    'Embedded PostgreSQL with automatic declarative migrations, indexing, and transactional queries for student personas, karma endorsements, and study streaks.',
              ),
              const SizedBox(height: 12),
              _featureRow(
                icon: Icons.cloud_done_rounded,
                title: 'Serverpod Cloud Ready',
                desc:
                    'Deployable in seconds to Serverpod Cloud for instant scaling, global CDN caching, and automated SSL.',
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: HuddleButton(
                  text: 'Got it, lock in',
                  icon: Icons.check_circle_outline_rounded,
                  variant: HuddleButtonVariant.accent,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureRow({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: HuddleTheme.background,
        borderRadius: HuddleTheme.radius14,
        border: Border.all(color: HuddleTheme.ink, width: 1.5),
        boxShadow: const [HuddleTheme.shadowSmall],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: HuddleTheme.highlight,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: HuddleTheme.ink, width: 1.5),
            ),
            child: Icon(icon, size: 20, color: HuddleTheme.ink),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: HuddleTheme.body14(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: HuddleTheme.body14(
                    color: HuddleTheme.ink.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
