import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' hide Position;
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide ImageSource;
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
import '../../application/spots_providers.dart';
import '../../data/hazzard_api.dart';
import '../../data/spot_api.dart';
import '../../data/spot_photo_api.dart';
import '../../data/spot_video_api.dart';
import '../../domain/sport.dart';
import '../sport_visuals.dart';

class _ElementOption {
  const _ElementOption(this.type);
  final String type;
}

const _elementOptions = [
  _ElementOption('bowl'),
  _ElementOption('ramps'),
  _ElementOption('rail'),
  _ElementOption('stairs'),
  _ElementOption('jump'),
];

const _seasonOptions = [
  'Todo el año',
  'Temporada seca',
  'Temporada de lluvias',
];

// Normal riders are capped at 1:30 (90s) for spot videos. Longer clips (up
// to 3min) are planned for a future pro/events tier — not gated on any role
// yet, so not implemented here.
const _maxVideoDuration = Duration(seconds: 90);

const _difficultyLabels = {
  1: '1 · Principiante',
  2: '2 · Básico',
  3: '3 · Intermedio',
  4: '4 · Avanzado',
  5: '5 · Experto',
};

class _PendingHazard {
  const _PendingHazard(this.name, this.severity);
  final String name;
  final int severity;
}

/// Mirrors the "CREAR SPOT" (`isCreate`) state of
/// `Deportes Extremos App v2.dc.html` — publishes a real `Spot` via
/// `POST /spots/`, then attaches any selected elements/hazards/video link.
class CreateSpotScreen extends ConsumerStatefulWidget {
  const CreateSpotScreen({super.key});

  @override
  ConsumerState<CreateSpotScreen> createState() => _CreateSpotScreenState();
}

