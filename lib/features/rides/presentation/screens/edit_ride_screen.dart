import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/ride_detail.dart';
import '../../application/rides_providers.dart';
import '../../data/ride_api.dart';
import '../../domain/ride_element.dart';
import '../../domain/ride_state.dart';
import '../../domain/rider_photo.dart';

class _ElementFormResult {
  const _ElementFormResult(this.name, this.type);
  final String name;
  final String? type;
}

/// Edits an existing [Ride]'s own fields — name, state, condition, which
/// already-tagged photo is the cover — plus its elements (add/edit/delete,
/// each applied immediately). Doesn't touch photos/videos themselves
/// (uploading/tagging new media only happens during creation, in
/// `CreateRideScreen` — out of scope here, matching what the backend's
/// `RideUpdate` schema actually supports).
class EditRideScreen extends ConsumerStatefulWidget {
  const EditRideScreen({super.key, required this.rideId});

  final int rideId;

  @override
  ConsumerState<EditRideScreen> createState() => _EditRideScreenState();
}

class _EditRideScreenState extends ConsumerState<EditRideScreen> {
  final _nameController = TextEditingController();
  int? _stateId;
  int? _condition;
  int? _coverPhotoId;
  bool _seeded = false;
  bool _saving = false;
  bool _deleting = false;
  final Set<int> _pendingElements = {};
  bool _addingElement = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _seed(RideDetailData detail) {
    if (_seeded) return;
    _nameController.text = detail.ride.name;
    _stateId = detail.ride.stateId;
    _condition = detail.ride.condition;
    _coverPhotoId = detail.ride.coverPhotoId;
    _seeded = true;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(rideApiProvider)
          .update(
            rideId: widget.rideId,
            name: _nameController.text.trim(),
            stateId: _stateId,
            condition: _condition,
            coverPhotoId: _coverPhotoId,
            idToken: idToken,
          );

      ref.invalidate(rideDetailProvider(widget.rideId));
      final riderId = ref.read(currentRiderProvider).value?.id;
      if (riderId != null) {
        ref.invalidate(ridesByOwnerProvider(riderId));
      }
      if (mounted) context.pop();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _confirmDelete() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: context.colors.surfaceCard,
        title: Text(
          l10n.rideDeleteConfirmTitle,
          style: context.typography.title,
        ),
        content: Text(l10n.rideDeleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.dialogCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.rideDelete,
              style: TextStyle(color: context.colors.colorDanger),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _deleting = true);
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(rideApiProvider)
          .delete(rideId: widget.rideId, idToken: idToken);

      final riderId = ref.read(currentRiderProvider).value?.id;
      if (riderId != null) {
        ref.invalidate(ridesByOwnerProvider(riderId));
      }
      if (mounted) {
        // Pop back past the now-deleted ride's own RideScreen (not
        // `context.go('/rides')`, which would replace the whole navigation
        // stack and strand Home out of the back history).
        final navigator = Navigator.of(context);
        navigator.pop();
        navigator.pop();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  Future<_ElementFormResult?> _showElementDialog({RideElement? existing}) {
    final l10n = AppLocalizations.of(context);
    final nameController = TextEditingController(text: existing?.name ?? '');
    final typeController = TextEditingController(text: existing?.type ?? '');

    return showDialog<_ElementFormResult>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: context.colors.surfaceCard,
        title: Text(
          existing == null ? l10n.createRideAddElement : l10n.rideEditElement,
          style: context.typography.title,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: nameController,
              placeholder: l10n.createRideElementNamePlaceholder,
            ),
            const SizedBox(height: 10),
            AppTextField(
              controller: typeController,
              placeholder: l10n.createRideElementTypePlaceholder,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.dialogCancel),
          ),
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isEmpty) return;
              final type = typeController.text.trim();
              Navigator.of(
                dialogContext,
              ).pop(_ElementFormResult(name, type.isEmpty ? null : type));
            },
            child: Text(existing == null ? l10n.dialogAdd : l10n.settingsSave),
          ),
        ],
      ),
    );
  }

  Future<void> _addElement() async {
    final result = await _showElementDialog();
    if (result == null) return;

    setState(() => _addingElement = true);
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(rideApiProvider)
          .addElement(
            rideId: widget.rideId,
            name: result.name,
            type: result.type,
            idToken: idToken,
          );
      ref.invalidate(rideDetailProvider(widget.rideId));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _addingElement = false);
    }
  }

  Future<void> _editElement(RideElement element) async {
    if (_pendingElements.contains(element.id)) return;
    final result = await _showElementDialog(existing: element);
    if (result == null) return;

    setState(() => _pendingElements.add(element.id));
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(rideApiProvider)
          .updateElement(
            rideId: widget.rideId,
            elementId: element.id,
            name: result.name,
            type: result.type,
            idToken: idToken,
          );
      ref.invalidate(rideDetailProvider(widget.rideId));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _pendingElements.remove(element.id));
    }
  }

  Future<void> _deleteElement(RideElement element) async {
    if (_pendingElements.contains(element.id)) return;

    setState(() => _pendingElements.add(element.id));
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(rideApiProvider)
          .deleteElement(
            rideId: widget.rideId,
            elementId: element.id,
            idToken: idToken,
          );
      ref.invalidate(rideDetailProvider(widget.rideId));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _pendingElements.remove(element.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final detailAsync = ref.watch(rideDetailProvider(widget.rideId));
    final states = ref.watch(rideStatesProvider).value ?? const <RideState>[];

    return Scaffold(
      body: SafeArea(
        child: detailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (detail) {
            _seed(detail);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
                  child: Row(
                    children: [
                      AppIconButton(
                        icon: Symbols.close,
                        onPressed: () => context.pop(),
                      ),
                      const SizedBox(width: 14),
                      Text(l10n.rideEdit, style: context.typography.displaySm),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(18, 4, 18, 20),
                    children: [
                      _SectionLabel(l10n.createRideNameLabel),
                      AppTextField(
                        controller: _nameController,
                        placeholder: l10n.createRideNamePlaceholder,
                      ),

                      _SectionLabel(l10n.createRideStateLabel, top: 18),
                      AppDropdown<int>(
                        value: _stateId,
                        placeholder: '—',
                        items: [
                          for (final state in states)
                            DropdownMenuItem(
                              value: state.id,
                              child: Text(_stateLabel(l10n, state.name)),
                            ),
                        ],
                        onChanged: (value) => setState(() => _stateId = value),
                      ),

                      _SectionLabel(
                        l10n.rideElementsTitle(detail.elements.length),
                        top: 18,
                      ),
                      if (detail.elements.isEmpty)
                        Text(
                          l10n.rideNoElements,
                          style: context.typography.bodySm,
                        )
                      else
                        for (final element in detail.elements)
                          _ElementEditRow(
                            element: element,
                            busy: _pendingElements.contains(element.id),
                            onTap: () => _editElement(element),
                            onDelete: () => _deleteElement(element),
                          ),
                      const SizedBox(height: 9),
                      GestureDetector(
                        onTap: _addingElement ? null : _addElement,
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: colors.surfaceCard,
                            border: Border.all(color: colors.hairlineStrong),
                            borderRadius: BorderRadius.circular(
                              context.spacing.radiusMd,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Symbols.add_circle,
                                color: colors.colorBrand,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  l10n.createRideAddElement,
                                  style: context.typography.bodySm,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      _SectionLabel(l10n.createRideConditionLabel, top: 18),
                      _Segmented(
                        options: const [1, 2, 3, 4, 5],
                        labelOf: (c) => '$c',
                        selected: _condition,
                        onSelect: (c) => setState(
                          () => _condition = _condition == c ? null : c,
                        ),
                      ),

                      if (detail.photos.isNotEmpty) ...[
                        _SectionLabel(l10n.createRideCoverHint, top: 18),
                        SizedBox(
                          height: 84,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: detail.photos.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) => _CoverThumb(
                              photo: detail.photos[index],
                              isCover: detail.photos[index].id == _coverPhotoId,
                              onTap: () => setState(
                                () => _coverPhotoId = detail.photos[index].id,
                              ),
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: _deleting ? null : _confirmDelete,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Symbols.delete,
                              size: 18,
                              color: colors.colorDanger,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.rideDelete,
                              style: context.typography.title.copyWith(
                                color: colors.colorDanger,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
                  decoration: BoxDecoration(
                    color: colors.surfaceApp,
                    border: Border(top: BorderSide(color: colors.hairlineSoft)),
                  ),
                  child: AppButton(
                    label: _saving ? '…' : l10n.settingsSave,
                    onPressed: _saving ? null : _save,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

String _stateLabel(AppLocalizations l10n, String name) {
  return switch (name) {
    'active' => l10n.rideStateActive,
    'onSale' => l10n.rideStateOnSale,
    'wasted' => l10n.rideStateWasted,
    'toGift' => l10n.rideStateToGift,
    _ => name,
  };
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label, {this.top = 8});

  final String label;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: 8),
      child: Text(
        label,
        style: context.typography.eyebrow.copyWith(
          color: context.colors.textMuted,
        ),
      ),
    );
  }
}

/// Single-select segmented row, tap again to clear — same pattern as
/// `CreateRideScreen`'s own `_Segmented` (private to that file, so
/// duplicated here rather than shared).
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

class _CoverThumb extends StatelessWidget {
  const _CoverThumb({
    required this.photo,
    required this.isCover,
    required this.onTap,
  });

  final RiderPhoto photo;
  final bool isCover;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 84,
        height: 84,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                photo.url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: colors.surfaceMedia,
                  alignment: Alignment.center,
                  child: Icon(Symbols.broken_image, color: colors.text700),
                ),
              ),
            ),
            if (isCover)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.colorAction, width: 2.5),
                  ),
                ),
              ),
            if (isCover)
              Positioned(
                left: 5,
                bottom: 5,
                child: Icon(
                  Symbols.star,
                  fill: 1,
                  size: 18,
                  color: colors.colorAction,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// A single [RideElement] row — tap anywhere to edit, tap the trailing icon
/// to delete. Dims and disables both while [busy] (a request for this
/// element is in flight), same guard pattern as Settings' favorite-sport
/// chips.
class _ElementEditRow extends StatelessWidget {
  const _ElementEditRow({
    required this.element,
    required this.busy,
    required this.onTap,
    required this.onDelete,
  });

  final RideElement element;
  final bool busy;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Opacity(
      opacity: busy ? .5 : 1,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 9),
        child: GestureDetector(
          onTap: busy ? null : onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.surfaceCard,
              border: Border.all(color: colors.hairline),
              borderRadius: BorderRadius.circular(context.spacing.radiusMd),
            ),
            child: Row(
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
                    Symbols.build,
                    size: 18,
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
                GestureDetector(
                  onTap: busy ? null : onDelete,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Symbols.delete,
                      size: 18,
                      color: colors.colorDanger,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
