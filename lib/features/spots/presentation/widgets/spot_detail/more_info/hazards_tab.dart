import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../../core/network/api_exception.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../l10n/gen/app_localizations.dart';
import '../../../../../auth/application/auth_providers.dart';
import '../../../../../auth/domain/rider.dart';
import '../../../../../auth/domain/role.dart';
import '../../../../../moderation/presentation/widgets/report_dialog.dart';
import '../../../../application/spot_attributes_providers.dart';
import '../../../../data/hazzard_api.dart';
import '../../../../domain/hazzard.dart';
import '../../hazard_form_dialog.dart';

const _maxHazzardsPerSpot = 50;
const _visibleByDefault = 10;

/// `MoreInfoBox`'s "Peligros" tab — any signed-in rider can report a hazard
/// here (the backend already allowed it, this is the UI entry point) and
/// vote 💀 (confirms the danger) / 🧹 (it's improving), which drives the
/// list's order (net votes, see `crud/hazzard.py`'s `get_by_spot`). `severity`
/// stays as a visual-only badge, set only from Create/Edit Spot.
class HazardsTab extends ConsumerStatefulWidget {
  const HazardsTab({super.key, required this.hazzards, required this.spotId});

  final List<Hazzard> hazzards;
  final int spotId;

  @override
  ConsumerState<HazardsTab> createState() => _HazardsTabState();
}

class _HazardsTabState extends ConsumerState<HazardsTab> {
  late List<Hazzard> _hazards = List.of(widget.hazzards);
  bool _expanded = false;
  final _pendingIds = <int>{};
  bool _addingHazard = false;

  @override
  void didUpdateWidget(HazardsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hazzards != widget.hazzards) {
      _hazards = List.of(widget.hazzards);
    }
  }

  void _sort() {
    _hazards.sort((a, b) {
      final net = (b.skullCount - b.broomCount) - (a.skullCount - a.broomCount);
      if (net != 0) return net;
      return a.createdDate.compareTo(b.createdDate);
    });
  }

  void _refreshInBackground() {
    ref.invalidate(spotHazzardsProvider(widget.spotId));
  }

  Future<String?> _idToken() =>
      ref.read(firebaseAuthProvider).currentUser?.getIdToken() ??
      Future.value(null);

  Future<void> _vote(Hazzard hazard, String reaction) async {
    if (_pendingIds.contains(hazard.id)) return;
    final idToken = await _idToken();
    if (idToken == null) return;

    setState(() => _pendingIds.add(hazard.id));
    try {
      final updated = await ref
          .read(hazzardApiProvider)
          .vote(hazzardId: hazard.id, reaction: reaction, idToken: idToken);
      if (!mounted) return;
      setState(() {
        final index = _hazards.indexWhere((h) => h.id == updated.id);
        if (index != -1) _hazards[index] = updated;
        _sort();
      });
      _refreshInBackground();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _pendingIds.remove(hazard.id));
    }
  }

  Future<void> _addHazard() async {
    final l10n = AppLocalizations.of(context);
    final result = await showHazardFormDialog(context);
    if (result == null) return;

    setState(() => _addingHazard = true);
    try {
      final idToken = await _idToken();
      if (idToken == null) return;
      final created = await ref
          .read(hazzardApiProvider)
          .create(
            spotId: widget.spotId,
            name: result.name,
            severity: result.severity,
            idToken: idToken,
          );
      if (!mounted) return;
      setState(() {
        _hazards.add(created);
        _sort();
      });
      _refreshInBackground();
    } on ApiException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.statusCode == 409
                  ? l10n.spotHazardsLimitReached
                  : '$error',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _addingHazard = false);
    }
  }

  Future<void> _editHazard(Hazzard hazard) async {
    if (_pendingIds.contains(hazard.id)) return;
    final result = await showHazardFormDialog(
      context,
      existingName: hazard.name,
      existingSeverity: hazard.severity ?? 3,
    );
    if (result == null) return;

    setState(() => _pendingIds.add(hazard.id));
    try {
      final idToken = await _idToken();
      if (idToken == null) return;
      final updated = await ref
          .read(hazzardApiProvider)
          .update(
            hazzardId: hazard.id,
            name: result.name,
            severity: result.severity,
            idToken: idToken,
          );
      if (!mounted) return;
      setState(() {
        final index = _hazards.indexWhere((h) => h.id == updated.id);
        if (index != -1) _hazards[index] = updated;
      });
      _refreshInBackground();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _pendingIds.remove(hazard.id));
    }
  }

  Future<void> _deleteHazard(Hazzard hazard) async {
    if (_pendingIds.contains(hazard.id)) return;
    setState(() => _pendingIds.add(hazard.id));
    try {
      final idToken = await _idToken();
      if (idToken == null) return;
      await ref
          .read(hazzardApiProvider)
          .delete(hazzardId: hazard.id, idToken: idToken);
      if (!mounted) return;
      setState(() => _hazards.removeWhere((h) => h.id == hazard.id));
      _refreshInBackground();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _pendingIds.remove(hazard.id));
    }
  }

  bool _canManage(Hazzard hazard, Rider? currentRider) {
    if (currentRider == null) return false;
    if (currentRider.roleId >= roleAdmin) return true;
    return currentRider.id == hazard.reportedBy;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final isSignedIn = ref.watch(firebaseAuthProvider).currentUser != null;
    final currentRider = ref.watch(currentRiderProvider).value;

    final visible = _expanded
        ? _hazards
        : _hazards.take(_visibleByDefault).toList();
    final atCap = _hazards.length >= _maxHazzardsPerSpot;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.spotHazardsTitle(_hazards.length),
            style: context.typography.tag.copyWith(color: colors.text300),
          ),
          const SizedBox(height: 12),
          if (_hazards.isEmpty)
            Text(l10n.spotNoHazards, style: context.typography.bodySm)
          else
            for (final hazard in visible)
              _HazzardRow(
                hazard: hazard,
                busy: _pendingIds.contains(hazard.id),
                canVote: isSignedIn,
                canManage: _canManage(hazard, currentRider),
                onVote: (reaction) => _vote(hazard, reaction),
                onReport: () =>
                    ReportDialog.show(context, targetType: 'hazzard', targetId: hazard.id),
                onEdit: () => _editHazard(hazard),
                onDelete: () => _deleteHazard(hazard),
              ),
          if (!_expanded && _hazards.length > _visibleByDefault)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: TextButton(
                onPressed: () => setState(() => _expanded = true),
                child: Text(l10n.spotHazardsSeeMore(_hazards.length)),
              ),
            ),
          if (atCap)
            Text(l10n.spotHazardsLimitReached, style: context.typography.micro)
          else
            TextButton.icon(
              onPressed: isSignedIn && !_addingHazard ? _addHazard : null,
              icon: const Icon(Symbols.add),
              label: Text(l10n.spotHazardsAddButton),
            ),
        ],
      ),
    );
  }
}

