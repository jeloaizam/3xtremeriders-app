import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/arcade_sport_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../spots/application/spots_providers.dart';
import '../../../spots/domain/sport.dart';

/// Multi-select picker ("Personalizar mapa") for which sports show on
/// Home's map/carousel — replaces the bottom-nav's old "Buscar" shortcut
/// (full text search is still reachable from Home's header search bar and
/// its `tune` icon, so nothing is lost). Every toggle saves immediately,
/// same instant-apply feel as the favorite-sports picker.
class MapSportFilterSheet extends ConsumerStatefulWidget {
  const MapSportFilterSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const MapSportFilterSheet(),
    );
  }

  @override
  ConsumerState<MapSportFilterSheet> createState() =>
      _MapSportFilterSheetState();
}

class _MapSportFilterSheetState extends ConsumerState<MapSportFilterSheet> {
  bool _saving = false;

  Future<void> _apply(List<int>? filter) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await ref.read(currentRiderProvider.notifier).setMapSportFilter(filter);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _toggle(int sportId, Set<int> visible, int totalCount) async {
    final next = {...visible};
    if (!next.remove(sportId)) next.add(sportId);
    // A full set is equivalent to "no filter" — send null so newly-added
    // sports in the catalog show up automatically instead of staying
    // excluded from a frozen snapshot.
    await _apply(next.length == totalCount ? null : next.toList());
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);
    final rider = ref.watch(currentRiderProvider).value;
    final allSports = ref.watch(allSportsProvider).value ?? const <Sport>[];
    final filter = rider?.mapSportFilter;
    final visible = filter == null
        ? {for (final sport in allSports) sport.id}
        : filter.toSet();

    return DraggableScrollableSheet(
      initialChildSize: 0.86,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colors.bg850,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(context.spacing.radius2xl),
            ),
            border: Border.all(color: colors.colorAction.withValues(alpha: .3)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.hairlineStrong,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                l10n.homeMapFilterTitle.toUpperCase(),
                textAlign: TextAlign.center,
                style: context.typography.displaySm.copyWith(
                  color: colors.colorAction,
                  shadows: [
                    Shadow(
                      color: colors.colorAction.withValues(alpha: .65),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  l10n.homeMapFilterHint,
                  textAlign: TextAlign.center,
                  style: context.typography.body.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _saving ? null : () => _apply(null),
                    child: Text(l10n.homeMapFilterAll),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: _saving ? null : () => _apply(const []),
                    child: Text(l10n.homeMapFilterNone),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 32),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.74,
                  ),
                  itemCount: allSports.length,
                  itemBuilder: (context, index) {
                    final sport = allSports[index];
                    return ArcadeSportButton(
                      sport: sport,
                      selected: visible.contains(sport.id),
                      busy: _saving,
                      onTap: _saving
                          ? null
                          : () => _toggle(sport.id, visible, allSports.length),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
