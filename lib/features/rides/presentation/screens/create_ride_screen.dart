import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/storage/storage_api.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/rides_providers.dart';
import '../../data/ride_api.dart';
import '../../data/rider_photo_api.dart';
import '../../data/rider_video_api.dart';
import '../../domain/ride_state.dart';

const _maxVideoDuration = Duration(seconds: 90);

class _PendingElement {
  const _PendingElement(this.name, this.type);
  final String name;
  final String? type;
}

/// Publishes a new [Ride] (the rider's gear/vehicle), then attaches its
/// elements and an optional cover photo/video (tagged with the new ride's
/// id) right after creation — mirrors CreateSpotScreen's flow.
class CreateRideScreen extends ConsumerStatefulWidget {
  const CreateRideScreen({super.key});

  @override
  ConsumerState<CreateRideScreen> createState() => _CreateRideScreenState();
}

class _CreateRideScreenState extends ConsumerState<CreateRideScreen> {
  final _nameController = TextEditingController();
  final List<_PendingElement> _elements = [];
  int? _stateId;
  int? _condition;
  final List<XFile> _photoFiles = [];
  int _coverIndex = 0;
  XFile? _videoFile;
  bool _submitting = false;
  bool _showErrors = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _addElement() async {
    final l10n = AppLocalizations.of(context);
    final nameController = TextEditingController();
    final typeController = TextEditingController();

    final result = await showDialog<_PendingElement>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: context.colors.surfaceCard,
        title: Text(l10n.createRideAddElement, style: context.typography.title),
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
              ).pop(_PendingElement(name, type.isEmpty ? null : type));
            },
            child: Text(l10n.dialogAdd),
          ),
        ],
      ),
    );

    if (result != null) setState(() => _elements.add(result));
  }

  Future<ImageSource?> _pickSource() {
    final l10n = AppLocalizations.of(context);
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: context.colors.surfaceCard,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Symbols.photo_camera),
              title: Text(l10n.createSpotUseCamera),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Symbols.photo_library),
              title: Text(l10n.createSpotUseGallery),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickPhoto() async {
    final source = await _pickSource();
    if (source == null) return;
    final file = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (file != null) setState(() => _photoFiles.add(file));
  }

  void _removePhoto(int index) {
    setState(() {
      _photoFiles.removeAt(index);
      if (_coverIndex >= _photoFiles.length) {
        _coverIndex = _photoFiles.isEmpty ? 0 : _photoFiles.length - 1;
      } else if (_coverIndex > index) {
        _coverIndex--;
      }
    });
  }

  Future<void> _pickVideo() async {
    final source = await _pickSource();
    if (source == null) return;
    final file = await ImagePicker().pickVideo(
      source: source,
      maxDuration: const Duration(minutes: 2),
    );
    if (file == null) return;

    final probe = VideoPlayerController.file(File(file.path));
    try {
      await probe.initialize();
      if (probe.value.duration > _maxVideoDuration) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context).createSpotVideoTooLong,
              ),
            ),
          );
        }
        return;
      }
    } finally {
      await probe.dispose();
    }

    if (mounted) setState(() => _videoFile = file);
  }

  bool get _isValid =>
      _nameController.text.trim().isNotEmpty && _photoFiles.isNotEmpty;

  Future<void> _submit() async {
    setState(() => _showErrors = true);
    if (!_isValid || _submitting) return;

    setState(() => _submitting = true);
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      final riderId = ref.read(currentRiderProvider).value?.id;
      if (idToken == null || riderId == null) return;

      final ride = await ref
          .read(rideApiProvider)
          .create(
            name: _nameController.text.trim(),
            stateId: _stateId,
            condition: _condition,
            idToken: idToken,
          );

      for (final element in _elements) {
        await ref
            .read(rideApiProvider)
            .addElement(
              rideId: ride.id,
              name: element.name,
              type: element.type,
              idToken: idToken,
            );
      }

      // Path must match the published Storage rule `rides/{rideId}/{fileName}`
      // exactly (no `riders/{riderId}/` prefix, no photos/videos subfolder —
      // that rule has no room for extra path segments).
      int? coverPhotoId;
      for (var i = 0; i < _photoFiles.length; i++) {
        final photoFile = _photoFiles[i];
        final url = await ref
            .read(storageApiProvider)
            .uploadFile(
              path:
                  'rides/${ride.id}/'
                  '${DateTime.now().millisecondsSinceEpoch}_${photoFile.name}',
              file: File(photoFile.path),
            );
        final photo = await ref
            .read(riderPhotoApiProvider)
            .create(
              riderId: riderId,
              url: url,
              rideId: ride.id,
              idToken: idToken,
            );
        if (i == _coverIndex) coverPhotoId = photo.id;
      }
      if (coverPhotoId != null) {
        await ref
            .read(rideApiProvider)
            .setCoverPhoto(
              rideId: ride.id,
              coverPhotoId: coverPhotoId,
              idToken: idToken,
            );
      }
      if (_videoFile != null) {
        final url = await ref
            .read(storageApiProvider)
            .uploadFile(
              path:
                  'rides/${ride.id}/'
                  '${DateTime.now().millisecondsSinceEpoch}_${_videoFile!.name}',
              file: File(_videoFile!.path),
            );
        await ref
            .read(riderVideoApiProvider)
            .create(
              riderId: riderId,
              url: url,
              rideId: ride.id,
              idToken: idToken,
            );
      }

      ref.invalidate(ridesByOwnerProvider(riderId));
      if (mounted) context.pushReplacement('/rides/${ride.id}');
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
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
                    icon: Symbols.close,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    l10n.createRideTitle,
                    style: context.typography.displaySm,
                  ),
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
                  if (_showErrors && _nameController.text.trim().isEmpty)
                    _ErrorText(l10n.createRideNameRequired),

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

                  _SectionLabel(l10n.createRideElementsLabel, top: 18),
                  GestureDetector(
                    onTap: _addElement,
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
                  if (_elements.isNotEmpty) ...[
                    const SizedBox(height: 9),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final element in _elements)
                          Chip(
                            label: Text(
                              element.type != null
                                  ? '${element.name} · ${element.type}'
                                  : element.name,
                            ),
                            onDeleted: () =>
                                setState(() => _elements.remove(element)),
                          ),
                      ],
                    ),
                  ],

                  _SectionLabel(l10n.createRideConditionLabel, top: 18),
                  _Segmented(
                    options: const [1, 2, 3, 4, 5],
                    labelOf: (c) => '$c',
                    selected: _condition,
                    onSelect: (c) =>
                        setState(() => _condition = _condition == c ? null : c),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.createRideConditionWorst,
                        style: context.typography.micro,
                      ),
                      Text(
                        l10n.createRideConditionBest,
                        style: context.typography.micro,
                      ),
                    ],
                  ),

                  _SectionLabel(l10n.createSpotMediaLabel, top: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _MediaButton(
                          icon: Symbols.add_photo_alternate,
                          color: colors.colorBrand,
                          label: l10n.createSpotUploadPhoto,
                          onTap: _pickPhoto,
                          done: _photoFiles.isNotEmpty,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _MediaButton(
                          icon: Symbols.videocam,
                          color: colors.colorRating,
                          label: l10n.createSpotUploadVideo,
                          onTap: _pickVideo,
                          done: _videoFile != null,
                        ),
                      ),
                    ],
                  ),
                  if (_showErrors && _photoFiles.isEmpty)
                    _ErrorText(l10n.createRidePhotoRequired),
                  if (_photoFiles.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      l10n.createRideCoverHint,
                      style: context.typography.micro,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 84,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _photoFiles.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (context, index) => _PhotoThumb(
                          file: _photoFiles[index],
                          isCover: index == _coverIndex,
                          onTap: () => setState(() => _coverIndex = index),
                          onRemove: () => _removePhoto(index),
                        ),
                      ),
                    ),
                  ],
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
                label: _submitting ? '…' : l10n.createRidePublish,
                onPressed: _submitting ? null : _submit,
              ),
            ),
          ],
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

class _ErrorText extends StatelessWidget {
  const _ErrorText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: context.typography.micro.copyWith(
          color: context.colors.colorDanger,
        ),
      ),
    );
  }
}

/// Single-select segmented row, tap again to clear — used for condition
/// (1-5).
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

class _PhotoThumb extends StatelessWidget {
  const _PhotoThumb({
    required this.file,
    required this.isCover,
    required this.onTap,
    required this.onRemove,
  });

  final XFile file;
  final bool isCover;
  final VoidCallback onTap;
  final VoidCallback onRemove;

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
              child: Image.file(File(file.path), fit: BoxFit.cover),
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
            Positioned(
              right: 3,
              top: 3,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Symbols.close,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaButton extends StatelessWidget {
  const _MediaButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
    this.done = false,
  });

  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        decoration: BoxDecoration(
          color: colors.surfaceCard,
          border: Border.all(
            color: done ? colors.colorRating : colors.hairlineStrong,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(done ? Symbols.check_circle : icon, size: 26, color: color),
            const SizedBox(height: 7),
            Text(
              label,
              textAlign: TextAlign.center,
              style: context.typography.title.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
