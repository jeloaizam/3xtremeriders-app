import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/locale/locale_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_segmented_control.dart';
import '../../../../core/widgets/app_switch.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/data/auth_repository.dart';
import '../../../auth/domain/rider.dart';
import '../../data/country_api.dart';

/// No dedicated design file exists for Settings in the source project —
/// built from the same core components (SegmentedControl, Switch,
/// TextField, Button) used elsewhere, driven by the real Rider fields the
/// backend's `RiderUpdate` schema supports.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _cityController = TextEditingController();
  final _bioController = TextEditingController();

  int? _countryId;
  bool _seeded = false;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _nicknameController.dispose();
    _cityController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _seedControllers(Rider rider) {
    if (_seeded) return;
    _nameController.text = rider.name;
    _lastNameController.text = rider.lastName;
    _nicknameController.text = rider.nickname;
    _cityController.text = rider.city ?? '';
    _bioController.text = rider.bio ?? '';
    _countryId = rider.countryId;
    _seeded = true;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(currentRiderProvider.notifier)
          .updateProfile(
            name: _nameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            nickname: _nicknameController.text.trim(),
            city: _cityController.text.trim(),
            bio: _bioController.text.trim(),
            countryId: _countryId,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).settingsSaved)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String _roleLabel(AppLocalizations l10n, int roleId) {
    return switch (roleId) {
      3 => l10n.settingsRoleAdmin,
      2 => l10n.settingsRoleModerator,
      _ => l10n.settingsRoleUser,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final riderAsync = ref.watch(currentRiderProvider);
    final countriesAsync = ref.watch(countriesProvider);
    final appLocale = ref.watch(appLocaleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle, style: context.typography.displaySm),
      ),
      body: riderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (rider) {
          if (rider == null) return const SizedBox.shrink();
          _seedControllers(rider);

          return SafeArea(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                20 + MediaQuery.of(context).padding.bottom,
              ),
              children: [
              _SectionTitle(l10n.settingsProfileSection),
              const SizedBox(height: 12),
              AppTextField(
                controller: _nameController,
                placeholder: l10n.settingsNameLabel,
                icon: Symbols.badge,
              ),
              const SizedBox(height: 11),
              AppTextField(
                controller: _lastNameController,
                placeholder: l10n.settingsLastNameLabel,
                icon: Symbols.badge,
              ),
              const SizedBox(height: 11),
              AppTextField(
                controller: _nicknameController,
                placeholder: l10n.settingsNicknameLabel,
                icon: Symbols.alternate_email,
              ),
              const SizedBox(height: 11),
              AppTextField(
                controller: _cityController,
                placeholder: l10n.settingsCityLabel,
                icon: Symbols.location_city,
              ),
              const SizedBox(height: 11),
              countriesAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (error, _) => Text('$error'),
                data: (countries) => AppDropdown<int>(
                  icon: Symbols.public,
                  placeholder: l10n.settingsCountryLabel,
                  value: _countryId,
                  items: [
                    for (final country in countries)
                      DropdownMenuItem(
                        value: country.id,
                        child: Text(country.name),
                      ),
                  ],
                  onChanged: (id) => setState(() => _countryId = id),
                ),
              ),
              const SizedBox(height: 11),
              AppTextField(
                controller: _bioController,
                placeholder: l10n.settingsBioLabel,
                icon: Symbols.edit_note,
                multiline: true,
              ),
              const SizedBox(height: 16),
              AppButton(
                label: l10n.settingsSave,
                onPressed: _saving ? null : _save,
              ),

              const SizedBox(height: 32),
              _SectionTitle(l10n.settingsAccountSection),
              const SizedBox(height: 12),
              _InfoRow(label: l10n.settingsEmailLabel, value: rider.email),
              _InfoRow(
                label: l10n.settingsRoleLabel,
                value: _roleLabel(l10n, rider.roleId),
              ),
              _InfoRow(
                label: l10n.settingsReputationLabel,
                value: '${rider.reputationPts}',
              ),

              const SizedBox(height: 32),
              _SectionTitle(l10n.settingsLanguageSection),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      l10n.settingsFollowDevice,
                      style: context.typography.body,
                    ),
                  ),
                  AppSwitch(
                    checked: appLocale == null,
                    onChanged: (followDevice) {
                      final notifier = ref.read(appLocaleProvider.notifier);
                      if (followDevice) {
                        notifier.setLocale(null);
                      } else {
                        notifier.setLocale(Localizations.localeOf(context));
                      }
                    },
                  ),
                ],
              ),
              if (appLocale != null) ...[
                const SizedBox(height: 12),
                AppSegmentedControl<String>(
                  segments: const [
                    AppSegment(value: 'es', label: 'ES'),
                    AppSegment(value: 'en', label: 'EN'),
                    AppSegment(value: 'fr', label: 'FR'),
                  ],
                  value: appLocale.languageCode,
                  onChanged: (code) =>
                      ref.read(appLocaleProvider.notifier).setLocale(Locale(code)),
                ),
              ],

              const SizedBox(height: 32),
              AppButton(
                label: l10n.settingsLogout,
                variant: AppButtonVariant.danger,
                onPressed: () => ref.read(authRepositoryProvider).signOut(),
              ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: context.typography.eyebrow.copyWith(color: context.colors.text300),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.typography.body.copyWith(color: colors.textMuted)),
          Text(value, style: context.typography.body),
        ],
      ),
    );
  }
}
