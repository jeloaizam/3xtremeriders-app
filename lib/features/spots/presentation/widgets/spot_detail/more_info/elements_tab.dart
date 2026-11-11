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
import '../../../../data/spot_api.dart';
import '../../../../domain/spot_element.dart';
import '../../../sport_visuals.dart';
import '../../element_form_dialog.dart';

const _maxElementsPerSpot = 50;
const _visibleByDefault = 10;

/// `MoreInfoBox`'s "Elementos" tab — any signed-in rider can add an element
/// here (the fixed one-per-type toggle grid in Create/Edit Spot stays as
/// the owner's quick setup, this is a parallel crowd-sourced entry point)
/// and vote 👍/👎, which drives the list's order (net votes, see
/// `crud/spot.py`'s `get_elements`). `difficulty` stays as a visual-only dot
/// row, same as before.
class ElementsTab extends ConsumerStatefulWidget {
  const ElementsTab({super.key, required this.elements, required this.spotId});

  final List<SpotElement> elements;
  final int spotId;

  @override
  ConsumerState<ElementsTab> createState() => _ElementsTabState();
}

class _ElementsTabState extends ConsumerState<ElementsTab> {
  late List<SpotElement> _elements = List.of(widget.elements);
  bool _expanded = false;
  final _pendingIds = <int>{};
  bool _addingElement = false;

  @override
  void didUpdateWidget(ElementsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.elements != widget.elements) {
      _elements = List.of(widget.elements);
    }
  }

  void _sort() {
    _elements.sort((a, b) {
      final net = (b.likeCount - b.dislikeCount) - (a.likeCount - a.dislikeCount);
      if (net != 0) return net;
      return a.createdDate.compareTo(b.createdDate);
    });
  }

  void _refreshInBackground() {
    ref.invalidate(spotElementsProvider(widget.spotId));
  }

  Future<String?> _idToken() =>
      ref.read(firebaseAuthProvider).currentUser?.getIdToken() ??
      Future.value(null);

  Future<void> _vote(SpotElement element, String reaction) async {
    if (_pendingIds.contains(element.id)) return;
    final idToken = await _idToken();
    if (idToken == null) return;

    setState(() => _pendingIds.add(element.id));
    try {
      final updated = await ref
          .read(spotApiProvider)
          .voteElement(
            elementId: element.id,
            reaction: reaction,
            idToken: idToken,
          );
      if (!mounted) return;
      setState(() {
        final index = _elements.indexWhere((e) => e.id == updated.id);
        if (index != -1) _elements[index] = updated;
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
      if (mounted) setState(() => _pendingIds.remove(element.id));
    }
  }

  Future<void> _addElement() async {
    final l10n = AppLocalizations.of(context);
    final result = await showElementFormDialog(context);
    if (result == null) return;

    setState(() => _addingElement = true);
    try {
      final idToken = await _idToken();
      if (idToken == null) return;
      final created = await ref
          .read(spotApiProvider)
          .addElement(
            spotId: widget.spotId,
            name: result.name,
            type: result.type,
            difficulty: result.difficulty,
            idToken: idToken,
          );
      if (!mounted) return;
      setState(() {
        _elements.add(created);
        _sort();
      });
      _refreshInBackground();
    } on ApiException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.statusCode == 409
                  ? l10n.spotElementsLimitReached
                  : '$error',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _addingElement = false);
    }
  }

  Future<void> _deleteElement(SpotElement element) async {
    if (_pendingIds.contains(element.id)) return;
    setState(() => _pendingIds.add(element.id));
    try {
      final idToken = await _idToken();
      if (idToken == null) return;
      await ref
          .read(spotApiProvider)
          .deleteElement(
            spotId: widget.spotId,
            elementId: element.id,
            idToken: idToken,
          );
      if (!mounted) return;
      setState(() => _elements.removeWhere((e) => e.id == element.id));
      _refreshInBackground();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _pendingIds.remove(element.id));
    }
  }

  bool _canManage(SpotElement element, Rider? currentRider) {
    if (currentRider == null) return false;
    if (currentRider.roleId >= roleAdmin) return true;
    return currentRider.id == element.reportedBy;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final isSignedIn = ref.watch(firebaseAuthProvider).currentUser != null;
    final currentRider = ref.watch(currentRiderProvider).value;

    final visible = _expanded
        ? _elements
        : _elements.take(_visibleByDefault).toList();
    final atCap = _elements.length >= _maxElementsPerSpot;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.spotElementsTitle(_elements.length),
            style: context.typography.tag.copyWith(color: colors.text300),
          ),
          const SizedBox(height: 12),
          if (_elements.isEmpty)
            Text(l10n.spotNoElements, style: context.typography.bodySm)
          else
            for (final element in visible)
              _ElementRow(
                element: element,
                busy: _pendingIds.contains(element.id),
                canVote: isSignedIn,
                canManage: _canManage(element, currentRider),
                onVote: (reaction) => _vote(element, reaction),
                onReport: () => ReportDialog.show(
                  context,
                  targetType: 'spot_element',
                  targetId: element.id,
                ),
                onDelete: () => _deleteElement(element),
              ),
          if (!_expanded && _elements.length > _visibleByDefault)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: TextButton(
                onPressed: () => setState(() => _expanded = true),
                child: Text(l10n.spotElementsSeeMore(_elements.length)),
              ),
            ),
          if (atCap)
            Text(
              l10n.spotElementsLimitReached,
              style: context.typography.micro,
            )
          else
            TextButton.icon(
              onPressed: isSignedIn && !_addingElement ? _addElement : null,
              icon: const Icon(Symbols.add),
              label: Text(l10n.spotElementsAddButton),
            ),
        ],
      ),
    );
  }
}

class _ElementRow extends StatelessWidget {
  const _ElementRow({
    required this.element,
    required this.busy,
    required this.canVote,
    required this.canManage,
    required this.onVote,
    required this.onReport,
    required this.onDelete,
  });

  final SpotElement element;
  final bool busy;
  final bool canVote;
  final bool canManage;
  final void Function(String reaction) onVote;
  final VoidCallback onReport;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final difficulty = element.difficulty ?? 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfaceCard,
          border: Border.all(color: colors.hairline),
          borderRadius: BorderRadius.circular(context.spacing.radiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.tintInfo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    elementIcon(element.type),
                    size: 20,
                    color: colors.colorBrand,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.name,
                        style: context.typography.title.copyWith(height: 1),
                      ),
                      if (element.type != null) ...[
                        const SizedBox(height: 4),
                        Text(element.type!, style: context.typography.micro),
                      ],
                    ],
                  ),
                ),
                Row(
                  children: [
                    for (var i = 1; i <= 5; i++)
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(left: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i <= difficulty
                              ? colors.colorBrand
                              : colors.hairlineStrong,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _ReactionButton(
                  icon: Symbols.thumb_up,
                  count: element.likeCount,
                  enabled: canVote && !busy,
                  onTap: () => onVote('like'),
                ),
                const SizedBox(width: 10),
                _ReactionButton(
                  icon: Symbols.thumb_down,
                  count: element.dislikeCount,
                  enabled: canVote && !busy,
                  onTap: () => onVote('dislike'),
                ),
                const Spacer(),
                if (canManage) ...[
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
    required this.icon,
    required this.count,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
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
          Icon(icon, size: 16, color: context.colors.textMuted),
          const SizedBox(width: 5),
          Text('$count', style: context.typography.meta),
        ],
      ),
    );
  }
}
