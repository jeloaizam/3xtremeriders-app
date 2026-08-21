import 'dart:async';

import 'package:flutter/foundation.dart' show Factory;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' hide Position;
import 'package:go_router/go_router.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/map/mapbox_geocoding_api.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/domain/role.dart';
import '../../application/spot_detail.dart';
import '../../application/spots_providers.dart';
import '../../data/hazzard_api.dart';
import '../../data/spot_api.dart';
import '../../domain/hazzard.dart';
import '../../domain/spot_category.dart';
import '../../domain/spot_element.dart';
import '../../domain/sport.dart';
import '../spot_category_visuals.dart';
import '../sport_visuals.dart';

const _seasonOptions = [
  'Todo el año',
  'Temporada seca',
  'Temporada de lluvias',
];

const _difficultyLabels = {
  1: '1 · Principiante',
  2: '2 · Básico',
  3: '3 · Intermedio',
  4: '4 · Avanzado',
  5: '5 · Experto',
};

// Same fixed vocabulary as `CreateSpotScreen`'s element chips — an element
// here is just a type from this list, so toggling one on/off maps directly
// to creating/deleting a `SpotElement` with that type.
const _elementTypeOptions = ['bowl', 'ramps', 'rail', 'stairs', 'jump'];

const _previewZoom = 15.0;

/// Edits an existing [Spot] — full parity with `CreateSpotScreen`'s own
/// fields (name, description, location, sports, elements, hazards,
/// difficulty, season, category) plus lets an owner or admin delete the
/// spot outright. Sports/elements/hazards apply immediately (each is its
/// own backend call), everything else batches into one PATCH on Save —
/// same split `EditRideScreen` uses for its own elements list.
class EditSpotScreen extends ConsumerStatefulWidget {
  const EditSpotScreen({super.key, required this.spotId});

  final int spotId;

  @override
  ConsumerState<EditSpotScreen> createState() => _EditSpotScreenState();
}

