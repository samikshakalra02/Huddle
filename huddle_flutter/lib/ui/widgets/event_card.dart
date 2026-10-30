import 'package:flutter/material.dart';
import 'package:huddle_client/huddle_client.dart';
import '../../theme.dart';
import 'huddle_button.dart';
import 'huddle_card.dart';
import 'huddle_chip.dart';

/// Campus event card with date badge, details, attendee counts, and instant RSVP toggle.
class EventCard extends StatefulWidget {
  final CampusEvent event;
  final VoidCallback? onRsvp;

  const EventCard({
    super.key,
    required this.event,
    this.onRsvp,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isRsvped = false;
  int _attendeeCount = 42;

  @override
  void initState() {
    super.initState();
    _attendeeCount = 38 + (widget.event.id ?? 1) * 7;
  }

  void _toggleRsvp() {
    setState(() {
      _isRsvped = !_isRsvped;
      _attendeeCount += _isRsvped ? 1 : -1;
    });
    if (widget.onRsvp != null) {
      widget.onRsvp!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    final date = widget.event.eventTime;
    final monthStr = months[date.month - 1];
    final dayStr = date.day.toString().padLeft(2, '0');

    return Semantics(
      label:
          'Campus event: ${widget.event.title} at ${widget.event.venue} organized by ${widget.event.organizer}.',
      child: HuddleCard(
        color: HuddleTheme.neonCard,
        border: HuddleTheme.borderCyanSubtle,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Category tag and chip
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'CAMPUS EVENT · ${widget.event.tag.toUpperCase()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: HuddleTheme.monoLabel(color: HuddleTheme.neonCyan),
                  ),
                ),
                const SizedBox(width: 8),
                HuddleChip(
                  label: widget.event.tag,
                  variant: HuddleChipVariant.neonDark,
                  icon: HuddleTheme.iconForTopic(widget.event.tag),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Main Event Row with Date Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Badge
                Container(
                  width: 52,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: HuddleTheme.neonCardAlt,
                    borderRadius: HuddleTheme.radius14,
                    border: Border.all(color: HuddleTheme.neonCyan, width: 1.5),
                    boxShadow: const [HuddleTheme.shadowCyan],
                  ),
                  child: Column(
                    children: [
                      Text(
                        monthStr,
                        style: HuddleTheme.monoLabel(
                          color: HuddleTheme.neonCyan,
                        ).copyWith(fontSize: 10, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        dayStr,
                        style: HuddleTheme.heading20(
                          color: Colors.white,
                        ).copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),

                // Title & Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.event.title,
                        style: HuddleTheme.heading20(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.event.organizer,
                        style: HuddleTheme.body14(
                          color: HuddleTheme.neonTextMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              widget.event.description,
              style: HuddleTheme.body14(color: Colors.white),
            ),
            const SizedBox(height: 14),

            // Venue + Attendee count row
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 6,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 16,
                      color: HuddleTheme.neonCyan,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.event.venue,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: HuddleTheme.body14(
                        color: HuddleTheme.neonTextMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.people_rounded,
                      size: 16,
                      color: HuddleTheme.neonCyan,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$_attendeeCount going',
                      style: HuddleTheme.monoLabel(
                        color: HuddleTheme.neonTextMuted,
                      ).copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // RSVP Action Button
            SizedBox(
              width: double.infinity,
              child: HuddleButton(
                text: _isRsvped ? "You're Going!" : 'RSVP to Event',
                icon: _isRsvped
                    ? Icons.check_circle_rounded
                    : Icons.event_available_rounded,
                variant: _isRsvped
                    ? HuddleButtonVariant.neonSubtle
                    : HuddleButtonVariant.neon,
                onPressed: _toggleRsvp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
