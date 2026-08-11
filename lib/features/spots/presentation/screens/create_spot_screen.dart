import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show Factory;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' hide Position;
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide ImageSource;
import 'package:material_symbols_icons/symbols.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/storage/media_size_guard.dart';
import '../../../../core/storage/storage_api.dart';
import '../../../../core/storage/video_thumbnail_helper.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/domain/role.dart';
import '../../application/spots_providers.dart';
import '../../data/hazzard_api.dart';
import '../../data/spot_api.dart';
import '../../data/spot_photo_api.dart';
import '../../data/spot_video_api.dart';
import '../../domain/spot_category.dart';
import '../../domain/sport.dart';
import '../spot_category_visuals.dart';
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

const _previewZoom = 15.0;

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
  // Solo relevante si quien crea es admin — para un rider normal el
  // backend lo fuerza a 'xtremespot' sin importar lo que se mande.
  int? _categoryId;
  double? _latitude;
  double? _longitude;
  // The raw GPS fix, used only to key the preview `MapWidget` (see below) —
  // kept separate from `_latitude`/`_longitude` so those can be updated on
  // every pan frame without forcing Flutter to tear down and recreate the
  // whole native map mid-drag.
  double? _anchorLatitude;
  double? _anchorLongitude;
  bool _fetchingLocation = false;
  bool _submitting = false;
  bool _showErrors = false;
  bool _seededActiveSport = false;

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
        _anchorLatitude = position.latitude;
        _anchorLongitude = position.longitude;
      });
    } finally {
      if (mounted) setState(() => _fetchingLocation = false);
    }
  }

  Future<void> _onPreviewMapCreated(MapboxMap map) async {
    // Only panning is allowed — zoom/rotate/pitch stay locked so the
    // preview stays a simple "drag to nudge the pin" control.
    await map.gestures.updateSettings(
      GesturesSettings(
        scrollEnabled: true,
        pinchToZoomEnabled: false,
        doubleTapToZoomInEnabled: false,
        quickZoomEnabled: false,
        rotateEnabled: false,
        pitchEnabled: false,
      ),
    );
  }

  /// Fires continuously while the preview map is panned — keeps
  /// `_latitude`/`_longitude` in sync with wherever the fixed, center-screen
  /// pin actually points at, so a rider can correct GPS drift by hand.
  void _onPreviewCameraChanged(CameraChangedEventData data) {
    final center = data.cameraState.center.coordinates;
    setState(() {
      _latitude = center.lat.toDouble();
      _longitude = center.lng.toDouble();
    });
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

    // Caught here (before upload) instead of letting Firebase Storage's
    // security rule reject the write — that failure surfaces as a
    // confusing `storage/unauthorized`, not anything mentioning size.
    if (await exceedsSpotMediaSizeLimit(file.path)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).spotVideoTooLarge),
          ),
        );
      }
      return;
    }

    if (mounted) setState(() => _videoFile = file);
  }

  bool get _isValid =>
      _nameController.text.trim().isNotEmpty &&
      _descriptionController.text.trim().isNotEmpty &&
      _sportIds.isNotEmpty &&
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
            categoryId: _categoryId,
            sportIds: _sportIds.toList(),
            idToken: idToken,
          );

      // From here on the spot itself already exists on the backend — if
      // anything below fails (most likely a media upload), the rider still
      // needs to land on their new spot instead of seeing a bare error and
      // assuming nothing was created, so this is a separate try/catch that
      // just warns instead of blocking navigation.
      try {
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
        // The spot's first selected sport tags whichever media gets
        // uploaded right here — harmless when there's only one (the
        // backend resolves it automatically either way), and a valid
        // member of the spot's own sports when there are several, so it
        // always passes validation. A rider can re-tag or add more
        // sport-specific media afterward via the "+" button on the spot's
        // own media gallery.
        final firstSportId = _sportIds.first;
        if (_videoUrl != null) {
          await ref
              .read(spotVideoApiProvider)
              .create(
                spotId: spot.id,
                url: _videoUrl!,
                sportId: firstSportId,
                idToken: idToken,
              );
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
              .create(
                spotId: spot.id,
                url: url,
                sportId: firstSportId,
                idToken: idToken,
              );
        }
        if (_videoFile != null) {
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final url = await ref
              .read(storageApiProvider)
              .uploadFile(
                path:
                    'spots/${spot.id}/videos/${timestamp}_${_videoFile!.name}',
                file: File(_videoFile!.path),
              );
          final thumbnailPath = await generateVideoThumbnail(_videoFile!.path);
          final thumbnailUrl = thumbnailPath == null
              ? null
              : await ref
                    .read(storageApiProvider)
                    .uploadFile(
                      path: 'spots/${spot.id}/videos/${timestamp}_thumb.jpg',
                      file: File(thumbnailPath),
                    );
          await ref
              .read(spotVideoApiProvider)
              .create(
                spotId: spot.id,
                url: url,
                sportId: firstSportId,
                thumbnailUrl: thumbnailUrl,
                idToken: idToken,
              );
        }
      } catch (error, stackTrace) {
        // The spot itself already saved fine at this point — this only
        // covers elements/hazards/media, which the rider might not notice
        // failed if they miss the SnackBar. Recorded as non-fatal so a
        // failed upload in the field (bad connection, Storage rejection,
        // etc.) leaves a trace we can actually look at afterward.
        unawaited(
          FirebaseCrashlytics.instance.recordError(
            error,
            stackTrace,
            reason:
                'create_spot_screen: element/hazard/media upload failed '
                'after spot ${spot.id} was created',
            fatal: false,
          ),
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context).createSpotPartialFailure('$error'),
              ),
            ),
          );
        }
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
    final isAdmin =
        (ref.watch(currentRiderProvider).value?.roleId ?? 0) >= roleAdmin;
    final categories = isAdmin
        ? ref.watch(allSpotCategoriesProvider).value ?? const <SpotCategory>[]
        : const <SpotCategory>[];

    // Preselects the rider's active sport once (they're still free to
    // deselect it — this only ever adds it the first time it resolves).
    if (!_seededActiveSport) {
      final activeSportId = ref.watch(effectiveActiveSportIdProvider).value;
      if (activeSportId != null) {
        _seededActiveSport = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _sportIds.add(activeSportId));
        });
      }
    }

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
                  if (_showErrors && _sportIds.isEmpty)
                    _ErrorText(l10n.createSpotSportRequired),

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
                              // Keyed on the *anchor* (the raw GPS fix), not
                              // on `_latitude`/`_longitude` — those now
                              // change continuously while the rider drags
                              // to adjust the pin, and rebuilding the whole
                              // MapWidget mid-drag would reset the camera
                              // and interrupt the gesture. A fresh instance
                              // is only needed when "usar ubicación actual"
                              // is tapped again for a brand new GPS fix.
                              key: ValueKey(
                                '$_anchorLatitude,$_anchorLongitude',
                              ),
                              styleUri: MapboxStyles.SATELLITE,
                              onMapCreated: (map) {
                                _onPreviewMapCreated(map);
                                map.setCamera(
                                  CameraOptions(
                                    center: Point(
                                      coordinates: Position(
                                        _longitude!,
                                        _latitude!,
                                      ),
                                    ),
                                    zoom: _previewZoom,
                                  ),
                                );
                              },
                              onCameraChangeListener: _onPreviewCameraChanged,
                              // This preview sits inside the form's
                              // scrolling `ListView` — without eagerly
                              // claiming the gesture, the ListView's own
                              // scroll recognizer wins the arena and the
                              // map never sees the drag at all.
                              gestureRecognizers: {
                                Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                                ),
                              },
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
                    const SizedBox(height: 6),
                    Text(
                      l10n.createSpotAdjustPinHint,
                      style: context.typography.micro.copyWith(
                        color: colors.textMuted,
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

                  if (isAdmin && categories.isNotEmpty) ...[
                    _SectionLabel(l10n.createSpotCategoryLabel, top: 18),
                    AppDropdown<int>(
                      value: _categoryId,
                      placeholder: spotCategoryLabel(l10n, 'xtremespot'),
                      items: [
                        for (final category in categories)
                          DropdownMenuItem(
                            value: category.id,
                            child: Text(spotCategoryLabel(l10n, category.name)),
                          ),
                      ],
                      onChanged: (value) => setState(() => _categoryId = value),
                    ),
                  ],

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
                          onRemove: () => setState(() => _photoFile = null),
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
                          onRemove: () => setState(() => _videoFile = null),
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
                          onRemove: () => setState(() => _videoUrl = null),
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
    this.onRemove,
  });

  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  final bool done;

  /// Shown as a small "x" badge in the corner once `done` — lets the rider
  /// deselect the photo/video/link they picked without having to replace
  /// it with another one just to change their mind.
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
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
                Icon(
                  done ? Symbols.check_circle : icon,
                  size: 26,
                  color: color,
                ),
                const SizedBox(height: 7),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: context.typography.title.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
        if (done && onRemove != null)
          Positioned(
            top: -6,
            right: -6,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.colorDanger,
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.bg850, width: 2),
                ),
                child: Icon(Symbols.close, size: 13, color: colors.bg850),
              ),
            ),
          ),
      ],
    );
  }
}
