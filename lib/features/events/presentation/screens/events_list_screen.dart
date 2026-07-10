import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' hide Position;
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/domain/role.dart';
import '../../../spots/application/spots_providers.dart';
import '../../../spots/domain/spot.dart';
import '../../application/events_providers.dart';
import '../../domain/event.dart';
import '../../domain/event_attendee.dart';
import '../event_state_visuals.dart';

enum _EventTab { upcoming, nearby, going }

/// Mirrors the "EVENTOS" (`isEvents`) list state of
/// `Deportes Extremos App v2.dc.html` — PRÓXIMOS/CERCA/VOY tabs over the
/// same event list, "CREAR" only shown to admins (events are "official",
/// see `require_admin` on `POST /events/`).
class EventsListScreen extends ConsumerStatefulWidget {
  const EventsListScreen({super.key});

  @override
  ConsumerState<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends ConsumerState<EventsListScreen> {
  _EventTab _tab = _EventTab.upcoming;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _fetchLocationBestEffort();
  }

  // Silent, best-effort — same pattern as SearchScreen's distance filter:
  // if permission is missing/denied, "CERCA" just falls back to the
  // unsorted list instead of showing an error.
  Future<void> _fetchLocationBestEffort() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
        });
      }
    } catch (_) {
      // Falls back to the unsorted list.
    }
  }

  List<Event> _applyTab(
    List<Event> events,
    Map<int, List<EventAttendee>> attendeesById,
    int? myRiderId,
  ) {
    switch (_tab) {
      case _EventTab.upcoming:
        return events;
      case _EventTab.going:
        return [
          for (final event in events)
            if ((attendeesById[event.id] ?? const []).any(
              (a) => a.riderId == myRiderId && a.status == rsvpGoing,
            ))
              event,
        ];
      case _EventTab.nearby:
        if (_latitude == null || _longitude == null) return events;
        final withCoords = [
          for (final event in events)
            if (event.latitude != null && event.longitude != null) event,
        ];
        withCoords.sort((a, b) {
          final da = Geolocator.distanceBetween(
            _latitude!,
            _longitude!,
            a.latitude!,
            a.longitude!,
          );
          final db = Geolocator.distanceBetween(
            _latitude!,
            _longitude!,
            b.latitude!,
            b.longitude!,
          );
          return da.compareTo(db);
        });
        return withCoords;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final currentRider = ref.watch(currentRiderProvider).value;
    final isAdmin = (currentRider?.roleId ?? 0) >= roleAdmin;
    final eventsAsync = ref.watch(eventsListProvider);
    final attendeesByIdAsync = ref.watch(eventsAttendeesByIdProvider);
    final spotsById = {
      for (final spot in ref.watch(nearbySpotsProvider).value ?? const <Spot>[])
        spot.id: spot,
    };

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
              child: Row(
                children: [
                  AppIconButton(
                    icon: Symbols.arrow_back,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      l10n.eventsTitle,
                      style: context.typography.displaySm,
                    ),
                  ),
                  if (isAdmin)
                    GestureDetector(
                      onTap: () => context.push('/events/new'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: colors.colorAction,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Symbols.add,
                              size: 18,
                              color: colors.colorOnAction,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              l10n.eventsCreate,
                              style: context.typography.tag.copyWith(
                                color: colors.colorOnAction,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  _TabChip(
                    label: l10n.eventsTabUpcoming,
                    active: _tab == _EventTab.upcoming,
                    onTap: () => setState(() => _tab = _EventTab.upcoming),
                  ),
                  const SizedBox(width: 8),
                  _TabChip(
                    label: l10n.eventsTabNearby,
                    active: _tab == _EventTab.nearby,
                    onTap: () => setState(() => _tab = _EventTab.nearby),
                  ),
                  const SizedBox(width: 8),
                  _TabChip(
                    label: l10n.eventsTabGoing,
                    active: _tab == _EventTab.going,
                    onTap: () => setState(() => _tab = _EventTab.going),
                  ),
                ],
              ),
            ),
            Expanded(
              child: eventsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('$error')),
                data: (events) {
                  final attendeesById = attendeesByIdAsync.value ?? const {};
                  final list = _applyTab(
                    events,
                    attendeesById,
                    currentRider?.id,
                  );
                  if (list.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.eventsEmpty,
                        style: context.typography.bodySm,
                      ),
                    );
                  }
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 20),
                    children: [
                      for (final event in list)
                        _EventCard(
                          event: event,
                          goingCount: (attendeesById[event.id] ?? const [])
                              .where((a) => a.status == rsvpGoing)
                              .length,
                          spotName: event.spotId != null
                              ? spotsById[event.spotId]?.name
                              : null,
                          onTap: () => context.push('/events/${event.id}'),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: active ? colors.colorAction : colors.surfaceCard,
          border: Border.all(
            color: active ? colors.colorAction : colors.hairline,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: context.typography.tag.copyWith(
            color: active ? colors.colorOnAction : colors.text300,
          ),
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({
    required this.event,
    required this.goingCount,
    required this.spotName,
    required this.onTap,
  });

  final Event event;
  final int goingCount;
  final String? spotName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final visual = EventStateVisual.of(event.stateId, colors, l10n);
    final locale = Localizations.localeOf(context).toString();
    final day = DateFormat('d', locale).format(event.startDate);
    final month = DateFormat(
      'MMM',
      locale,
    ).format(event.startDate).toUpperCase();
    final time = DateFormat.Hm(locale).format(event.startDate);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: colors.surfaceCard,
            border: Border.all(color: colors.hairline),
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 110,
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
                            Colors.transparent,
                            colors.bg850.withValues(alpha: .95),
                          ],
                          stops: const [0.4, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: .55),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Column(
                          children: [
                            Text(
                              day,
                              style: context.typography.title.copyWith(
                                color: colors.colorAction,
                                fontSize: 18,
                                height: 1,
                              ),
                            ),
                            Text(
                              month,
                              style: context.typography.tag.copyWith(
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (visual != null)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
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
                              fontSize: 10,
                              color: visual.color,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 10,
                      child: Text(
                        event.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.typography.title.copyWith(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (spotName != null || event.latitude != null)
                      Row(
                        children: [
                          Icon(
                            Symbols.place,
                            size: 15,
                            color: colors.colorBrand,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              spotName ?? '—',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.typography.meta,
                            ),
                          ),
                          Text(' · $time', style: context.typography.meta),
                        ],
                      )
                    else
                      Text(time, style: context.typography.meta),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Symbols.group,
                          fill: 1,
                          size: 16,
                          color: colors.colorRating,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '$goingCount',
                          style: context.typography.title.copyWith(
                            fontSize: 13,
                            color: colors.colorRating,
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
      ),
    );
  }
}
