import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../core/widgets/app_avatar.dart';
import '../../../../../../l10n/gen/app_localizations.dart';
import '../../../../../auth/domain/rider.dart';
import '../../../../domain/spot.dart';

/// `MoreInfoBox`'s "Descripción" tab: the creator card, opening hours (when
/// set), and the free-text description.
class DescriptionTab extends StatelessWidget {
  const DescriptionTab({super.key, required this.spot, required this.creator});

  final Spot spot;
  final Rider creator;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CreatorCard(creator: creator),
          const SizedBox(height: 14),
          if (spot.openHour != null && spot.closeHour != null) ...[
            Row(
              children: [
                Icon(Symbols.schedule, size: 18, color: colors.colorBrand),
                const SizedBox(width: 8),
                Text(l10n.spotSchedule, style: context.typography.eyebrow),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '${spot.openHour} – ${spot.closeHour}',
              style: context.typography.bodySm,
            ),
            Divider(height: 28, color: colors.hairlineSoft),
          ],
          Row(
            children: [
              Icon(Symbols.description, size: 18, color: colors.colorBrand),
              const SizedBox(width: 8),
              Text(l10n.spotDescription, style: context.typography.eyebrow),
            ],
          ),
          const SizedBox(height: 10),
          Text(spot.description, style: context.typography.bodySm),
        ],
      ),
    );
  }
}

/// Tappable card linking to the spot's creator's public profile.
class _CreatorCard extends StatelessWidget {
  const _CreatorCard({required this.creator});

  final Rider creator;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () => context.push('/riders/${creator.id}'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
        decoration: BoxDecoration(
          color: colors.surfaceCard,
          border: Border.all(color: colors.hairline),
          borderRadius: BorderRadius.circular(context.spacing.radiusMd),
        ),
        child: Row(
          children: [
            AppAvatar(
              initial: creator.nickname.isNotEmpty
                  ? creator.nickname[0].toUpperCase()
                  : '?',
              imageUrl: creator.iconImage,
              size: AppAvatarSize.sm,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.spotCreatedBy, style: context.typography.micro),
                  Text(
                    creator.nickname,
                    style: context.typography.title.copyWith(height: 1.1),
                  ),
                ],
              ),
            ),
            Icon(Symbols.chevron_right, size: 20, color: colors.text700),
          ],
        ),
      ),
    );
  }
}