class _CreateSpotScreenState extends ConsumerState<CreateSpotScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final Set<int> _sportIds = {};
  final Set<String> _elementTypes = {};
  final List<_PendingHazard> _hazards = [];
  String? _videoUrl;
  XFile? _photoFile;
  XFile? _videoFile;
  int? _difficulty;
  String? _bestSeason;
  double? _latitude;
  double? _longitude;
  bool _fetchingLocation = false;
  bool _submitting = false;
  bool _showErrors = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _useCurrentLocation() async {
    setState(() => _fetchingLocation = true);
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context).createSpotLocationDenied,
              ),
            ),
          );
        }
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    } finally {
      if (mounted) setState(() => _fetchingLocation = false);
    }
  }

  Future<void> _addHazard() async {
    final l10n = AppLocalizations.of(context);
    final nameController = TextEditingController();
    var severity = 3;

    final result = await showDialog<_PendingHazard>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          backgroundColor: context.colors.surfaceCard,
          title: Text(
            l10n.createSpotAddHazard,
            style: context.typography.title,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: nameController,
                placeholder: l10n.createSpotHazardNamePlaceholder,
              ),
              const SizedBox(height: 14),
              Text(
                l10n.createSpotHazardSeverityLabel,
                style: context.typography.meta,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 1; i <= 5; i++)
                    GestureDetector(
                      onTap: () => setDialogState(() => severity = i),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: severity == i
                            ? context.colors.colorAction
                            : context.colors.surfaceMedia,
                        child: Text(
                          '$i',
                          style: TextStyle(
                            color: severity == i
                                ? context.colors.colorOnAction
                                : context.colors.text300,
                          ),
                        ),
                      ),
                    ),
                ],
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
                Navigator.of(dialogContext).pop(_PendingHazard(name, severity));
              },
              child: Text(l10n.dialogAdd),
            ),
          ],
        ),
      ),
    );

    if (result != null) setState(() => _hazards.add(result));
  }

  Future<void> _linkVideo() async {
    final l10n = AppLocalizations.of(context);
    final urlController = TextEditingController(text: _videoUrl ?? '');

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: context.colors.surfaceCard,
        title: Text(l10n.createSpotLinkVideo, style: context.typography.title),
        content: AppTextField(
          controller: urlController,
          placeholder: l10n.createSpotVideoUrlPlaceholder,
          keyboardType: TextInputType.url,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.dialogCancel),
          ),
          TextButton(
            onPressed: () {
              final url = urlController.text.trim();
              if (url.isEmpty) return;
              Navigator.of(dialogContext).pop(url);
            },
            child: Text(l10n.dialogAdd),
          ),
        ],
      ),
    );

    if (result != null) setState(() => _videoUrl = result);
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
    if (file != null) setState(() => _photoFile = file);
  }

  Future<void> _pickVideo() async {
    final source = await _pickSource();
    if (source == null) return;
    final file = await ImagePicker().pickVideo(
      source: source,
      maxDuration: const Duration(minutes: 2),
    );
    if (file == null) return;

    // `maxDuration` above only constrains camera-recorded clips — a
    // gallery-picked video can be any length, so it's checked here too.
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
      _nameController.text.trim().isNotEmpty &&
      _descriptionController.text.trim().isNotEmpty &&
      _latitude != null &&
      _longitude != null;

  Future<void> _submit() async {
    setState(() => _showErrors = true);
    if (!_isValid || _submitting) return;

    setState(() => _submitting = true);
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) return;

      final spot = await ref
          .read(spotApiProvider)
          .create(
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            latitude: _latitude!,
            longitude: _longitude!,
            difficulty: _difficulty,
            bestSeason: _bestSeason,
            sportIds: _sportIds.toList(),
            idToken: idToken,
          );

      for (final type in _elementTypes) {
        await ref
            .read(spotApiProvider)
            .addElement(
              spotId: spot.id,
              name: type,
              type: type,
              idToken: idToken,
            );
      }
      for (final hazard in _hazards) {
        await ref
            .read(hazzardApiProvider)
            .create(
              spotId: spot.id,
              name: hazard.name,
              severity: hazard.severity,
              idToken: idToken,
            );
      }
      if (_videoUrl != null) {
        await ref
            .read(spotVideoApiProvider)
            .create(spotId: spot.id, url: _videoUrl!, idToken: idToken);
      }
      if (_photoFile != null) {
        final url = await ref
            .read(storageApiProvider)
            .uploadFile(
              path:
                  'spots/${spot.id}/photos/'
                  '${DateTime.now().millisecondsSinceEpoch}_${_photoFile!.name}',
              file: File(_photoFile!.path),
            );
        await ref
            .read(spotPhotoApiProvider)
            .create(spotId: spot.id, url: url, idToken: idToken);
      }
      if (_videoFile != null) {
        final url = await ref
            .read(storageApiProvider)
            .uploadFile(
              path:
                  'spots/${spot.id}/videos/'
                  '${DateTime.now().millisecondsSinceEpoch}_${_videoFile!.name}',
              file: File(_videoFile!.path),
            );
        await ref
            .read(spotVideoApiProvider)
            .create(spotId: spot.id, url: url, idToken: idToken);
      }

      ref.invalidate(nearbySpotsProvider);
      if (mounted) context.pushReplacement('/spot/${spot.id}');
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
    final allSports = ref.watch(allSportsProvider).value ?? const <Sport>[];

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
                    l10n.createSpotTitle,
                    style: context.typography.displaySm,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 20),
                children: [
                  _SectionLabel(l10n.createSpotNameLabel),
                  AppTextField(
                    controller: _nameController,
                    placeholder: l10n.createSpotNamePlaceholder,
                  ),
                  if (_showErrors && _nameController.text.trim().isEmpty)
                    _ErrorText(l10n.createSpotNameRequired),

                  _SectionLabel(l10n.createSpotSportLabel, top: 18),
                  Wrap(
                    spacing: 9,
                    runSpacing: 9,
                    children: [
                      for (final sport in allSports)
                        _ToggleChip(
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

                  _SectionLabel(l10n.createSpotLocationLabel, top: 18),
                  GestureDetector(
                    onTap: _fetchingLocation ? null : _useCurrentLocation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 16,
                      ),
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
                            Symbols.location_on,
                            color: _latitude != null
                                ? colors.colorRating
                                : colors.colorAction,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _fetchingLocation
                                  ? '…'
                                  : _latitude != null
                                  ? l10n.createSpotLocationSet
                                  : l10n.createSpotUseCurrentLocation,
                              style: context.typography.body,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_showErrors && _latitude == null)
                    _ErrorText(l10n.createSpotLocationDenied),
                  if (_latitude != null && _longitude != null) ...[
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: SizedBox(
                        height: 300,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            MapWidget(
                              // Forces a fresh MapWidget (and camera) each
                              // time the fetched coordinates change — this
                              // preview has no interactive controller to
                              // just re-center an existing map instance.
                              key: ValueKey('$_latitude,$_longitude'),
                              styleUri: MapboxStyles.DARK,
                              onMapCreated: (map) => map.setCamera(
                                CameraOptions(
                                  center: Point(
                                    coordinates: Position(
                                      _longitude!,
                                      _latitude!,
                                    ),
                                  ),
                                  zoom: 15,
                                ),
                              ),
                            ),
                            IgnorePointer(
                              child: Center(
                                child: Icon(
                                  Symbols.place,
                                  fill: 1,
                                  size: 34,
                                  color: colors.colorAction,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  _SectionLabel(null, top: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionLabel(
                              l10n.createSpotDifficultyLabel,
                              top: 0,
                            ),
                            AppDropdown<int>(
                              value: _difficulty,
                              placeholder: '—',
                              items: [
                                for (final entry in _difficultyLabels.entries)
                                  DropdownMenuItem(
                                    value: entry.key,
                                    child: Text(entry.value),
                                  ),
                              ],
                              onChanged: (value) =>
                                  setState(() => _difficulty = value),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionLabel(l10n.createSpotSeasonLabel, top: 0),
                            AppDropdown<String>(
                              value: _bestSeason,
                              placeholder: '—',
                              items: [
                                for (final season in _seasonOptions)
                                  DropdownMenuItem(
                                    value: season,
                                    child: Text(season),
                                  ),
                              ],
                              onChanged: (value) =>
                                  setState(() => _bestSeason = value),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  _SectionLabel(l10n.createSpotElementsLabel, top: 18),
                  Wrap(
                    spacing: 9,
                    runSpacing: 9,
                    children: [
                      for (final option in _elementOptions)
                        _ToggleChip(
                          label: option.type,
                          icon: elementIcon(option.type),
                          selected: _elementTypes.contains(option.type),
                          onTap: () => setState(
                            () => _elementTypes.contains(option.type)
                                ? _elementTypes.remove(option.type)
                                : _elementTypes.add(option.type),
                          ),
                        ),
                    ],
                  ),

                  _SectionLabel(l10n.createSpotHazardsLabel, top: 18),
                  GestureDetector(
                    onTap: _addHazard,
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: colors.surfaceCard,
                        border: Border.all(
                          color: colors.colorDanger.withValues(alpha: .35),
                        ),
                        borderRadius: BorderRadius.circular(
                          context.spacing.radiusMd,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Symbols.add_alert,
                            color: colors.colorDanger,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l10n.createSpotAddHazard,
                              style: context.typography.bodySm,
                            ),
                          ),
                          Text(
                            '1–5',
                            style: context.typography.tag.copyWith(
                              color: colors.colorDanger,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_hazards.isNotEmpty) ...[
                    const SizedBox(height: 9),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final hazard in _hazards)
                          Chip(
                            label: Text('${hazard.name} · ${hazard.severity}'),
                            onDeleted: () =>
                                setState(() => _hazards.remove(hazard)),
                          ),
                      ],
                    ),
                  ],

                  _SectionLabel(l10n.createSpotDescriptionLabel, top: 18),
                  AppTextField(
                    controller: _descriptionController,
                    placeholder: l10n.createSpotDescriptionPlaceholder,
                    multiline: true,
                  ),
                  if (_showErrors && _descriptionController.text.trim().isEmpty)
                    _ErrorText(l10n.createSpotDescriptionRequired),

                  _SectionLabel(l10n.createSpotMediaLabel, top: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _MediaButton(
                          icon: Symbols.add_photo_alternate,
                          color: colors.colorBrand,
                          label: l10n.createSpotUploadPhoto,
                          onTap: _pickPhoto,
                          done: _photoFile != null,
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
                      const SizedBox(width: 10),
                      Expanded(
                        child: _MediaButton(
                          icon: Symbols.link,
                          color: colors.blue500,
                          label: l10n.createSpotLinkVideo,
                          onTap: _linkVideo,
                          done: _videoUrl != null,
                        ),
                      ),
                    ],
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
                label: _submitting ? '…' : l10n.createSpotPublish,
                onPressed: _submitting ? null : _submit,
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

  final String? label;
  final double top;

  @override
  Widget build(BuildContext context) {
    if (label == null) return SizedBox(height: top);
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: 8),
      child: Text(
        label!,
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

class _ToggleChip extends StatelessWidget {
  const _ToggleChip({
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
