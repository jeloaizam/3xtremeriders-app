import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/data/auth_repository.dart';
import '../../../auth/domain/role.dart';
import '../../../spots/application/spots_providers.dart';
import '../../../spots/domain/spot.dart';
import '../../../spots/domain/sport.dart';
import '../../../spots/presentation/screens/search_screen.dart' show SearchTab;
import '../../../spots/presentation/sport_visuals.dart';
import '../../../spots/presentation/widgets/spot_card.dart';
import '../map_pin_renderer.dart';
import '../widgets/active_sport_picker_sheet.dart';
import '../widgets/map_sport_filter_sheet.dart';

/// Mirrors `ui_kits/mobile/HomeScreen.jsx` from the design project, with a
/// real interactive Mapbox map replacing the design's static mock background.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

enum _LocationGate {
  checking,
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
  ready,
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pinManager;
  CircleAnnotationManager? _haloManager;
  Spot? _selectedSpot;
  final Map<String, Spot> _spotByAnnotationId = {};
  List<Spot> _lastSpots = [];
  final List<_PulsingHalo> _pulsingHalos = [];
  Timer? _pulseTimer;
  double _pulsePhase = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _LocationGate _gate = _LocationGate.checking;
  geo.Position? _riderPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkLocationGate();
  }

  @override
  void dispose() {
    _pulseTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-checks when the rider comes back from the system location settings
    // or the app's own settings screen, so they don't have to manually
    // retry after enabling GPS/granting the permission.
    if (state == AppLifecycleState.resumed && _gate != _LocationGate.ready) {
      _checkLocationGate();
    }
  }

  /// Same permission dance as `CreateSpotScreen._useCurrentLocation`, but
  /// blocking: Home can't show a map without a real position, so there's no
  /// fallback center to fall back to.
  Future<void> _checkLocationGate() async {
    if (!await geo.Geolocator.isLocationServiceEnabled()) {
      if (mounted) setState(() => _gate = _LocationGate.serviceDisabled);
      return;
    }

    var permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
    }
    if (permission == geo.LocationPermission.deniedForever) {
      if (mounted) {
        setState(() => _gate = _LocationGate.permissionDeniedForever);
      }
      return;
    }
    if (permission == geo.LocationPermission.denied) {
      if (mounted) setState(() => _gate = _LocationGate.permissionDenied);
      return;
    }

    final position = await geo.Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        _riderPosition = position;
        _gate = _LocationGate.ready;
      });
    }
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;

    final riderPosition = _riderPosition!;
    final center = Point(
      coordinates: Position(riderPosition.longitude, riderPosition.latitude),
    );
    await mapboxMap.setCamera(CameraOptions(center: center, zoom: 12.5));

    // Halo manager created first so its circle layer sits *below* the pin
    // manager's point layer — otherwise the pulsing halos would render on
    // top of (and hide) the sport icons.
    _haloManager = await mapboxMap.annotations.createCircleAnnotationManager();
    final pinManager = await mapboxMap.annotations
        .createPointAnnotationManager();
    _pinManager = pinManager;

    final spots = await ref.read(nearbySpotsProvider.future);
    await _refreshAnnotations(spots);

    pinManager.tapEvents(
      onTap: (annotation) {
        final spot = _spotByAnnotationId[annotation.id];
        if (spot != null) _selectSpot(spot);
      },
    );

    _pulseTimer = Timer.periodic(
      const Duration(milliseconds: 60),
      (_) => _tickPulse(),
    );
  }

  void _selectSpot(Spot? spot) {
    if (!mounted) return;
    setState(() => _selectedSpot = spot);
    _syncHalos();
  }

  /// Applies "Personalizar mapa" (`Rider.mapSportFilter`) — spots with no
  /// sport tagged always show (there's nothing to filter them by), since
  /// hiding them would just make old spots disappear with no way back.
  List<Spot> _applyMapFilter(List<Spot> spots) {
    final filter = ref.read(currentRiderProvider).value?.mapSportFilter;
    if (filter == null) return spots;
    final filterSet = filter.toSet();
    return [
      for (final spot in spots)
        if (spot.sportIds.isEmpty || spot.sportIds.any(filterSet.contains))
          spot,
    ];
  }

  bool _sameFilter(List<int>? a, List<int>? b) {
    if (a == null || b == null) return a == b;
    if (a.length != b.length) return false;
    return a.toSet().containsAll(b);
  }

  /// Rebuilds the map pins from scratch — called on first load and whenever
  /// `nearbySpotsProvider` changes (e.g. right after creating a new spot),
  /// since annotations aren't reactively tied to the provider on their own.
  Future<void> _refreshAnnotations(List<Spot> spots) async {
    final manager = _pinManager;
    if (manager == null) return;

    final visible = _applyMapFilter(spots);
    _lastSpots = visible;

    await manager.deleteAll();
    if (!mounted) return;
    _spotByAnnotationId.clear();

    final colors = context.colors;
    final allSports = await ref.read(allSportsProvider.future);
    final sportById = {for (final sport in allSports) sport.id: sport};
    if (!mounted) return;

    final options = <PointAnnotationOptions>[];
    for (final spot in visible) {
      final sports = [
        for (final id in spot.sportIds)
          if (sportById[id] != null) sportById[id]!,
      ];
      final image = await _pinImageFor(sports, colors);
      options.add(
        PointAnnotationOptions(
          geometry: Point(coordinates: Position(spot.longitude, spot.latitude)),
          image: image,
          iconSize: sports.length <= 1 ? 0.5 : 0.55,
        ),
      );
    }
    if (!mounted) return;

    final created = await manager.createMulti(options);
    for (var i = 0; i < created.length; i++) {
      final annotation = created[i];
      if (annotation != null) _spotByAnnotationId[annotation.id] = visible[i];
    }

    await _syncHalos();
  }

  /// Resolves which pin image a spot should use: one sport shows that
  /// sport's icon, several show a "featured spot" badge (like a well-known
  /// skatepark that hosts multiple disciplines), none falls back to a
  /// plain dot (only possible for spots published before sport selection
  /// became mandatory).
  Future<Uint8List> _pinImageFor(List<Sport> sports, AppColors colors) {
    if (sports.isEmpty) {
      return MapPinRenderer.genericPin(
        color: colors.colorBrand,
        borderColor: colors.bg850,
      );
    }
    if (sports.length == 1) {
      final visual = SportVisual.of(sports.first.name, colors);
      return MapPinRenderer.singleSport(
        icon: visual.icon,
        color: visual.color,
        bgColor: colors.surface700,
      );
    }
    final shown = sports.take(3).toList();
    return MapPinRenderer.multiSportBadge(
      icons: [for (final s in shown) SportVisual.of(s.name, colors).icon],
      iconColors: [for (final s in shown) SportVisual.of(s.name, colors).color],
      badgeColor: colors.colorAction,
      bgColor: colors.surface700,
      overflowCount: sports.length > 3 ? sports.length - 3 : 0,
    );
  }

  /// Rebuilds the pulsing halo circles: a subtle one under each of the 5
  /// spots closest to the rider, plus a brighter/faster one under whichever
  /// spot is currently selected. Called whenever the spot list or the
  /// selection changes — cheap enough since it's at most 6 annotations.
  Future<void> _syncHalos() async {
    final haloManager = _haloManager;
    if (haloManager == null) return;

    await haloManager.deleteAll();
    _pulsingHalos.clear();
    if (!mounted) return;

    final colors = context.colors;
    final riderPosition = _riderPosition;

    if (riderPosition != null && _lastSpots.isNotEmpty) {
      final nearest = [..._lastSpots]
        ..sort(
          (a, b) => _distanceMeters(
            riderPosition,
            a,
          ).compareTo(_distanceMeters(riderPosition, b)),
        );
      final options = [
        for (final spot in nearest.take(5))
          CircleAnnotationOptions(
            geometry: Point(
              coordinates: Position(spot.longitude, spot.latitude),
            ),
            circleRadius: 16,
            circleColor: colors.colorBrand.toARGB32(),
            circleOpacity: .2,
          ),
      ];
      final created = await haloManager.createMulti(options);
      for (final annotation in created) {
        if (annotation == null) continue;
        _pulsingHalos.add(
          _PulsingHalo(
            annotation: annotation,
            baseRadius: 16,
            amplitude: 5,
            baseOpacity: .2,
            speed: 1,
          ),
        );
      }
    }

    final selected = _selectedSpot;
    if (selected != null) {
      final annotation = await haloManager.create(
        CircleAnnotationOptions(
          geometry: Point(
            coordinates: Position(selected.longitude, selected.latitude),
          ),
          circleRadius: 22,
          circleColor: colors.colorAction.toARGB32(),
          circleOpacity: .32,
        ),
      );
      _pulsingHalos.add(
        _PulsingHalo(
          annotation: annotation,
          baseRadius: 22,
          amplitude: 8,
          baseOpacity: .32,
          speed: 2.4,
        ),
      );
    }
  }

  /// Drives the "radar ping" look: radius grows while opacity fades, on a
  /// loop — each halo's `speed` controls how fast it cycles.
  void _tickPulse() {
    final manager = _haloManager;
    if (manager == null || _pulsingHalos.isEmpty) return;
    _pulsePhase += 0.06;
    for (final halo in _pulsingHalos) {
      final t = (sin(_pulsePhase * halo.speed) + 1) / 2;
      halo.annotation.circleRadius = halo.baseRadius + halo.amplitude * t;
      halo.annotation.circleOpacity = halo.baseOpacity * (1 - t * 0.6);
      manager.update(halo.annotation);
    }
  }

  double _distanceMeters(geo.Position from, Spot to) {
    const earthRadiusMeters = 6371000.0;
    final lat1 = from.latitude * pi / 180;
    final lat2 = to.latitude * pi / 180;
    final dLat = (to.latitude - from.latitude) * pi / 180;
    final dLng = (to.longitude - from.longitude) * pi / 180;
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLng / 2) * sin(dLng / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusMeters * c;
  }

  Future<void> _onMyLocationTap() async {
    final status = await Permission.location.request();
    final mapboxMap = _mapboxMap;
    if (!status.isGranted || mapboxMap == null) return;

    await mapboxMap.location.updateSettings(
      LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );

    // Re-fetches the position (the rider may have moved since Home's
    // initial gate check) and actually recenters the camera — the location
    // component above only turns on the blue dot, it doesn't move the map.
    // Also updates `_riderPosition` so the "nearest spots" halo tracks the
    // rider's live location instead of staying pinned to where Home first
    // checked the gate.
    final position = await geo.Geolocator.getCurrentPosition();
    if (mounted) setState(() => _riderPosition = position);
    await _syncHalos();
    await mapboxMap.flyTo(
      CameraOptions(
        center: Point(
          coordinates: Position(position.longitude, position.latitude),
        ),
        zoom: 14,
      ),
      MapAnimationOptions(duration: 800),
    );
  }

  void _showComingSoon() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).comingSoon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Triggers the one-time backend rider sync (POST /auth/sync) as soon as
    // Home loads, so authenticated calls elsewhere (Spot likes/ratings)
    // don't 401 just because the rider never visited Settings.
    ref.watch(currentRiderProvider);

    if (_gate != _LocationGate.ready) {
      return _LocationGateScreen(gate: _gate, onRetry: _checkLocationGate);
    }

    // Keeps the map pins in sync whenever the spot list changes (e.g. right
    // after publishing a new spot) — the annotations themselves are an
    // imperative one-time side effect in _onMapCreated, not otherwise tied
    // to this provider.
    ref.listen(nearbySpotsProvider, (previous, next) {
      final spots = next.value;
      if (spots != null) _refreshAnnotations(spots);
    });

    // Same idea, but for "Personalizar mapa" — the spot list itself hasn't
    // changed, only which sports are filtered, so this needs its own
    // listener to trigger a redraw with the new filter applied.
    ref.listen(currentRiderProvider, (previous, next) {
      final prevFilter = previous?.value?.mapSportFilter;
      final nextFilter = next.value?.mapSportFilter;
      if (_sameFilter(prevFilter, nextFilter)) return;
      final spots = ref.read(nearbySpotsProvider).value;
      if (spots != null) _refreshAnnotations(spots);
    });

    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final spotsAsync = ref.watch(nearbySpotsProvider);

    final rider = ref.watch(currentRiderProvider).value;
    final allSports = ref.watch(allSportsProvider).value ?? const <Sport>[];
    final activeSportId = ref.watch(effectiveActiveSportIdProvider).value;

    Sport? activeSport;
    if (activeSportId != null) {
      for (final sport in allSports) {
        if (sport.id == activeSportId) {
          activeSport = sport;
          break;
        }
      }
    }

    // null = no filter (every sport shown) — see MapSportFilterSheet.
    final mapFilter = rider?.mapSportFilter?.toSet();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const _AppDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: MapWidget(
              styleUri: MapboxStyles.DARK,
              onMapCreated: _onMapCreated,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 0.24, 0.45, 0.55, 1],
                    colors: [
                      colors.bg850.withValues(alpha: .85),
                      colors.bg850.withValues(alpha: .3),
                      Colors.transparent,
                      Colors.transparent,
                      colors.bg850.withValues(alpha: .9),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          style: context.typography.displaySm.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                          children: [
                            TextSpan(
                              text: '3',
                              style: TextStyle(color: colors.colorAction),
                            ),
                            const TextSpan(text: 'xtreme Riders'),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          AppIconButton(
                            icon: Symbols.my_location,
                            chrome: true,
                            color: colors.colorBrand,
                            onPressed: _onMyLocationTap,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => context.push('/settings'),
                            child: AppAvatar(
                              initial:
                                  rider != null && rider.nickname.isNotEmpty
                                  ? rider.nickname[0].toUpperCase()
                                  : '?',
                              imageUrl: rider?.iconImage,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.homeActiveSpots(
                      spotsAsync.value?.length ?? 0,
                      'BOGOTÁ',
                    ),
                    style: context.typography.eyebrow.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => context.push('/search'),
                          child: IgnorePointer(
                            child: AppTextField(
                              icon: Symbols.search,
                              placeholder: l10n.homeSearchPlaceholder,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      AppIconButton(
                        icon: Symbols.tune,
                        active: true,
                        onPressed: () => context.push('/search'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom:
                context.spacing.navHeight +
                14 +
                MediaQuery.of(context).padding.bottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    l10n.homeNearYou,
                    style: context.typography.eyebrow.copyWith(
                      color: colors.text300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 96,
                  child: spotsAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, _) => Center(child: Text('$error')),
                    data: (spots) {
                      final visible = mapFilter == null
                          ? spots
                          : [
                              for (final spot in spots)
                                if (spot.sportIds.isEmpty ||
                                    spot.sportIds.any(mapFilter.contains))
                                  spot,
                            ];
                      // Spots matching the active sport bubble to the
                      // front — same set, just reordered, so nothing
                      // disappears just because it's not the active sport.
                      final matching = activeSportId == null
                          ? const <Spot>[]
                          : [
                              for (final spot in visible)
                                if (spot.sportIds.contains(activeSportId)) spot,
                            ];
                      final rest = activeSportId == null
                          ? visible
                          : [
                              for (final spot in visible)
                                if (!spot.sportIds.contains(activeSportId))
                                  spot,
                            ];
                      final ordered = [...matching, ...rest];

                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: ordered.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final spot = ordered[index];
                          return SizedBox(
                            width: 200,
                            child: SpotCard(
                              spot: spot,
                              onTap: () => _selectSpot(spot),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: AppBottomNav(
                active: 'ride',
                items: [
                  AppBottomNavItem(
                    id: 'buscar',
                    icon: Symbols.tune,
                    label: l10n.homeNavCustomizeMap.toUpperCase(),
                  ),
                  AppBottomNavItem(
                    id: 'menu',
                    icon: Symbols.menu,
                    label: l10n.navMenu.toUpperCase(),
                  ),
                  AppBottomNavItem(
                    id: 'ride',
                    icon: Symbols.pedal_bike,
                    label: l10n.navRide.toUpperCase(),
                  ),
                  AppBottomNavItem(
                    id: 'sport',
                    icon: activeSport != null
                        ? SportVisual.of(activeSport.name, colors).icon
                        : Symbols.sports,
                    label: (activeSport?.name ?? l10n.navSport).toUpperCase(),
                    enableDoubleTap: true,
                  ),
                  AppBottomNavItem(
                    id: 'ajustes',
                    icon: Symbols.settings,
                    label: l10n.navSettings.toUpperCase(),
                  ),
                ],
                onSelect: (id) {
                  if (id == 'ajustes') {
                    context.push('/settings');
                  } else if (id == 'menu') {
                    _scaffoldKey.currentState?.openDrawer();
                  } else if (id == 'buscar') {
                    MapSportFilterSheet.show(context);
                  } else if (id == 'ride') {
                    context.push('/rides');
                  } else if (id == 'sport') {
                    if (activeSport != null) {
                      context.push('/sports/${activeSport.id}');
                    } else {
                      context.push('/search', extra: SearchTab.sports);
                    }
                  } else {
                    _showComingSoon();
                  }
                },
                onDoubleTap: (id) {
                  if (id == 'sport' && rider != null) {
                    ActiveSportPickerSheet.show(context, riderId: rider.id);
                  }
                },
              ),
            ),
          ),
          if (_selectedSpot != null)
            _QuickViewSheet(
              spot: _selectedSpot!,
              onClose: () => _selectSpot(null),
              onViewSpot: () {
                final spot = _selectedSpot!;
                _selectSpot(null);
                context.push('/spot/${spot.id}');
              },
            ),
        ],
      ),
    );
  }
}

/// One pulsing halo circle tracked by `_HomeScreenState._tickPulse` — either
/// one of the 5 "nearby spots" halos or the single "selected spot" one.
class _PulsingHalo {
  _PulsingHalo({
    required this.annotation,
    required this.baseRadius,
    required this.amplitude,
    required this.baseOpacity,
    required this.speed,
  });

  final CircleAnnotation annotation;
  final double baseRadius;
  final double amplitude;
  final double baseOpacity;
  final double speed;
}

/// Full-screen, non-dismissible gate shown instead of the map while the
/// rider hasn't turned on GPS and granted location access yet — Home has no
/// fixed fallback city to fall back to anymore, so it blocks here instead.
class _LocationGateScreen extends StatelessWidget {
  const _LocationGateScreen({required this.gate, required this.onRetry});

  final _LocationGate gate;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    if (gate == _LocationGate.checking || gate == _LocationGate.ready) {
      return Scaffold(
        backgroundColor: colors.surfaceApp,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final l10n = AppLocalizations.of(context);

    final String body;
    final String buttonLabel;
    final VoidCallback onPrimary;
    switch (gate) {
      case _LocationGate.serviceDisabled:
        body = l10n.homeLocationGateServiceBody;
        buttonLabel = l10n.homeLocationGateEnableButton;
        onPrimary = () => geo.Geolocator.openLocationSettings();
      case _LocationGate.permissionDeniedForever:
        body = l10n.homeLocationGateDeniedForeverBody;
        buttonLabel = l10n.homeLocationGateOpenSettingsButton;
        onPrimary = () => geo.Geolocator.openAppSettings();
      case _LocationGate.permissionDenied:
      case _LocationGate.checking:
      case _LocationGate.ready:
        body = l10n.homeLocationGatePermissionBody;
        buttonLabel = l10n.homeLocationGateGrantButton;
        onPrimary = onRetry;
    }

    return Scaffold(
      backgroundColor: colors.surfaceApp,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Symbols.location_disabled,
                size: 56,
                color: colors.colorBrand,
              ),
              const SizedBox(height: 18),
              Text(
                l10n.homeLocationGateTitle,
                style: context.typography.displaySm,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                body,
                style: context.typography.bodySm.copyWith(
                  color: colors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AppButton(label: buttonLabel, onPressed: onPrimary),
              const SizedBox(height: 12),
              TextButton(
                onPressed: onRetry,
                child: Text(l10n.homeLocationGateRetry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Quick-info sheet that slides up when a map pin is tapped — mirrors the
/// `hasSheet`/`sheet` state in `Deportes Extremos App v2.dc.html`. Tapping
/// "VER SPOT" (or the card itself) goes to the full [SpotScreen]; tapping
/// the scrim dismisses it.
class _QuickViewSheet extends ConsumerWidget {
  const _QuickViewSheet({
    required this.spot,
    required this.onClose,
    required this.onViewSpot,
  });

  final Spot spot;
  final VoidCallback onClose;
  final VoidCallback onViewSpot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);
    final sports = ref.watch(spotSportsProvider(spot.id)).value ?? const [];
    final elementCount =
        ref.watch(spotElementsProvider(spot.id)).value?.length ?? 0;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose,
            child: Container(color: Colors.black.withValues(alpha: .5)),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom:
              context.spacing.navHeight + MediaQuery.of(context).padding.bottom,
          child: GestureDetector(
            onTap: onViewSpot,
            child: Container(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 22),
              decoration: BoxDecoration(
                color: colors.surfaceCard,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                border: Border(top: BorderSide(color: colors.hairline)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colors.hairlineStrong,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: SizedBox(
                      width: double.infinity,
                      height: 110,
                      child: spot.coverPhotoUrl != null
                          ? Image.network(
                              spot.coverPhotoUrl!,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: colors.surfaceMedia,
                              alignment: Alignment.center,
                              child: Icon(
                                spot.coverVideoUrl != null
                                    ? Symbols.play_circle
                                    : Symbols.image,
                                size: 30,
                                color: colors.text700,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              spot.name,
                              style: context.typography.title.copyWith(
                                fontSize: 20,
                                height: 1,
                              ),
                            ),
                            if (sports.isNotEmpty) ...[
                              const SizedBox(height: 5),
                              Text(
                                sports.map((s) => s.name).join(' · '),
                                style: context.typography.meta,
                              ),
                            ],
                          ],
                        ),
                      ),
                      Icon(
                        Symbols.chevron_right,
                        size: 22,
                        color: colors.text700,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _SheetChip(
                        icon: Symbols.star,
                        label: spot.ratingAvg?.toStringAsFixed(1) ?? '—',
                        color: colors.colorRating,
                      ),
                      if (spot.difficulty != null)
                        _SheetChip(
                          icon: Symbols.signal_cellular_alt,
                          label: '${spot.difficulty}/5',
                          color: colors.colorInfo,
                        ),
                      if (spot.hazardCount > 0)
                        _SheetChip(
                          icon: Symbols.personal_injury,
                          label: spot.hazardAvg!.toStringAsFixed(1),
                          color: colors.colorWarn,
                        ),
                      if (elementCount > 0)
                        _SheetChip(
                          icon: Symbols.construction,
                          label: '$elementCount',
                          color: colors.colorBrand,
                        ),
                      if (spot.neighborhood != null)
                        _SheetChip(
                          icon: Symbols.location_on,
                          label: spot.neighborhood!,
                          color: colors.blue500,
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: l10n.homeSheetViewSpot,
                      onPressed: onViewSpot,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SheetChip extends StatelessWidget {
  const _SheetChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: context.typography.tag.copyWith(color: color)),
        ],
      ),
    );
  }
}

/// Hamburger drawer — mirrors the slide-in menu in
/// `Deportes Extremos App v2.dc.html` (profile header + MI PERFIL/MIS
/// RIDES/EVENTOS/CREAR SPOT/CREAR EVENTO/AJUSTES + logout). Only AJUSTES
/// and CREAR SPOT are wired to real screens today; the rest are
/// "coming soon" until those screens exist.
class _AppDrawer extends ConsumerWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);
    final rider = ref.watch(currentRiderProvider).value;

    void showComingSoon() {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.comingSoon)));
    }

    return Drawer(
      backgroundColor: colors.surfaceApp,
      width: 300,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              child: GestureDetector(
                onTap: rider == null
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        context.push('/riders/${rider.id}');
                      },
                child: Row(
                  children: [
                    AppAvatar(
                      initial: rider != null && rider.nickname.isNotEmpty
                          ? rider.nickname[0].toUpperCase()
                          : '?',
                      imageUrl: rider?.iconImage,
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (rider?.nickname ?? '').toUpperCase(),
                            style: context.typography.title.copyWith(
                              fontSize: 19,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            rider?.email ?? '',
                            style: context.typography.micro,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 1, color: colors.hairlineSoft),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerItem(
                    icon: Symbols.person,
                    label: l10n.drawerMyProfile,
                    onTap: rider == null
                        ? showComingSoon
                        : () {
                            Navigator.of(context).pop();
                            context.push('/riders/${rider.id}');
                          },
                  ),
                  _DrawerItem(
                    icon: Symbols.pedal_bike,
                    label: l10n.drawerMyRides,
                    onTap: () {
                      Navigator.of(context).pop();
                      context.push('/rides');
                    },
                  ),
                  _DrawerItem(
                    icon: Symbols.local_activity,
                    label: l10n.drawerEvents,
                    onTap: () {
                      Navigator.of(context).pop();
                      context.push('/events');
                    },
                  ),
                  _DrawerItem(
                    icon: Symbols.add_location_alt,
                    iconColor: colors.colorAction,
                    label: l10n.drawerCreateSpot,
                    onTap: () {
                      Navigator.of(context).pop();
                      context.push('/spot/new');
                    },
                  ),
                  // Events are "official" — only admins can create them
                  // (enforced server-side too, see require_admin on
                  // POST /events/), so hide the entry point entirely for
                  // everyone else rather than showing a disabled item.
                  if ((rider?.roleId ?? 0) >= roleAdmin)
                    _DrawerItem(
                      icon: Symbols.event,
                      iconColor: colors.colorAction,
                      label: l10n.drawerCreateEvent,
                      onTap: () {
                        Navigator.of(context).pop();
                        context.push('/events/new');
                      },
                    ),
                  _DrawerItem(
                    icon: Symbols.settings,
                    label: l10n.navSettings.toUpperCase(),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.push('/settings');
                    },
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: colors.hairlineSoft),
            _DrawerItem(
              icon: Symbols.logout,
              label: l10n.drawerLogout,
              onTap: () {
                Navigator.of(context).pop();
                ref.read(authRepositoryProvider).signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        child: Row(
          children: [
            Icon(icon, size: 23, color: iconColor ?? colors.colorBrand),
            const SizedBox(width: 15),
            Text(label, style: context.typography.title.copyWith(fontSize: 17)),
          ],
        ),
      ),
    );
  }
}
