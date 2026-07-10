import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' hide Position;
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide ImageSource;
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/storage/storage_api.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../spots/application/spots_providers.dart';
import '../../../spots/domain/sport.dart';
import '../../../spots/domain/spot.dart';
import '../../../spots/presentation/sport_visuals.dart';
import '../../application/events_providers.dart';
import '../../data/event_api.dart';

enum _LocationMode { existingSpot, ownPoint }

/// Publishes a new [Event] — only reachable by admins (the drawer/list
/// "CREAR" entry points are hidden for non-admins, and `POST /events/`
/// itself requires admin server-side either way).
class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final Set<int> _sportIds = {};

  DateTime? _startDate;
  DateTime? _endDate;

  _LocationMode _locationMode = _LocationMode.existingSpot;
  int? _selectedSpotId;
  double? _latitude;
  double? _longitude;
  bool _fetchingLocation = false;

  XFile? _coverImage;
  bool _submitting = false;
  bool _showErrors = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickStartDate() async {
    final picked = await _pickDateTime(_startDate ?? DateTime.now());
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _pickEndDate() async {
    final picked = await _pickDateTime(
      _endDate ?? _startDate ?? DateTime.now(),
    );
    if (picked != null) setState(() => _endDate = picked);
  }

  Future<DateTime?> _pickDateTime(DateTime initial) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 730)),
    );
    if (date == null || !mounted) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _pickSpot() async {
    final spots = ref.read(nearbySpotsProvider).value ?? const <Spot>[];
    final selected = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: context.colors.surfaceCard,
      builder: (sheetContext) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final spot in spots)
              ListTile(
                leading: const Icon(Symbols.place),
                title: Text(spot.name),
                subtitle: spot.neighborhood != null
                    ? Text(spot.neighborhood!)
                    : null,
                onTap: () => Navigator.of(sheetContext).pop(spot.id),
              ),
          ],
        ),
      ),
    );
    if (selected != null) setState(() => _selectedSpotId = selected);
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

  Future<void> _pickCoverImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (file != null) setState(() => _coverImage = file);
  }

  bool get _isValid =>
      _nameController.text.trim().isNotEmpty &&
      _descriptionController.text.trim().isNotEmpty &&
      _startDate != null &&
      (_locationMode == _LocationMode.existingSpot
          ? _selectedSpotId != null
          : _latitude != null && _longitude != null);

  Future<void> _submit() async {
    setState(() => _showErrors = true);
    if (!_isValid || _submitting) return;

    setState(() => _submitting = true);
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) return;

      var event = await ref
          .read(eventApiProvider)
          .create(
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            startDate: _startDate!,
            endDate: _endDate,
            spotId: _locationMode == _LocationMode.existingSpot
                ? _selectedSpotId
                : null,
            latitude: _locationMode == _LocationMode.ownPoint
                ? _latitude
                : null,
            longitude: _locationMode == _LocationMode.ownPoint
                ? _longitude
                : null,
            sportIds: _sportIds.toList(),
            idToken: idToken,
          );

      if (_coverImage != null) {
        final coverImageUrl = await ref
            .read(storageApiProvider)
            .uploadFile(
              path: 'events/${event.id}/${_coverImage!.name}',
              file: File(_coverImage!.path),
            );
        event = await ref
            .read(eventApiProvider)
            .updateCoverImage(
              eventId: event.id,
              coverImageUrl: coverImageUrl,
              idToken: idToken,
            );
      }

      ref.invalidate(eventsListProvider);
      if (mounted) context.pushReplacement('/events/${event.id}');
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
    final locale = Localizations.localeOf(context).toString();
    final spots = ref.watch(nearbySpotsProvider).value ?? const <Spot>[];
    final selectedSpot = _findSpot(spots, _selectedSpotId);

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
                    l10n.createEventTitle,
                    style: context.typography.displaySm,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 20),
                children: [
                  _SectionLabel(l10n.createEventNameLabel),
                  AppTextField(
                    controller: _nameController,
                    placeholder: l10n.createEventNamePlaceholder,
                  ),
                  if (_showErrors && _nameController.text.trim().isEmpty)
                    _ErrorText(l10n.createEventNameRequired),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionLabel(l10n.createEventStartLabel, top: 18),
                            _DateTile(
                              icon: Symbols.calendar_month,
                              label: _startDate != null
                                  ? DateFormat.MMMd(
                                      locale,
                                    ).add_Hm().format(_startDate!)
                                  : null,
                              onTap: _pickStartDate,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionLabel(l10n.createEventEndLabel, top: 18),
                            _DateTile(
                              icon: Symbols.calendar_month,
                              label: _endDate != null
                                  ? DateFormat.MMMd(
                                      locale,
                                    ).add_Hm().format(_endDate!)
                                  : null,
                              placeholder: l10n.createEventEndOptional,
                              onTap: _pickEndDate,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_showErrors && _startDate == null)
                    _ErrorText(l10n.createEventStartRequired),

                  _SectionLabel(l10n.createEventLocationLabel, top: 18),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: colors.surfaceCard,
                      border: Border.all(color: colors.hairlineStrong),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _LocationModeTab(
                            label: l10n.createEventLocationExistingSpot,
                            active: _locationMode == _LocationMode.existingSpot,
                            onTap: () => setState(
                              () => _locationMode = _LocationMode.existingSpot,
                            ),
                          ),
                        ),
                        Expanded(
                          child: _LocationModeTab(
                            label: l10n.createEventLocationOwnPoint,
                            active: _locationMode == _LocationMode.ownPoint,
                            onTap: () => setState(
                              () => _locationMode = _LocationMode.ownPoint,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_locationMode == _LocationMode.existingSpot)
                    GestureDetector(
                      onTap: _pickSpot,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
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
                            Icon(Symbols.place, color: colors.colorBrand),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                selectedSpot?.name ?? l10n.createEventPickSpot,
                                style: context.typography.body,
                              ),
                            ),
                            Icon(Symbols.expand_more, color: colors.text700),
                          ],
                        ),
                      ),
                    )
                  else ...[
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
                    if (_latitude != null && _longitude != null) ...[
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: SizedBox(
                          height: 200,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              MapWidget(
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
                                    zoom: 14,
                                  ),
                                ),
                              ),
                              IgnorePointer(
                                child: Center(
                                  child: Icon(
                                    Symbols.place,
                                    fill: 1,
                                    size: 30,
                                    color: colors.colorAction,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                  if (_showErrors &&
                      (_locationMode == _LocationMode.existingSpot
                          ? _selectedSpotId == null
                          : _latitude == null))
                    _ErrorText(l10n.createEventLocationRequired),

                  _SectionLabel(l10n.createEventSportsLabel, top: 18),
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

                  _SectionLabel(l10n.createSpotDescriptionLabel, top: 18),
                  AppTextField(
                    controller: _descriptionController,
                    placeholder: l10n.createEventDescriptionPlaceholder,
                    multiline: true,
                  ),
                  if (_showErrors && _descriptionController.text.trim().isEmpty)
                    _ErrorText(l10n.createSpotDescriptionRequired),

                  _SectionLabel(l10n.createSpotMediaLabel, top: 18),
                  GestureDetector(
                    onTap: _pickCoverImage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surfaceCard,
                        border: Border.all(
                          color: _coverImage != null
                              ? colors.colorRating
                              : colors.hairlineStrong,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            _coverImage != null
                                ? Symbols.check_circle
                                : Symbols.add_photo_alternate,
                            size: 26,
                            color: colors.colorBrand,
                          ),
                          const SizedBox(height: 7),
                          Text(
                            l10n.createSpotUploadPhoto,
                            style: context.typography.title.copyWith(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
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
                label: _submitting ? '…' : l10n.createEventPublish,
                onPressed: _submitting ? null : _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Spot? _findSpot(List<Spot> spots, int? spotId) {
  if (spotId == null) return null;
  for (final spot in spots) {
    if (spot.id == spotId) return spot;
  }
  return null;
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

class _DateTile extends StatelessWidget {
  const _DateTile({
    required this.icon,
    required this.label,
    this.placeholder,
    required this.onTap,
  });

  final IconData icon;
  final String? label;
  final String? placeholder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          color: colors.surfaceCard,
          border: Border.all(color: colors.hairlineStrong),
          borderRadius: BorderRadius.circular(context.spacing.radiusMd),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label ?? placeholder ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.typography.bodySm.copyWith(
                  color: label != null ? colors.text100 : colors.textMuted,
                ),
              ),
            ),
            Icon(
              icon,
              size: 18,
              color: label != null ? colors.colorBrand : colors.text700,
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationModeTab extends StatelessWidget {
  const _LocationModeTab({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? colors.colorAction : null,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          label,
          style: context.typography.tag.copyWith(
            color: active ? colors.colorOnAction : colors.text300,
          ),
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
