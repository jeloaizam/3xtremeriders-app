import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/domain/rider.dart';
import '../../../events/domain/event.dart';
import '../../application/sport_detail_providers.dart';
import '../../domain/spot_photo.dart';
import '../../domain/spot_video.dart';
import '../sport_visuals.dart';
import '../widgets/photo_viewer_screen.dart';
import '../widgets/spot_card.dart';
import '../widgets/video_player_screen.dart';
import 'spot_screen.dart' show MediaTile;

/// New (not part of the original 13-screen prototype — no `isSport` state
/// exists in `Deportes Extremos App v2.dc.html`): a dedicated view per
/// `Sport` with a ranking zone (top riders by reputation + top spots by
/// rating), the sport's events (past/upcoming), and its most-voted
/// photos/videos across every spot where it's practiced.
class SportScreen extends ConsumerWidget {
  const SportScreen({super.key, required this.sportId});

  final int sportId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final detailAsync = ref.watch(sportDetailProvider(sportId));

    return Scaffold(
      body: SafeArea(
        child: detailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (detail) {
            final visual = SportVisual.of(detail.sport.name, colors);
            final now = DateTime.now();
            final upcoming = detail.events
                .where((e) => !e.startDate.isBefore(now))
                .toList();
            final past = detail.events
                .where((e) => e.startDate.isBefore(now))
                .toList();

            return ListView(
              padding: EdgeInsets.fromLTRB(
                20,
                6,
                20,
                20 + MediaQuery.of(context).padding.bottom,
              ),
              children: [
                Row(
                  children: [
                    AppIconButton(
                      icon: Symbols.arrow_back,
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: visual.color.withValues(alpha: .14),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(visual.icon, color: visual.color, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        detail.sport.name.toUpperCase(),
                        style: context.typography.displaySm,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(detail.sport.description, style: context.typography.body),

                const SizedBox(height: 28),
                _SectionLabel(l10n.sportRankingSection),
                const SizedBox(height: 12),
                Text(
                  l10n.sportTopRidersLabel,
                  style: context.typography.eyebrow.copyWith(
                    color: colors.text300,
                  ),
                ),
                const SizedBox(height: 8),
                if (detail.topRiders.isEmpty)
                  _EmptyHint(l10n.sportNoRidersYet)
                else
                  for (var i = 0; i < detail.topRiders.length; i++) ...[
                    _RiderRankRow(order: i + 1, rider: detail.topRiders[i]),
                    if (i != detail.topRiders.length - 1)
                      const SizedBox(height: 8),
                  ],
                const SizedBox(height: 20),
                Text(
                  l10n.sportTopSpotsLabel,
                  style: context.typography.eyebrow.copyWith(
                    color: colors.text300,
                  ),
                ),
                const SizedBox(height: 8),
                if (detail.topSpots.isEmpty)
                  _EmptyHint(l10n.sportNoSpotsYet)
                else
                  for (var i = 0; i < detail.topSpots.length; i++) ...[
                    SpotCard(
                      spot: detail.topSpots[i],
                      onTap: () =>
                          context.push('/spot/${detail.topSpots[i].id}'),
                    ),
                    if (i != detail.topSpots.length - 1)
                      const SizedBox(height: 8),
                  ],

                const SizedBox(height: 28),
                _SectionLabel(l10n.sportEventsSection),
                const SizedBox(height: 12),
                Text(
                  l10n.sportUpcomingEventsLabel,
                  style: context.typography.eyebrow.copyWith(
                    color: colors.text300,
                  ),
                ),
                const SizedBox(height: 8),
                if (upcoming.isEmpty)
                  _EmptyHint(l10n.sportNoEventsYet)
                else
                  for (var i = 0; i < upcoming.length; i++) ...[
                    _SportEventRow(event: upcoming[i]),
                    if (i != upcoming.length - 1) const SizedBox(height: 8),
                  ],
                if (past.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    l10n.sportPastEventsLabel,
                    style: context.typography.eyebrow.copyWith(
                      color: colors.text300,
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (var i = 0; i < past.length; i++) ...[
                    _SportEventRow(event: past[i]),
                    if (i != past.length - 1) const SizedBox(height: 8),
                  ],
                ],

                const SizedBox(height: 28),
                _SectionLabel(l10n.sportTopMediaSection),
                const SizedBox(height: 12),
                Text(
                  l10n.sportTopPhotosLabel,
                  style: context.typography.eyebrow.copyWith(
                    color: colors.text300,
                  ),
                ),
                const SizedBox(height: 8),
                if (detail.topPhotos.isEmpty)
                  _EmptyHint(l10n.sportNoMediaYet)
                else
                  _MediaRow(
                    height: 110,
                    itemCount: detail.topPhotos.length,
                    itemBuilder: (context, i) {
                      final photo = detail.topPhotos[i];
                      return MediaTile(
                        url: photo.url,
                        isVideo: false,
                        badge: '#${i + 1} · ${photo.voteCount}',
                        big: false,
                        onTap: () => _openPhoto(context, photo),
                      );
                    },
                  ),
                const SizedBox(height: 20),
                Text(
                  l10n.sportTopVideosLabel,
                  style: context.typography.eyebrow.copyWith(
                    color: colors.text300,
                  ),
                ),
                const SizedBox(height: 8),
                if (detail.topVideos.isEmpty)
                  _EmptyHint(l10n.sportNoMediaYet)
                else
                  _MediaRow(
                    height: 110,
                    itemCount: detail.topVideos.length,
                    itemBuilder: (context, i) {
                      final video = detail.topVideos[i];
                      return MediaTile(
                        url: video.url,
                        isVideo: true,
                        badge: '#${i + 1} · ${video.voteCount}',
                        big: false,
                        onTap: () => _openVideo(context, video),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

void _openPhoto(BuildContext context, SpotPhoto photo) {
  Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => PhotoViewerScreen(url: photo.url),
    ),
  );
}

void _openVideo(BuildContext context, SpotVideo video) {
  Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => VideoPlayerScreen(url: video.url),
    ),
  );
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.typography.displaySm);
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.typography.body.copyWith(color: context.colors.textMuted),
    );
  }
}

/// Ranked rider row for the sport's top-riders list — order numeral in the
/// action color, avatar, nickname, reputation. Loosely inspired by the
/// design project's `SportRankRow.jsx`, which is actually about a rider's
/// *own* favorite-sports list, not a leaderboard — this is a fresh widget,
/// not a port of that component.
class _RiderRankRow extends StatelessWidget {
  const _RiderRankRow({required this.order, required this.rider});

  final int order;
  final Rider rider;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () => context.push('/riders/${rider.id}'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        decoration: BoxDecoration(
          color: colors.surfaceCard,
          border: Border.all(color: colors.hairline),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 22,
              child: Text(
                '$order',
                textAlign: TextAlign.center,
                style: context.typography.title.copyWith(
                  color: colors.colorAction,
                ),
              ),
            ),
            const SizedBox(width: 12),
            AppAvatar(
              initial: rider.nickname.isNotEmpty
                  ? rider.nickname[0].toUpperCase()
                  : '?',
              imageUrl: rider.iconImage,
              size: AppAvatarSize.sm,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                rider.nickname,
                style: context.typography.title.copyWith(fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Symbols.star, size: 13, color: colors.colorRating),
            const SizedBox(width: 3),
            Text(
              '${rider.reputationPts}',
              style: context.typography.tag.copyWith(color: colors.colorRating),
            ),
          ],
        ),
      ),
    );
  }
}

class _SportEventRow extends StatelessWidget {
  const _SportEventRow({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () => context.push('/events/${event.id}'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        decoration: BoxDecoration(
          color: colors.surfaceCard,
          border: Border.all(color: colors.hairline),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Symbols.event, size: 18, color: colors.colorBrand),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                event.name,
                style: context.typography.title.copyWith(fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              DateFormat('d MMM').format(event.startDate.toLocal()),
              style: context.typography.tag.copyWith(color: colors.text300),
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaRow extends StatelessWidget {
  const _MediaRow({
    required this.height,
    required this.itemCount,
    required this.itemBuilder,
  });

  final double height;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, i) =>
            SizedBox(width: height, child: itemBuilder(context, i)),
      ),
    );
  }
}
