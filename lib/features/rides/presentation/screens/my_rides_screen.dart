import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/rides_providers.dart';
import '../../domain/ride.dart';
import '../../domain/ride_state.dart';
import '../ride_state_visuals.dart';

/// Mirrors the "MIS RIDES" drawer entry — a rider's gear/vehicles
/// (`Ride`), each opening onto the full [RideScreen] on tap.
class MyRidesScreen extends ConsumerWidget {
  const MyRidesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final riderId = ref.watch(currentRiderProvider).value?.id;
    final ridesAsync = riderId == null
        ? const AsyncValue<List<Ride>>.data([])
        : ref.watch(ridesByOwnerProvider(riderId));
    final states = ref.watch(rideStatesProvider).value ?? const <RideState>[];

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
                      l10n.ridesTitle,
                      style: context.typography.displaySm,
                    ),
                  ),
                  AppIconButton(
                    icon: Symbols.add,
                    onPressed: () => context.push('/rides/new'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ridesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('$error')),
                data: (rides) => rides.isEmpty
                    ? Center(
                        child: Text(
                          l10n.ridesEmpty,
                          style: context.typography.bodySm,
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(18, 4, 18, 20),
                        children: [
                          for (final ride in rides)
                            _RideRow(
                              ride: ride,
                              state: _findState(states, ride.stateId),
                              onTap: () => context.push('/rides/${ride.id}'),
                            ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

RideState? _findState(List<RideState> states, int? stateId) {
  if (stateId == null) return null;
  for (final state in states) {
    if (state.id == stateId) return state;
  }
  return null;
}

class _RideRow extends StatelessWidget {
  const _RideRow({
    required this.ride,
    required this.state,
    required this.onTap,
  });

  final Ride ride;
  final RideState? state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final visual = RideStateVisual.of(
      state?.name,
      colors,
      AppLocalizations.of(context),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: colors.surfaceCard,
            border: Border.all(color: colors.hairline),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: ride.coverPhotoUrl != null
                      ? Image.network(
                          ride.coverPhotoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: colors.tintInfo,
                                alignment: Alignment.center,
                                child: Icon(
                                  Symbols.pedal_bike,
                                  size: 22,
                                  color: colors.colorBrand,
                                ),
                              ),
                        )
                      : Container(
                          color: colors.tintInfo,
                          alignment: Alignment.center,
                          child: Icon(
                            Symbols.pedal_bike,
                            size: 22,
                            color: colors.colorBrand,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  ride.name,
                  style: context.typography.title.copyWith(height: 1),
                ),
              ),
              if (visual != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: visual.color.withValues(alpha: .14),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    visual.label,
                    style: context.typography.tag.copyWith(color: visual.color),
                  ),
                ),
              const SizedBox(width: 6),
              Icon(Symbols.chevron_right, size: 20, color: colors.text700),
            ],
          ),
        ),
      ),
    );
  }
}