class _HazzardRow extends StatelessWidget {
  const _HazzardRow({
    required this.hazard,
    required this.busy,
    required this.canVote,
    required this.canManage,
    required this.onVote,
    required this.onReport,
    required this.onEdit,
    required this.onDelete,
  });

  final Hazzard hazard;
  final bool busy;
  final bool canVote;
  final bool canManage;
  final void Function(String reaction) onVote;
  final VoidCallback onReport;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final severity = hazard.severity ?? 1;
    final (Color color, Color background, Color border) = severity <= 2
        ? (
            colors.colorRating,
            colors.tintRating,
            colors.colorRating.withValues(alpha: .28),
          )
        : severity == 3
        ? (
            colors.colorWarn,
            colors.tintWarn,
            colors.colorWarn.withValues(alpha: .28),
          )
        : (
            colors.colorDanger,
            colors.tintDanger,
            colors.colorDanger.withValues(alpha: .28),
          );

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: background,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(context.spacing.radiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Symbols.warning, size: 22, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hazard.name,
                        style: context.typography.title.copyWith(height: 1),
                      ),
                      if (hazard.description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          hazard.description!,
                          style: context.typography.micro,
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .25),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    'SEV $severity',
                    style: context.typography.tag.copyWith(color: color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _ReactionButton(
                  emoji: '💀',
                  count: hazard.skullCount,
                  enabled: canVote && !busy,
                  onTap: () => onVote('skull'),
                ),
                const SizedBox(width: 10),
                _ReactionButton(
                  emoji: '🧹',
                  count: hazard.broomCount,
                  enabled: canVote && !busy,
                  onTap: () => onVote('broom'),
                ),
                const Spacer(),
                if (canManage) ...[
                  GestureDetector(
                    onTap: busy ? null : onEdit,
                    child: Icon(Symbols.edit, size: 16, color: colors.textMuted),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: busy ? null : onDelete,
                    child: Icon(
                      Symbols.delete,
                      size: 16,
                      color: colors.textMuted,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                GestureDetector(
                  onTap: onReport,
                  child: Icon(Symbols.flag, size: 16, color: colors.textMuted),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReactionButton extends StatelessWidget {
  const _ReactionButton({
    required this.emoji,
    required this.count,
    required this.enabled,
    required this.onTap,
  });

  final String emoji;
  final int count;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 5),
          Text('$count', style: context.typography.meta),
        ],
      ),
    );
  }
}