class _EditSpotScreenState extends ConsumerState<EditSpotScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  int? _difficulty;
  String? _bestSeason;
  // Solo relevante si quien edita es admin — el backend lo ignora si no.
  int? _categoryId;
  double? _latitude;
  double? _longitude;
  // The raw fix used only to key the preview `MapWidget` — kept separate
  // from `_latitude`/`_longitude` so those can update on every pan frame
  // without tearing down and recreating the whole native map mid-drag.
  double? _anchorLatitude;
  double? _anchorLongitude;
  bool _fetchingLocation = false;
  // Only set once the rider actually touches location this session (GPS or
  // pin drag) — see CreateSpotScreen's identical fields. Deliberately NOT
  // seeded from the existing spot: SpotApi.update omits these keys when
  // null, so staying null means "location untouched" and the backend
  // leaves the spot's existing city/country alone instead of wiping them.
  String? _cityName;
  String? _countryName;
  String? _countryIsoCode;
  Timer? _geocodeDebounce;
  bool _seeded = false;
  bool _saving = false;
  bool _deleting = false;
  bool _addingHazard = false;
  final Set<int> _pendingSportIds = {};
  final Set<String> _pendingElementTypes = {};
  final Set<int> _pendingHazardIds = {};

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _geocodeDebounce?.cancel();
    super.dispose();
  }

  /// See CreateSpotScreen's identical pair — resolves _cityName/
  /// _countryIsoCode from the current _latitude/_longitude, debounced while
  /// dragging the pin so a fast drag doesn't fire one request per frame.
  Future<void> _reverseGeocode() async {
    final lat = _latitude;
    final lng = _longitude;
    if (lat == null || lng == null) return;
    final place = await ref.read(mapboxGeocodingApiProvider).reverse(lat, lng);
    if (!mounted || place == null) return;
    if (_latitude != lat || _longitude != lng) return;
    setState(() {
      _cityName = place.cityName;
      _countryName = place.countryName;
      _countryIsoCode = place.countryIsoCode;
    });
  }

  void _scheduleReverseGeocode() {
    _geocodeDebounce?.cancel();
    _geocodeDebounce = Timer(
      const Duration(milliseconds: 800),
      _reverseGeocode,
    );
  }

  void _seed(SpotDetailData detail) {
    if (_seeded) return;
    _nameController.text = detail.spot.name;
    _descriptionController.text = detail.spot.description;
    _difficulty = detail.spot.difficulty;
    _bestSeason = detail.spot.bestSeason;
    _categoryId = detail.spot.categoryId;
    _latitude = detail.spot.latitude;
    _longitude = detail.spot.longitude;
    _anchorLatitude = detail.spot.latitude;
    _anchorLongitude = detail.spot.longitude;
    _seeded = true;
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
      unawaited(_reverseGeocode());
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

  void _onPreviewCameraChanged(CameraChangedEventData data) {
    final center = data.cameraState.center.coordinates;
    setState(() {
      _latitude = center.lat.toDouble();
      _longitude = center.lng.toDouble();
    });
    _scheduleReverseGeocode();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      // See CreateSpotScreen._submit — resolve any pending debounced
      // geocode right now instead of risking a stale result if the rider
      // stopped dragging and hit Save within the debounce window.
      _geocodeDebounce?.cancel();
      await _reverseGeocode();

      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(spotApiProvider)
          .update(
            spotId: widget.spotId,
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            latitude: _latitude,
            longitude: _longitude,
            difficulty: _difficulty,
            bestSeason: _bestSeason,
            categoryId: _categoryId,
            cityName: _cityName,
            countryIsoCode: _countryIsoCode,
            idToken: idToken,
          );

      ref.invalidate(spotDetailProvider(widget.spotId));
      ref.invalidate(nearbySpotsProvider);
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
          l10n.spotDeleteConfirmTitle,
          style: context.typography.title,
        ),
        content: Text(l10n.spotDeleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.dialogCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.spotDelete,
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
          .read(spotApiProvider)
          .delete(spotId: widget.spotId, idToken: idToken);

      ref.invalidate(nearbySpotsProvider);
      if (mounted) {
        // Pop back past the now-deleted spot's own SpotScreen (not
        // `context.go('/home')`, which would replace the whole navigation
        // stack and strand it out of the back history).
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

  Future<void> _toggleSport(int sportId, bool currentlySelected) async {
    if (_pendingSportIds.contains(sportId)) return;
    setState(() => _pendingSportIds.add(sportId));
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      if (currentlySelected) {
        // The backend rejects removing a spot's last remaining sport
        // (409) — surfaced via the catch below rather than pre-checked
        // here, same as the "El spot debe tener al menos un deporte" rule.
        await ref
            .read(spotApiProvider)
            .removeSport(
              spotId: widget.spotId,
              sportId: sportId,
              idToken: idToken,
            );
      } else {
        await ref
            .read(spotApiProvider)
            .addSport(
              spotId: widget.spotId,
              sportId: sportId,
              idToken: idToken,
            );
      }
      // spotDetailProvider reads spotSportsProvider via `ref.read` — that
      // keepAlive sub-provider has its own cache that invalidating
      // spotDetailProvider alone doesn't touch, so without this the chip
      // above keeps showing the pre-toggle state (stale "selected") even
      // though the backend already applied the change, and tapping it
      // again re-sends the same add/remove against a state that no longer
      // exists (a 409/404 that looks like a bug but is really just stale
      // data driving the UI).
      ref.invalidate(spotSportsProvider(widget.spotId));
      ref.invalidate(spotDetailProvider(widget.spotId));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _pendingSportIds.remove(sportId));
    }
  }

  Future<void> _toggleElement(String type, SpotElement? existing) async {
    if (_pendingElementTypes.contains(type)) return;
    setState(() => _pendingElementTypes.add(type));
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      if (existing != null) {
        await ref
            .read(spotApiProvider)
            .deleteElement(
              spotId: widget.spotId,
              elementId: existing.id,
              idToken: idToken,
            );
      } else {
        await ref
            .read(spotApiProvider)
            .addElement(
              spotId: widget.spotId,
              name: type,
              type: type,
              idToken: idToken,
            );
      }
      // See the matching comment in _toggleSport — spotElementsProvider is
      // its own keepAlive cache, invalidating spotDetailProvider alone
      // doesn't refresh it.
      ref.invalidate(spotElementsProvider(widget.spotId));
      ref.invalidate(spotDetailProvider(widget.spotId));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _pendingElementTypes.remove(type));
    }
  }

  Future<({String name, int severity})?> _showHazardDialog({
    String? existingName,
    int existingSeverity = 3,
  }) {
    final l10n = AppLocalizations.of(context);
    final nameController = TextEditingController(text: existingName ?? '');
    var severity = existingSeverity;

    return showDialog<({String name, int severity})>(
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
                Navigator.of(
                  dialogContext,
                ).pop((name: name, severity: severity));
              },
              child: Text(
                existingName == null ? l10n.dialogAdd : l10n.settingsSave,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addHazard() async {
    final result = await _showHazardDialog();
    if (result == null) return;

    setState(() => _addingHazard = true);
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(hazzardApiProvider)
          .create(
            spotId: widget.spotId,
            name: result.name,
            severity: result.severity,
            idToken: idToken,
          );
      // Same stale-cache issue as _toggleSport/_toggleElement.
      ref.invalidate(spotHazzardsProvider(widget.spotId));
      ref.invalidate(spotDetailProvider(widget.spotId));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _addingHazard = false);
    }
  }

  Future<void> _editHazard(Hazzard hazard) async {
    if (_pendingHazardIds.contains(hazard.id)) return;
    final result = await _showHazardDialog(
      existingName: hazard.name,
      existingSeverity: hazard.severity ?? 3,
    );
    if (result == null) return;

    setState(() => _pendingHazardIds.add(hazard.id));
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(hazzardApiProvider)
          .update(
            hazzardId: hazard.id,
            name: result.name,
            severity: result.severity,
            idToken: idToken,
          );
      // Same stale-cache issue as _toggleSport/_toggleElement.
      ref.invalidate(spotHazzardsProvider(widget.spotId));
      ref.invalidate(spotDetailProvider(widget.spotId));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _pendingHazardIds.remove(hazard.id));
    }
  }

  Future<void> _deleteHazard(Hazzard hazard) async {
    if (_pendingHazardIds.contains(hazard.id)) return;
    setState(() => _pendingHazardIds.add(hazard.id));
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(hazzardApiProvider)
          .delete(hazzardId: hazard.id, idToken: idToken);
      // Same stale-cache issue as _toggleSport/_toggleElement.
      ref.invalidate(spotHazzardsProvider(widget.spotId));
      ref.invalidate(spotDetailProvider(widget.spotId));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _pendingHazardIds.remove(hazard.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final detailAsync = ref.watch(spotDetailProvider(widget.spotId));
    final isAdmin =
        (ref.watch(currentRiderProvider).value?.roleId ?? 0) >= roleAdmin;
    final categories = isAdmin
        ? ref.watch(allSpotCategoriesProvider).value ?? const <SpotCategory>[]
        : const <SpotCategory>[];
    final allSports = ref.watch(allSportsProvider).value ?? const <Sport>[];

    return Scaffold(
      body: SafeArea(
        child: detailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (detail) {
            _seed(detail);
            final selectedSportIds = {for (final s in detail.sports) s.id};
            final elementByType = {
              for (final e in detail.elements)
                if (e.type != null) e.type!: e,
            };

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
                      Text(l10n.spotEdit, style: context.typography.displaySm),
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

                      _SectionLabel(l10n.createSpotDescriptionLabel, top: 18),
                      AppTextField(
                        controller: _descriptionController,
                        placeholder: l10n.createSpotDescriptionPlaceholder,
                        multiline: true,
                      ),

                      _SectionLabel(l10n.createSpotSportLabel, top: 18),
                      Wrap(
                        spacing: 9,
                        runSpacing: 9,
                        children: [
                          for (final sport in allSports)
                            Opacity(
                              opacity: _pendingSportIds.contains(sport.id)
                                  ? .5
                                  : 1,
                              child: _ToggleChip(
                                label: sport.name,
                                icon: SportVisual.of(sport.name, colors).icon,
                                selected: selectedSportIds.contains(sport.id),
                                onTap: () => _toggleSport(
                                  sport.id,
                                  selectedSportIds.contains(sport.id),
                                ),
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
                                      : l10n.createSpotLocationSet,
                                  style: context.typography.body,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                  // Keyed on the anchor, not on
                                  // `_latitude`/`_longitude` — those change
                                  // continuously while dragging, and
                                  // rebuilding the MapWidget mid-drag would
                                  // reset the camera and interrupt the
                                  // gesture.
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
                                  onCameraChangeListener:
                                      _onPreviewCameraChanged,
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
                        if ((_cityName ?? detail.spot.cityName) != null &&
                            (_countryName ?? detail.spot.countryName) !=
                                null) ...[
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Symbols.public,
                                size: 14,
                                color: colors.textMuted,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${_cityName ?? detail.spot.cityName}, '
                                '${_countryName ?? detail.spot.countryName}',
                                style: context.typography.meta.copyWith(
                                  color: colors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _SectionLabel(
                                  l10n.createSpotDifficultyLabel,
                                  top: 18,
                                ),
                                AppDropdown<int>(
                                  value: _difficulty,
                                  placeholder: '—',
                                  items: [
                                    for (final entry
                                        in _difficultyLabels.entries)
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
                                _SectionLabel(
                                  l10n.createSpotSeasonLabel,
                                  top: 18,
                                ),
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
                          placeholder: '—',
                          items: [
                            for (final category in categories)
                              DropdownMenuItem(
                                value: category.id,
                                child: Text(
                                  spotCategoryLabel(l10n, category.name),
                                ),
                              ),
                          ],
                          onChanged: (value) =>
                              setState(() => _categoryId = value),
                        ),
                      ],

                      _SectionLabel(l10n.createSpotElementsLabel, top: 18),
                      Wrap(
                        spacing: 9,
                        runSpacing: 9,
                        children: [
                          for (final type in _elementTypeOptions)
                            Opacity(
                              opacity: _pendingElementTypes.contains(type)
                                  ? .5
                                  : 1,
                              child: _ToggleChip(
                                label: type,
                                icon: elementIcon(type),
                                selected: elementByType.containsKey(type),
                                onTap: () =>
                                    _toggleElement(type, elementByType[type]),
                              ),
                            ),
                        ],
                      ),

                      _SectionLabel(l10n.createSpotHazardsLabel, top: 18),
                      GestureDetector(
                        onTap: _addingHazard ? null : _addHazard,
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
                      if (detail.hazzards.isNotEmpty) ...[
                        const SizedBox(height: 9),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final hazard in detail.hazzards)
                              Opacity(
                                opacity: _pendingHazardIds.contains(hazard.id)
                                    ? .5
                                    : 1,
                                child: GestureDetector(
                                  onTap: _pendingHazardIds.contains(hazard.id)
                                      ? null
                                      : () => _editHazard(hazard),
                                  child: Chip(
                                    label: Text(
                                      '${hazard.name} · ${hazard.severity ?? "—"}',
                                    ),
                                    onDeleted:
                                        _pendingHazardIds.contains(hazard.id)
                                        ? null
                                        : () => _deleteHazard(hazard),
                                  ),
                                ),
                              ),
                          ],
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
                              color: context.colors.colorDanger,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.spotDelete,
                              style: context.typography.title.copyWith(
                                color: context.colors.colorDanger,
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
                    color: context.colors.surfaceApp,
                    border: Border(
                      top: BorderSide(color: context.colors.hairlineSoft),
                    ),
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
