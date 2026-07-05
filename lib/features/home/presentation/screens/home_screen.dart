import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../spots/application/spots_providers.dart';
import '../../../spots/presentation/widgets/spot_card.dart';

/// Mirrors `ui_kits/mobile/HomeScreen.jsx` from the design project, with a
/// real interactive Mapbox map replacing the design's static mock background.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  MapboxMap? _mapboxMap;

  static final _bogotaCenter = Point(coordinates: Position(-74.0721, 4.7110));

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;
    final pinBorderColor = context.colors.bg850.toARGB32();

    await mapboxMap.setCamera(
      CameraOptions(center: _bogotaCenter, zoom: 12.5),
    );

    final manager = await mapboxMap.annotations.createCircleAnnotationManager();

    final spots = ref.read(nearbySpotsProvider);
    final options = [
      for (final spot in spots)
        CircleAnnotationOptions(
          geometry: Point(coordinates: Position(spot.lng, spot.lat)),
          circleRadius: 9,
          circleColor: spot.pinColor.toARGB32(),
          circleStrokeWidth: 2,
          circleStrokeColor: pinBorderColor,
        ),
    ];
    await manager.createMulti(options);

    manager.tapEvents(onTap: (_) => _showComingSoon());
  }

  Future<void> _onMyLocationTap() async {
    final status = await Permission.location.request();
    if (!status.isGranted || _mapboxMap == null) return;
    await _mapboxMap!.location.updateSettings(
      LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );
  }

  void _showComingSoon() {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).comingSoon)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final spots = ref.watch(nearbySpotsProvider);

    return Scaffold(
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
                            child: const AppAvatar(initial: 'M'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.homeActiveSpots(42, 'BOGOTÁ'),
                    style: context.typography.eyebrow.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          icon: Symbols.search,
                          placeholder: l10n.homeSearchPlaceholder,
                        ),
                      ),
                      const SizedBox(width: 10),
                      AppIconButton(icon: Symbols.tune, active: true),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: context.spacing.navHeight +
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
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: spots.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final spot = spots[index];
                      return SizedBox(
                        width: 200,
                        child: SpotCard(
                          spot: spot,
                          onTap: _showComingSoon,
                        ),
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
                    icon: Symbols.search,
                    label: l10n.navSearch.toUpperCase(),
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
                    id: 'ajustes',
                    icon: Symbols.settings,
                    label: l10n.navSettings.toUpperCase(),
                  ),
                ],
                onSelect: (id) {
                  if (id == 'ajustes') {
                    context.push('/settings');
                  } else {
                    _showComingSoon();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
