import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/arcade_sport_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/application/rider_sports_providers.dart';
import '../../../auth/data/rider_sport_api.dart';
import '../../../spots/application/spots_providers.dart';
import '../../../spots/domain/sport.dart';

/// Full-height "insert coin" sport picker — a grid of every extreme sport
/// the rider hasn't already favorited, styled like an arcade character
/// select screen. Tapping a tile adds it as the rider's next favorite and
/// closes the sheet.
class SportPickerSheet extends ConsumerStatefulWidget {
  const SportPickerSheet({
    super.key,
    required this.riderId,
    required this.excludedSportIds,
    required this.nextOrder,
  });

  final int riderId;
  final Set<int> excludedSportIds;
  final int nextOrder;

  static Future<void> show(
    BuildContext context, {
    required int riderId,
    required Set<int> excludedSportIds,
    required int nextOrder,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SportPickerSheet(
        riderId: riderId,
        excludedSportIds: excludedSportIds,
        nextOrder: nextOrder,
      ),
    );
  }

  @override
  ConsumerState<SportPickerSheet> createState() => _SportPickerSheetState();
}

class _SportPickerSheetState extends ConsumerState<SportPickerSheet> {
  int? _addingSportId;

  Future<void> _add(Sport sport) async {
    if (_addingSportId != null) return;
    setState(() => _addingSportId = sport.id);
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;
      await ref
          .read(riderSportApiProvider)
          .add(
            riderId: widget.riderId,
            sportId: sport.id,
            order: widget.nextOrder,
            idToken: idToken,
          );
      ref.invalidate(riderSportsProvider(widget.riderId));
      if (mounted) Navigator.of(context).pop();
    } on ApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _addingSportId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);
    final allSports = ref.watch(allSportsProvider).value ?? const <Sport>[];
    final available = [
      for (final sport in allSports)
        if (!widget.excludedSportIds.contains(sport.id)) sport,
    ];

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
                l10n.settingsFavoriteSportsPickerTitle.toUpperCase(),
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
                  l10n.settingsFavoriteSportsPickerHint,
                  textAlign: TextAlign.center,
                  style: context.typography.body.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.colorAction.withValues(alpha: 0),
                      colors.colorAction,
                      colors.colorAction.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: available.isEmpty
                    ? Center(
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            color: colors.colorAction,
                          ),
                        ),
                      )
                    : GridView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 4,
                              childAspectRatio: 0.74,
                            ),
                        itemCount: available.length,
                        itemBuilder: (context, index) {
                          final sport = available[index];
                          return ArcadeSportButton(
                            sport: sport,
                            busy: _addingSportId == sport.id,
                            onTap: _addingSportId == null
                                ? () => _add(sport)
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
