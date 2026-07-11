import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../rides/application/rides_providers.dart';
import '../../../rides/domain/ride.dart';
import '../../../settings/data/country_api.dart';
import '../../../settings/domain/country.dart';
import '../../application/auth_providers.dart';
import '../../application/rider_profile_providers.dart';
import '../../data/rider_api.dart';
import '../../domain/rider.dart';
import '../../domain/role.dart';

/// Any rider's public profile — opened from the Search screen's Riders
/// tab, a Spot's creator row, or the drawer's "MI PERFIL" for the
/// signed-in rider's own profile. Shows their rides, and, for admins
/// viewing anyone, a role control (used to promote riders to admin so
/// they can create official events).
class RiderProfileScreen extends ConsumerWidget {
  const RiderProfileScreen({super.key, required this.riderId});

  final int riderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(riderProfileProvider(riderId));

    return Scaffold(
      body: SafeArea(
        child: profileAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (rider) => _RiderProfileBody(rider: rider),
        ),
      ),
    );
  }
}

class _RiderProfileBody extends ConsumerWidget {
  const _RiderProfileBody({required this.rider});

  final Rider rider;

  Future<void> _changeRole(
    BuildContext context,
    WidgetRef ref,
    int newRoleId,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: context.colors.surfaceCard,
        title: Text(
          l10n.riderProfileChangeRoleTitle,
          style: context.typography.title,
        ),
        content: Text(l10n.riderProfileChangeRoleConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.dialogCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.dialogAdd),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final user = ref.read(firebaseAuthProvider).currentUser;
    final idToken = await user?.getIdToken();
    if (idToken == null) return;

    await ref
        .read(riderApiProvider)
        .update(riderId: rider.id, idToken: idToken, roleId: newRoleId);
    ref.invalidate(riderProfileProvider(rider.id));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final currentRider = ref.watch(currentRiderProvider).value;
    final isAdmin = (currentRider?.roleId ?? 0) >= roleAdmin;
    final countries = ref.watch(countriesProvider).value ?? const <Country>[];
    final country = _findCountry(countries, rider.countryId);
    final ridesAsync = ref.watch(ridesByOwnerProvider(rider.id));

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 30),
      children: [
        AppIconButton(icon: Symbols.arrow_back, onPressed: () => context.pop()),
        const SizedBox(height: 14),
        Center(
          child: Column(
            children: [
              AppAvatar(
                initial: rider.nickname.isNotEmpty
                    ? rider.nickname[0].toUpperCase()
                    : '?',
                size: AppAvatarSize.xl,
              ),
              const SizedBox(height: 12),
              Text(rider.nickname, style: context.typography.displaySm),
              const SizedBox(height: 4),
              Text(
                '${rider.name} ${rider.lastName}',
                style: context.typography.bodySm.copyWith(
                  color: colors.textMuted,
                ),
              ),
              if (rider.cityName != null || country != null) ...[
                const SizedBox(height: 6),
                Text(
                  [
                    if (rider.cityName != null) rider.cityName!,
                    if (country != null) country.name,
                  ].join(' · '),
                  style: context.typography.meta,
                ),
              ],
              const SizedBox(height: 10),
              _RoleBadge(roleId: rider.roleId),
            ],
          ),
        ),
        if (rider.bio != null && rider.bio!.isNotEmpty) ...[
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colors.surfaceCard,
              border: Border.all(color: colors.hairline),
              borderRadius: BorderRadius.circular(context.spacing.radiusXl),
            ),
            child: Text(rider.bio!, style: context.typography.bodySm),
          ),
        ],
        const SizedBox(height: 18),
        Center(
          child: Column(
            children: [
              Text(
                '${rider.reputationPts}',
                style: context.typography.displaySm.copyWith(height: .9),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.settingsReputationLabel,
                style: context.typography.meta,
              ),
            ],
          ),
        ),

        if (isAdmin) ...[
          const SizedBox(height: 22),
          Text(
            l10n.settingsRoleLabel.toUpperCase(),
            style: context.typography.tag.copyWith(color: colors.text300),
          ),
          const SizedBox(height: 10),
          _RoleSegmented(
            roleId: rider.roleId,
            onSelect: (roleId) => _changeRole(context, ref, roleId),
          ),
        ],

        const SizedBox(height: 22),
        ridesAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => Text('$error'),
          data: (rides) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.riderProfileRidesTitle(rides.length),
                style: context.typography.tag.copyWith(color: colors.text300),
              ),
              const SizedBox(height: 12),
              if (rides.isEmpty)
                Text(l10n.riderProfileNoRides, style: context.typography.bodySm)
              else
                for (final ride in rides)
                  _RideRow(
                    ride: ride,
                    onTap: () => context.push('/rides/${ride.id}'),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

Country? _findCountry(List<Country> countries, int? countryId) {
  if (countryId == null) return null;
  for (final country in countries) {
    if (country.id == countryId) return country;
  }
  return null;
}

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.roleId});

  final int roleId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final (label, color) = switch (roleId) {
      roleAdmin => (l10n.settingsRoleAdmin, colors.colorDanger),
      roleModerator => (l10n.settingsRoleModerator, colors.colorAction),
      _ => (l10n.settingsRoleUser, colors.text300),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label.toUpperCase(),
        style: context.typography.tag.copyWith(color: color),
      ),
    );
  }
}

class _RoleSegmented extends StatelessWidget {
  const _RoleSegmented({required this.roleId, required this.onSelect});

  final int roleId;
  final void Function(int roleId) onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    const options = [roleUser, roleModerator, roleAdmin];

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
                    color: roleId == option ? colors.colorAction : null,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text(
                    switch (option) {
                      roleAdmin => l10n.settingsRoleAdmin,
                      roleModerator => l10n.settingsRoleModerator,
                      _ => l10n.settingsRoleUser,
                    },
                    style: context.typography.tag.copyWith(
                      color: roleId == option
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

class _RideRow extends StatelessWidget {
  const _RideRow({required this.ride, required this.onTap});

  final Ride ride;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: colors.surfaceCard,
            border: Border.all(color: colors.hairline),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: ride.coverPhotoUrl != null
                      ? Image.network(
                          ride.coverPhotoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: colors.tintInfo,
                                alignment: Alignment.center,
                                child: Icon(
                                  Symbols.pedal_bike,
                                  size: 22,
                                  color: colors.colorBrand,
                                ),
                              ),
                        )
                      : Container(
                          color: colors.tintInfo,
                          alignment: Alignment.center,
                          child: Icon(
                            Symbols.pedal_bike,
                            size: 22,
                            color: colors.colorBrand,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  ride.name,
                  style: context.typography.title.copyWith(height: 1),
                ),
              ),
              Icon(Symbols.chevron_right, size: 20, color: colors.text700),
            ],
          ),
        ),
      ),
    );
  }
}
