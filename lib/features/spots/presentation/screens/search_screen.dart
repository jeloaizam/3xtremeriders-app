import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' hide Position;
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/search/search_query.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/rider_search_providers.dart';
import '../../../auth/domain/rider.dart';
import '../../../events/application/events_providers.dart';
import '../../../events/domain/event.dart';
import '../../application/spots_providers.dart';
import '../../domain/spot.dart';
import '../../domain/sport.dart';
import '../sport_visuals.dart';

const _seasonAll = 'Todo el año';
const _seasonDry = 'Temporada seca';
const _seasonRain = 'Temporada de lluvias';

enum SearchTab { spots, riders, events, sports }

/// Mirrors the "BÚSQUEDA" (`isSearch`) state of
/// `Deportes Extremos App v2.dc.html` — every filter re-queries
/// `GET /spots` live (no separate "apply" step), backed 100% by the
/// backend's new search filters (see `crud_spot.search`), no mocks. The
/// "Deportes" tab (browsing the Sport catalog itself, not filtering by
/// sport) was added later, alongside the new Sport detail screen.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key, this.initialTab = SearchTab.spots});

  final SearchTab initialTab;

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _queryController = TextEditingController();
  Timer? _debounce;
  String? _query;
  late SearchTab _tab;

  final Set<int> _sportIds = {};
  int? _difficulty;
  String? _bestSeason;
  String? _hazardLevel;
  double _radiusKm = 10;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _tab = widget.initialTab;
    _fetchLocationBestEffort();
    _queryController.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _queryController.dispose();
    super.dispose();
  }

  // Silent, best-effort — no button/prompt UI like CreateSpotScreen's
  // "usar mi ubicación": if permission is missing or fails, the distance
  // filter simply doesn't appear (per the user's explicit scoping call).
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
      // Distance filter just stays hidden.
    }
  }

  void _onQueryChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(
          () => _query = _queryController.text.trim().isEmpty
              ? null
              : _queryController.text.trim(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final allSports = ref.watch(allSportsProvider).value ?? const <Sport>[];

    final query = (
      q: _query,
      sportIdsKey: (_sportIds.toList()..sort()).join(','),
      difficulty: _difficulty,
      bestSeason: _bestSeason,
      hazardLevel: _hazardLevel,
      lat: _latitude,
      lng: _longitude,
      radiusKm: _latitude != null ? _radiusKm : null,
    );

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
                  Text(l10n.searchTitle, style: context.typography.displaySm),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: AppTextField(
                controller: _queryController,
                icon: Symbols.search,
                placeholder: l10n.searchPlaceholder,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
              child: _Segmented(
                options: SearchTab.values,
                labelOf: (tab) => switch (tab) {
                  SearchTab.spots => l10n.searchTabSpots,
                  SearchTab.riders => l10n.searchTabRiders,
                  SearchTab.events => l10n.searchTabEvents,
                  SearchTab.sports => l10n.searchTabSports,
                },
                selected: _tab,
                onSelect: (tab) => setState(() => _tab = tab),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
                children: [
                  if (_tab != SearchTab.sports) ...[
                    _SectionLabel(l10n.searchSportLabel),
                    Wrap(
                      spacing: 9,
                      runSpacing: 9,
                      children: [
                        for (final sport in allSports)
                          _FilterChip(
                            label: sport.name,
                            icon: SportVisual.of(sport.name, colors).icon,
                            selected: _sportIds.contains(sport.id),
                            onTap: () => setState(
                              () => _sportIds.contains(sport.id)
                                  ? _sportIds.remove(sport.id)
                                  : _sportIds.add(sport.id),
                            ),
                          ),
                      ],
                    ),
                  ],

                  if (_tab == SearchTab.spots) ...[
                    _SectionLabel(l10n.searchDifficultyLabel, top: 22),
                    _Segmented(
                      options: const [1, 2, 3, 4, 5],
                      labelOf: (d) => '$d',
                      selected: _difficulty,
                      onSelect: (d) => setState(
                        () => _difficulty = _difficulty == d ? null : d,
                      ),
                    ),

                    if (_latitude != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 22, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.searchDistanceLabel,
                              style: context.typography.eyebrow.copyWith(
                                color: colors.text300,
                              ),
                            ),
                            Text(
                              l10n.searchDistanceValue(_radiusKm.round()),
                              style: context.typography.tag.copyWith(
                                color: colors.colorRating,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Slider(
                        value: _radiusKm,
                        min: 1,
                        max: 50,
                        divisions: 49,
                        onChanged: (value) => setState(() => _radiusKm = value),
                      ),
                    ],

                    _SectionLabel(l10n.searchSeasonLabel, top: 22),
                    Wrap(
                      spacing: 9,
                      runSpacing: 9,
                      children: [
                        _SeasonChip(
                          label: l10n.searchSeasonDry,
                          value: _seasonDry,
                          selected: _bestSeason,
                          onTap: (v) => setState(
                            () => _bestSeason = _bestSeason == v ? null : v,
                          ),
                        ),
                        _SeasonChip(
                          label: l10n.searchSeasonRain,
                          value: _seasonRain,
                          selected: _bestSeason,
                          onTap: (v) => setState(
                            () => _bestSeason = _bestSeason == v ? null : v,
                          ),
                        ),
                        _SeasonChip(
                          label: l10n.searchSeasonAll,
                          value: _seasonAll,
                          selected: _bestSeason,
                          onTap: (v) => setState(
                            () => _bestSeason = _bestSeason == v ? null : v,
                          ),
                        ),
                      ],
                    ),

                    _SectionLabel(l10n.searchHazardLabel, top: 22),
                    _Segmented(
                      options: const ['bajo', 'medio', 'alto'],
                      labelOf: (level) => switch (level) {
                        'bajo' => l10n.searchHazardLow,
                        'medio' => l10n.searchHazardMedium,
                        _ => l10n.searchHazardHigh,
                      },
                      selected: _hazardLevel,
                      onSelect: (level) => setState(
                        () =>
                            _hazardLevel = _hazardLevel == level ? null : level,
                      ),
                    ),
                  ],

                  const SizedBox(height: 22),
                  switch (_tab) {
                    SearchTab.spots => _SpotResults(query: query),
                    SearchTab.riders => _RiderResults(query: query),
                    SearchTab.events => _EventResults(query: query),
                    SearchTab.sports => _SportResults(query: _query),
                  },
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label, {this.top = 8});

  final String label;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: 10),
      child: Text(
        label,
        style: context.typography.eyebrow.copyWith(
          color: context.colors.text300,
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = selected ? colors.colorAction : colors.text300;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? colors.tintBlue : colors.surfaceCard,
          border: Border.all(
            color: selected ? colors.colorAction : colors.hairline,
          ),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 17, color: color),
            const SizedBox(width: 7),
            Text(
              label.toUpperCase(),
              style: context.typography.title.copyWith(
                fontSize: 14,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeasonChip extends StatelessWidget {
  const _SeasonChip({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String value;
  final String? selected;
  final void Function(String value) onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final active = selected == value;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: active ? colors.tintRating : colors.surfaceCard,
          border: Border.all(
            color: active ? colors.colorRating : colors.hairline,
          ),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Text(
          label,
          style: context.typography.tag.copyWith(
            color: active ? colors.colorRating : colors.text300,
          ),
        ),
      ),
    );
  }
}

/// Single-select segmented row, tap again to clear — used for difficulty
/// (1-5) and hazard level (bajo/medio/alto).
class _Segmented<T> extends StatelessWidget {
  const _Segmented({
    required this.options,
    required this.labelOf,
    required this.selected,
    required this.onSelect,
  });

  final List<T> options;
  final String Function(T) labelOf;
  final T? selected;
  final void Function(T) onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        border: Border.all(color: colors.hairlineStrong),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (final option in options)
            Expanded(
              child: GestureDetector(
                onTap: () => onSelect(option),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected == option ? colors.colorAction : null,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text(
                    labelOf(option),
                    style: context.typography.title.copyWith(
                      fontSize: 13,
                      color: selected == option
                          ? colors.colorOnAction
                          : colors.text300,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Shared loading/error/empty/list chrome for each tab's results — only
/// the item widget and the async source differ per tab.
class _ResultsSection<T> extends StatelessWidget {
  const _ResultsSection({
    required this.resultsAsync,
    required this.itemBuilder,
  });

  final AsyncValue<List<T>> resultsAsync;
  final Widget Function(T item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;

    return resultsAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(child: Text('$error')),
      ),
      data: (items) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.searchResultsCount(items.length),
            style: context.typography.tag.copyWith(color: colors.text300),
          ),
          const SizedBox(height: 10),
          if (items.isEmpty)
            Text(l10n.searchNoResults, style: context.typography.bodySm)
          else
            for (final item in items) itemBuilder(item),
        ],
      ),
    );
  }
}

class _SpotResults extends ConsumerWidget {
  const _SpotResults({required this.query});

  final SearchQuery query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ResultsSection(
      resultsAsync: ref.watch(searchSpotsProvider(query)),
      itemBuilder: (spot) => _SearchResultRow(spot: spot),
    );
  }
}

class _RiderResults extends ConsumerWidget {
  const _RiderResults({required this.query});

  final SearchQuery query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ResultsSection(
      resultsAsync: ref.watch(searchRidersProvider(query)),
      itemBuilder: (rider) => _RiderResultRow(
        rider: rider,
        onTap: () => context.push('/riders/${rider.id}'),
      ),
    );
  }
}

class _EventResults extends ConsumerWidget {
  const _EventResults({required this.query});

  final SearchQuery query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ResultsSection(
      resultsAsync: ref.watch(searchEventsProvider(query)),
      itemBuilder: (event) => _EventResultRow(
        event: event,
        onTap: () => context.push('/events/${event.id}'),
      ),
    );
  }
}

class _SportResults extends ConsumerWidget {
  const _SportResults({required this.query});

  final String? query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sportsAsync = ref.watch(allSportsProvider);
    final filtered = sportsAsync.whenData((sports) {
      if (query == null || query!.isEmpty) return sports;
      final q = query!.toLowerCase();
      return sports.where((s) => s.name.toLowerCase().contains(q)).toList();
    });
    return _ResultsSection(
      resultsAsync: filtered,
      itemBuilder: (sport) => _SportResultRow(
        sport: sport,
        onTap: () => context.push('/sports/${sport.id}'),
      ),
    );
  }
}

class _SportResultRow extends StatelessWidget {
  const _SportResultRow({required this.sport, required this.onTap});

  final Sport sport;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final visual = SportVisual.of(sport.name, colors);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: colors.surfaceCard,
            border: Border.all(color: colors.hairline),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: visual.color.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Icon(visual.icon, size: 20, color: visual.color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sport.name,
                      style: context.typography.title.copyWith(height: 1),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      sport.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.typography.micro,
                    ),
                  ],
                ),
              ),
              Icon(Symbols.chevron_right, size: 20, color: colors.text700),
            ],
          ),
        ),
      ),
    );
  }
}

