import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/arcade_sport_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/application/rider_sports_providers.dart';
import '../../../auth/domain/rider_sport.dart';
import '../../../spots/application/spots_providers.dart';
import '../../../spots/domain/sport.dart';

/// Single-select picker among the rider's own favorite sports — sets
/// `Rider.activeSportId`, which drives Home's carousel ordering and the
/// sport preselected when creating a new spot. Opened by double-tapping
/// Home's bottom-nav sport item (a single tap still goes to that sport's
/// detail screen, unchanged).
class ActiveSportPickerSheet extends ConsumerStatefulWidget {
  const ActiveSportPickerSheet({super.key, required this.riderId});

  final int riderId;

  static Future<void> show(BuildContext context, {required int riderId}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ActiveSportPickerSheet(riderId: riderId),
    );
  }

  @override
  ConsumerState<ActiveSportPickerSheet> createState() =>
      _ActiveSportPickerSheetState();
}

class _ActiveSportPickerSheetState
    extends ConsumerState<ActiveSportPickerSheet> {
  int? _saving;

  Future<void> _select(int sportId) async {
    if (_saving != null) return;
    setState(() => _saving = sportId);
    try {
      await ref.read(currentRiderProvider.notifier).setActiveSport(sportId);
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);
    final favorites =
        ref.watch(riderSportsProvider(widget.riderId)).value ??
        const <RiderSport>[];
    final allSports = ref.watch(allSportsProvider).value ?? const <Sport>[];
    final sportById = {for (final sport in allSports) sport.id: sport};
    final activeSportId = ref.watch(effectiveActiveSportIdProvider).value;

    final ordered = [...favorites]..sort((a, b) => a.order.compareTo(b.order));

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.85,
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
                l10n.homeActiveSportPickerTitle.toUpperCase(),
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
                  l10n.homeActiveSportPickerHint,
                  textAlign: TextAlign.center,
                  style: context.typography.body.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ordered.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            l10n.homeActiveSportPickerEmpty,
                            textAlign: TextAlign.center,
                            style: context.typography.body.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ),
                      )
                    : GridView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.fromLTRB(20, 6, 20, 32),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 4,
                              childAspectRatio: 0.74,
                            ),
                        itemCount: ordered.length,
                        itemBuilder: (context, index) {
                          final rs = ordered[index];
                          final sport = sportById[rs.sportId];
                          if (sport == null) return const SizedBox.shrink();
                          return ArcadeSportButton(
                            sport: sport,
                            selected: sport.id == activeSportId,
                            busy: _saving == sport.id,
                            onTap: _saving == null
                                ? () => _select(sport.id)
                                : null,
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
