import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/arcade_sport_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/application/rider_sports_providers.dart';
import '../../../auth/data/rider_sport_api.dart';
import '../../../auth/domain/rider_sport.dart';
import '../../../spots/application/spots_providers.dart';
import '../../../spots/domain/sport.dart';
import 'add_sport_button.dart';
import 'sport_picker_sheet.dart';

/// Redesigned "favorite sports" picker — an arcade-style row of the
/// rider's favorites (drag to reorder, tap the badge to remove) plus a
/// "+" slot that opens [SportPickerSheet] to add one more, one at a time.
///
/// Removal is blocked (lock badge instead of an X) for any sport the rider
/// has published spots under — `RiderSport.hasLinkedSpots`, computed
/// server-side. `SportTrick` isn't factored in: it's a global catalog with
/// no rider/spot link in the schema yet, nothing to check against today.
class FavoriteSportsSection extends ConsumerStatefulWidget {
  const FavoriteSportsSection({super.key, required this.riderId});

  final int riderId;

  @override
  ConsumerState<FavoriteSportsSection> createState() =>
      _FavoriteSportsSectionState();
}

class _FavoriteSportsSectionState extends ConsumerState<FavoriteSportsSection> {
  bool _reordering = false;
  int? _removingSportId;

  Future<String?> _idToken() =>
      ref.read(firebaseAuthProvider).currentUser?.getIdToken() ??
      Future.value(null);

  Future<void> _onReorder(
    List<RiderSport> current,
    int oldIndex,
    int newIndex,
  ) async {
    if (_reordering) return;
    // `onReorderItem` (unlike the deprecated `onReorder`) already adjusts
    // `newIndex` for the removed item at `oldIndex` — no manual `-1` needed.
    final reordered = [...current];
    final moved = reordered.removeAt(oldIndex);
    reordered.insert(newIndex, moved);

    setState(() => _reordering = true);
    try {
      final idToken = await _idToken();
      if (idToken == null) return;
      await ref
          .read(riderSportApiProvider)
          .reorder(
            riderId: widget.riderId,
            sportIds: [for (final rs in reordered) rs.sportId],
            idToken: idToken,
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      ref.invalidate(riderSportsProvider(widget.riderId));
      if (mounted) setState(() => _reordering = false);
    }
  }

  Future<void> _remove(RiderSport rs) async {
    final l10n = AppLocalizations.of(context);
    if (rs.hasLinkedSpots) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.settingsFavoriteSportsLocked)),
      );
      return;
    }
    if (_removingSportId != null) return;
    setState(() => _removingSportId = rs.sportId);
    try {
      final idToken = await _idToken();
      if (idToken == null) return;
      await ref
          .read(riderSportApiProvider)
          .remove(
            riderId: widget.riderId,
            sportId: rs.sportId,
            idToken: idToken,
          );
      ref.invalidate(riderSportsProvider(widget.riderId));
    } on ApiException catch (e) {
      // 409 = the backend's own linked-spots guard (e.g. a spot published
      // in the moment between this button rendering and the tap landing).
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.statusCode == 409 ? l10n.settingsFavoriteSportsLocked : '$e',
            ),
          ),
        );
      }
      ref.invalidate(riderSportsProvider(widget.riderId));
    } finally {
      if (mounted) setState(() => _removingSportId = null);
    }
  }

  void _openPicker(List<RiderSport> current) {
    SportPickerSheet.show(
      context,
      riderId: widget.riderId,
      excludedSportIds: {for (final rs in current) rs.sportId},
      nextOrder: current.length + 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);
    final riderSports =
        ref.watch(riderSportsProvider(widget.riderId)).value ??
        const <RiderSport>[];
    final allSports = ref.watch(allSportsProvider).value ?? const <Sport>[];
    final sportById = {for (final sport in allSports) sport.id: sport};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.settingsFavoriteSportsSection.toUpperCase(),
          style: context.typography.eyebrow.copyWith(color: colors.text300),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.settingsFavoriteSportsHint,
          style: context.typography.body.copyWith(color: colors.textMuted),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 128,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReorderableListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  buildDefaultDragHandles: !_reordering,
                  onReorderItem: (oldIndex, newIndex) =>
                      _onReorder(riderSports, oldIndex, newIndex),
                  children: [
                    for (final rs in riderSports)
                      if (sportById[rs.sportId] case final sport?)
                        Padding(
                          key: ValueKey(rs.sportId),
                          padding: const EdgeInsets.only(right: 10),
                          child: ArcadeSportButton(
                            sport: sport,
                            rank: rs.order,
                            locked: rs.hasLinkedSpots,
                            busy: _removingSportId == rs.sportId,
                            onRemove: () => _remove(rs),
                          ),
                        ),
                  ],
                ),
                if (riderSports.length < 10)
                  AddSportButton(onTap: () => _openPicker(riderSports)),
              ],
            ),
          ),
        ),
        if (riderSports.length >= 10) ...[
          const SizedBox(height: 6),
          Text(
            l10n.settingsFavoriteSportsMax,
            style: context.typography.meta.copyWith(color: colors.textMuted),
          ),
        ],
      ],
    );
  }
}