class _RiderResultRow extends StatelessWidget {
  const _RiderResultRow({required this.rider, required this.onTap});

  final Rider rider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: colors.surfaceCard,
            border: Border.all(color: colors.hairline),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              AppAvatar(
                initial: rider.nickname.isNotEmpty
                    ? rider.nickname[0].toUpperCase()
                    : '?',
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rider.nickname,
                      style: context.typography.title.copyWith(height: 1),
                    ),
                    if (rider.city != null && rider.city!.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(rider.city!, style: context.typography.micro),
                    ],
                  ],
                ),
              ),
              Icon(Symbols.chevron_right, size: 20, color: colors.text700),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventResultRow extends StatelessWidget {
  const _EventResultRow({required this.event, required this.onTap});

  final Event event;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dateLabel = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    ).format(event.startDate);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: colors.surfaceCard,
            border: Border.all(color: colors.hairline),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colors.tintInfo,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Icon(Symbols.event, size: 20, color: colors.colorBrand),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name,
                      style: context.typography.title.copyWith(height: 1),
                    ),
                    const SizedBox(height: 5),
                    Text(dateLabel, style: context.typography.micro),
                  ],
                ),
              ),
              Icon(Symbols.chevron_right, size: 20, color: colors.text700),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchResultRow extends StatelessWidget {
  const _SearchResultRow({required this.spot});

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final meta = [
      if (spot.neighborhood != null) spot.neighborhood!,
      if (spot.difficulty != null) '${spot.difficulty}/5',
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => context.push('/spot/${spot.id}'),
        child: Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: colors.surfaceCard,
            border: Border.all(color: colors.hairline),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: spot.coverPhotoUrl != null
                      ? Image.network(
                          spot.coverPhotoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: colors.surfaceMedia,
                                child: Icon(
                                  Symbols.place,
                                  color: colors.text700,
                                ),
                              ),
                        )
                      : Container(
                          color: colors.surfaceMedia,
                          alignment: Alignment.center,
                          child: Icon(Symbols.place, color: colors.text700),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spot.name,
                      style: context.typography.title.copyWith(height: 1),
                    ),
                    if (meta.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(meta, style: context.typography.micro),
                    ],
                  ],
                ),
              ),
              if (spot.ratingAvg != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Symbols.star,
                      fill: 1,
                      size: 14,
                      color: colors.colorRating,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      spot.ratingAvg!.toStringAsFixed(1),
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
      ),
    );
  }
}
