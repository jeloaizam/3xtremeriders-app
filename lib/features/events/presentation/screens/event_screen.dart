import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../spots/presentation/sport_visuals.dart';
import '../../application/event_detail.dart';
import '../../application/events_providers.dart';
import '../../data/event_attendee_api.dart';
import '../../domain/event_attendee.dart';
import '../event_state_visuals.dart';

/// Mirrors the "EVENTO" (`isEvent`) detail state of
/// `Deportes Extremos App v2.dc.html` — banner, organizer (tap-through to
/// [RiderProfileScreen]), sports, description, attendee counts, and a
/// sticky RSVP control at the bottom.
class EventScreen extends ConsumerWidget {
  const EventScreen({super.key, required this.eventId});

  final int eventId;

  Future<void> _setRsvp(WidgetRef ref, int? currentStatus, int status) async {
    final user = ref.read(firebaseAuthProvider).currentUser;
    final idToken = await user?.getIdToken();
    final riderId = ref.read(currentRiderProvider).value?.id;
    if (idToken == null || riderId == null) return;

    final api = ref.read(eventAttendeeApiProvider);
    try {
      if (currentStatus == null) {
        await api.rsvp(eventId: eventId, status: status, idToken: idToken);
      } else if (currentStatus == status) {
        await api.cancelRsvp(
          eventId: eventId,
          riderId: riderId,
          idToken: idToken,
        );
      } else {
        await api.updateRsvp(
          eventId: eventId,
          riderId: riderId,
          status: status,
          idToken: idToken,
        );
      }
    } finally {
      ref.invalidate(eventDetailProvider(eventId));
      ref.invalidate(eventsAttendeesByIdProvider);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(eventDetailProvider(eventId));

    return Scaffold(
      body: SafeArea(
        child: detailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (detail) {
            final riderId = ref.watch(currentRiderProvider).value?.id;
            final myAttendee = _findMine(detail.attendees, riderId);
            return _EventScreenBody(
              detail: detail,
              myStatus: myAttendee?.status,
              onBack: () => context.pop(),
              onRsvp: (status) => _setRsvp(ref, myAttendee?.status, status),
            );
          },
        ),
      ),
    );
  }
}

EventAttendee? _findMine(List<EventAttendee> attendees, int? riderId) {
  if (riderId == null) return null;
  for (final attendee in attendees) {
    if (attendee.riderId == riderId) return attendee;
  }
  return null;
}

class _EventScreenBody extends StatelessWidget {
  const _EventScreenBody({
    required this.detail,
    required this.myStatus,
    required this.onBack,
    required this.onRsvp,
  });

