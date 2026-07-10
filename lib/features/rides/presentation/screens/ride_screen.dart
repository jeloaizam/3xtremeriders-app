import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/domain/role.dart';
import '../../../spots/presentation/widgets/photo_viewer_screen.dart';
import '../../../spots/presentation/widgets/video_player_screen.dart';
import '../../application/ride_detail.dart';
import '../../application/rides_providers.dart';
import '../../domain/ride_element.dart';
import '../../domain/ride_state.dart';
import '../ride_state_visuals.dart';

enum _MediaTab { video, photo }

/// Full detail for a single [Ride] (a rider's gear/vehicle): its elements
/// (pedals, handlebar, seat, wheels...), status, and the owner's
/// photos/videos tagged specifically with this ride.
class RideScreen extends ConsumerStatefulWidget {
  const RideScreen({super.key, required this.rideId});

  final int rideId;

  @override
  ConsumerState<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends ConsumerState<RideScreen> {
  _MediaTab _tab = _MediaTab.photo;

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(rideDetailProvider(widget.rideId));
    final states = ref.watch(rideStatesProvider).value ?? const <RideState>[];
    final currentRider = ref.watch(currentRiderProvider).value;

    return Scaffold(
      body: SafeArea(
        child: detailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (detail) {
            final canEdit =
                currentRider != null &&
                (currentRider.id == detail.ride.ownerId ||
                    currentRider.roleId >= roleAdmin);
            return _RideScreenBody(
              detail: detail,
              state: _findState(states, detail.ride.stateId),
              tab: _tab,
              onTabChanged: (tab) => setState(() => _tab = tab),
              onBack: () => context.pop(),
              canEdit: canEdit,
              onEdit: () => context.push('/rides/${widget.rideId}/edit'),
            );
          },
        ),
      ),
    );
  }
}

RideState? _findState(List<RideState> states, int? stateId) {
  if (stateId == null) return null;
  for (final state in states) {
    if (state.id == stateId) return state;
  }
  return null;
}

class _RideScreenBody extends StatelessWidget {
  const _RideScreenBody({
    required this.detail,
    required this.state,
    required this.tab,
    required this.onTabChanged,
    required this.onBack,
    required this.canEdit,
    required this.onEdit,
  });

  final RideDetailData detail;
  final RideState? state;
  final _MediaTab tab;
  final void Function(_MediaTab tab) onTabChanged;
  final VoidCallback onBack;
  final bool canEdit;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final ride = detail.ride;
    final visual = RideStateVisual.of(state?.name, colors, l10n);

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 30),
      children: [
        Row(
          children: [
            AppIconButton(icon: Symbols.arrow_back, onPressed: onBack),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                ride.name.toUpperCase(),
                style: context.typography.displaySm,
              ),
            ),
            if (visual != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: visual.color.withValues(alpha: .14),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  visual.label,
                  style: context.typography.tag.copyWith(color: visual.color),
                ),
              ),
            if (canEdit) ...[
              const SizedBox(width: 8),
              AppIconButton(icon: Symbols.edit, onPressed: onEdit),
            ],
          ],
        ),
        if (ride.condition != null) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                l10n.createRideConditionLabel,
                style: context.typography.micro,
              ),
              const SizedBox(width: 8),
              for (var i = 1; i <= 5; i++)
                Container(
                  width: 7,
                  height: 7,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i <= ride.condition!
                        ? colors.colorBrand
                        : colors.hairlineStrong,
                  ),
                ),
            ],
          ),
        ],
        if (ride.coverPhotoUrl != null) ...[
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                ride.coverPhotoUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: colors.surfaceMedia,
                  alignment: Alignment.center,
                  child: Icon(Symbols.broken_image, color: colors.text700),
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 22),
        Text(
          l10n.rideElementsTitle(detail.elements.length),
          style: context.typography.tag.copyWith(color: colors.text300),
        ),
        const SizedBox(height: 12),
        if (detail.elements.isEmpty)
          Text(l10n.rideNoElements, style: context.typography.bodySm)
        else
          for (final element in detail.elements) _ElementRow(element: element),

        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: _TabButton(
                label: l10n.spotMediaPhotoTab,
                active: tab == _MediaTab.photo,
                onTap: () => onTabChanged(_MediaTab.photo),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _TabButton(
                label: l10n.spotMediaVideoTab,
                active: tab == _MediaTab.video,
                onTap: () => onTabChanged(_MediaTab.video),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (tab == _MediaTab.photo)
          if (detail.photos.isEmpty)
            Text(l10n.spotNoMedia, style: context.typography.bodySm)
          else
            _MediaGrid(
              count: detail.photos.length,
              tileBuilder: (i) => _PhotoTile(url: detail.photos[i].url),
            )
        else if (detail.videos.isEmpty)
          Text(l10n.spotNoVideos, style: context.typography.bodySm)
        else
          _MediaGrid(
            count: detail.videos.length,
            tileBuilder: (i) => _VideoTile(url: detail.videos[i].url),
          ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
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
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? colors.colorAction : colors.surfaceCard,
          border: Border.all(
            color: active ? colors.colorAction : colors.hairline,
          ),
          borderRadius: BorderRadius.circular(context.spacing.radiusMd),
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

class _MediaGrid extends StatelessWidget {
  const _MediaGrid({required this.count, required this.tileBuilder});

  final int count;
  final Widget Function(int index) tileBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: count,
      itemBuilder: (context, index) => tileBuilder(index),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => PhotoViewerScreen(url: url),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: colors.surfaceMedia,
            alignment: Alignment.center,
            child: Icon(Symbols.broken_image, color: colors.text700),
          ),
        ),
      ),
    );
  }
}

class _VideoTile extends StatelessWidget {
  const _VideoTile({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => VideoPlayerScreen(url: url),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: colors.surfaceMedia,
          alignment: Alignment.center,
          child: Icon(
            Symbols.play_circle,
            fill: 1,
            size: 30,
            color: colors.colorAction,
          ),
        ),
      ),
    );
  }
}

class _ElementRow extends StatelessWidget {
  const _ElementRow({required this.element});

  final RideElement element;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
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
              child: Icon(Symbols.build, size: 18, color: colors.colorBrand),
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
          ],
        ),
      ),
    );
  }
}