  final EventDetailData detail;
  final int? myStatus;
  final VoidCallback onBack;
  final void Function(int status) onRsvp;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final event = detail.event;
    final visual = EventStateVisual.of(event.stateId, colors, l10n);
    final locale = Localizations.localeOf(context).toString();
    final dateLabel = DateFormat.MMMEd(locale).format(event.startDate);
    final timeLabel = event.endDate != null
        ? '${DateFormat.Hm(locale).format(event.startDate)} – ${DateFormat.Hm(locale).format(event.endDate!)}'
        : DateFormat.Hm(locale).format(event.startDate);
    final goingCount = detail.attendees
        .where((a) => a.status == rsvpGoing)
        .length;
    final interestedCount = detail.attendees
        .where((a) => a.status == rsvpInterested)
        .length;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (event.coverImageUrl != null)
                          Image.network(
                            event.coverImageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(color: colors.surfaceMedia),
                          )
                        else
                          Container(color: colors.surfaceMedia),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                colors.bg850.withValues(alpha: .55),
                                Colors.transparent,
                                colors.bg850,
                              ],
                              stops: const [0, 0.35, 1],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: AppIconButton(
                      icon: Symbols.arrow_back,
                      chrome: true,
                      onPressed: onBack,
                    ),
                  ),
                  Positioned(
                    left: 18,
                    right: 18,
                    bottom: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (visual != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: visual.color.withValues(alpha: .16),
                              border: Border.all(
                                color: visual.color.withValues(alpha: .3),
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              visual.label,
                              style: context.typography.tag.copyWith(
                                color: visual.color,
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Text(
                          event.name.toUpperCase(),
                          style: context.typography.displaySm,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _InfoTile(
                            icon: Symbols.event,
                            iconColor: colors.colorAction,
                            title: dateLabel,
                            subtitle: timeLabel,
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (event.spotId != null)
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  context.push('/spot/${event.spotId}'),
                              child: _InfoTile(
                                icon: Symbols.place,
                                iconColor: colors.colorBrand,
                                title: l10n.eventViewSpot,
                                subtitle: '',
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => context.push('/riders/${detail.creator.id}'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: colors.surfaceCard,
                          border: Border.all(color: colors.hairline),
                          borderRadius: BorderRadius.circular(
                            context.spacing.radiusMd,
                          ),
                        ),
                        child: Row(
                          children: [
                            AppAvatar(
                              initial: detail.creator.nickname.isNotEmpty
                                  ? detail.creator.nickname[0].toUpperCase()
                                  : '?',
                              imageUrl: detail.creator.iconImage,
                              size: AppAvatarSize.sm,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.eventOrganizedBy,
                                    style: context.typography.micro,
                                  ),
                                  Text(
                                    detail.creator.nickname,
                                    style: context.typography.title.copyWith(
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Symbols.chevron_right,
                              size: 20,
                              color: colors.text700,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (detail.sports.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: [
                          for (final sport in detail.sports)
                            _SportChip(id: sport.id, name: sport.name),
                        ],
                      ),
                    ],
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.surfaceCard,
                        border: Border.all(color: colors.hairline),
                        borderRadius: BorderRadius.circular(
                          context.spacing.radiusXl,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Symbols.description,
                                size: 18,
                                color: colors.colorBrand,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                l10n.eventAboutTitle,
                                style: context.typography.eyebrow,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            event.description,
                            style: context.typography.bodySm,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          l10n.eventAttendeesTitle(goingCount),
                          style: context.typography.tag.copyWith(
                            color: colors.text300,
                          ),
                        ),
                        if (interestedCount > 0)
                          Text(
                            l10n.eventInterestedCount(interestedCount),
                            style: context.typography.tag.copyWith(
                              color: colors.colorBrand,
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
        Container(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 16),
          decoration: BoxDecoration(
            color: colors.surfaceApp,
            border: Border(top: BorderSide(color: colors.hairlineSoft)),
          ),
          child: _RsvpControl(myStatus: myStatus, onSelect: onRsvp),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        border: Border.all(color: colors.hairline),
        borderRadius: BorderRadius.circular(context.spacing.radiusMd),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.title.copyWith(fontSize: 14),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(subtitle, style: context.typography.micro),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SportChip extends StatelessWidget {
  const _SportChip({required this.id, required this.name});

  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final visual = SportVisual.of(name, colors);

    return GestureDetector(
      onTap: () => context.push('/sports/$id'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: visual.color.withValues(alpha: .14),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(visual.icon, size: 14, color: visual.color),
            const SizedBox(width: 5),
            Text(
              name.toUpperCase(),
              style: context.typography.tag.copyWith(color: visual.color),
            ),
          ],
        ),
      ),
    );
  }
}

class _RsvpControl extends StatelessWidget {
  const _RsvpControl({required this.myStatus, required this.onSelect});

  final int? myStatus;
  final void Function(int status) onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final options = [
      (rsvpGoing, l10n.rsvpGoing, Symbols.check_circle, colors.colorRating),
      (rsvpInterested, l10n.rsvpInterested, Symbols.star, colors.colorAction),
      (rsvpDeclined, l10n.rsvpDeclined, Symbols.cancel, colors.colorDanger),
    ];

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        border: Border.all(color: colors.hairline),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          for (final (status, label, icon, color) in options)
            Expanded(
              child: GestureDetector(
                onTap: () => onSelect(status),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(
                    color: myStatus == status
                        ? color.withValues(alpha: .16)
                        : null,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        fill: myStatus == status ? 1 : 0,
                        size: 19,
                        color: myStatus == status ? color : colors.text300,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        label,
                        style: context.typography.tag.copyWith(
                          fontSize: 11,
                          color: myStatus == status ? color : colors.text300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
