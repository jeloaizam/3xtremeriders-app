import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../settings/data/city_api.dart';
import '../../../settings/data/country_api.dart';
import '../../../settings/presentation/widgets/city_selector.dart';
import '../../application/auth_providers.dart';
import '../../domain/rider.dart';

/// Mandatory gate the router forces a rider into whenever their profile is
/// missing a nickname — in practice, a brand-new Google sign-in, since
/// email sign-up always collects these fields upfront in `SignupScreen`.
/// No back button, no skip: it's the only route reachable while
/// `needsProfileCompletionProvider` is true (see `app_router.dart`).
class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  ConsumerState<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _cityTextController = TextEditingController();
  int? _countryId;
  int? _cityId;
  bool _seeded = false;
  bool _saving = false;
  bool _showErrors = false;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _nicknameController.dispose();
    _cityTextController.dispose();
    super.dispose();
  }

  void _seed(Rider rider) {
    if (_seeded) return;
    _nameController.text = rider.name;
    _lastNameController.text = rider.lastName;
    _nicknameController.text = rider.nickname;
    _countryId = rider.countryId;
    _cityId = rider.cityId;
    _cityTextController.text = rider.cityText ?? '';
    _seeded = true;
  }

  bool get _isValid =>
      _nameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _nicknameController.text.trim().isNotEmpty &&
      _countryId != null &&
      (_cityId != null || _cityTextController.text.trim().isNotEmpty);

  Future<void> _save() async {
    setState(() => _showErrors = true);
    if (!_isValid || _saving) return;

    setState(() => _saving = true);
    try {
      // See SettingsScreen._save for why this re-checks the live catalog
      // instead of trusting `_cityId`/`_cityTextController` at face value.
      final countryId = _countryId;
      final cities = countryId == null
          ? null
          : ref.read(citiesProvider(countryId)).value;
      final usingCatalog = cities != null && cities.isNotEmpty;
      final cityText = _cityTextController.text.trim();

      await ref
          .read(currentRiderProvider.notifier)
          .updateProfile(
            name: _nameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            nickname: _nicknameController.text.trim(),
            countryId: _countryId,
            cityId: usingCatalog ? _cityId : null,
            cityText: usingCatalog
                ? null
                : (cityText.isEmpty ? null : cityText),
          );
      // The router bounces away from /complete-profile on its own once
      // needsProfileCompletionProvider flips to false.
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final riderAsync = ref.watch(currentRiderProvider);
    final countriesAsync = ref.watch(countriesProvider);

    return Scaffold(
      body: SafeArea(
        child: riderAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (rider) {
            if (rider == null) return const SizedBox.shrink();
            _seed(rider);

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              children: [
                Text(
                  l10n.completeProfileTitle,
                  style: context.typography.displaySm,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.completeProfileBody,
                  style: context.typography.body.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _nameController,
                  placeholder: l10n.settingsNameLabel,
                  icon: Symbols.badge,
                ),
                if (_showErrors && _nameController.text.trim().isEmpty)
                  _ErrorText(l10n.signupFieldRequired),
                const SizedBox(height: 11),
                AppTextField(
                  controller: _lastNameController,
                  placeholder: l10n.settingsLastNameLabel,
                  icon: Symbols.badge,
                ),
                if (_showErrors && _lastNameController.text.trim().isEmpty)
                  _ErrorText(l10n.signupFieldRequired),
                const SizedBox(height: 11),
                AppTextField(
                  controller: _nicknameController,
                  placeholder: l10n.settingsNicknameLabel,
                  icon: Symbols.alternate_email,
                ),
                if (_showErrors && _nicknameController.text.trim().isEmpty)
                  _ErrorText(l10n.signupFieldRequired),
                const SizedBox(height: 11),
                countriesAsync.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (error, _) => Text('$error'),
                  data: (countries) => AppDropdown<int>(
                    icon: Symbols.public,
                    placeholder: l10n.settingsCountryLabel,
                    value: _countryId,
                    extraVerticalPadding: 10,
                    items: [
                      for (final country in countries)
                        DropdownMenuItem(
                          value: country.id,
                          child: Text(country.name),
                        ),
                    ],
                    onChanged: (id) => setState(() {
                      _countryId = id;
                      _cityId = null;
                      _cityTextController.clear();
                    }),
                  ),
                ),
                if (_showErrors && _countryId == null)
                  _ErrorText(l10n.signupFieldRequired),
                const SizedBox(height: 11),
                CitySelector(
                  countryId: _countryId,
                  cityId: _cityId,
                  cityTextController: _cityTextController,
                  onCityIdChanged: (id) => setState(() => _cityId = id),
                ),
                if (_showErrors &&
                    _cityId == null &&
                    _cityTextController.text.trim().isEmpty)
                  _ErrorText(l10n.signupFieldRequired),
                const SizedBox(height: 24),
                AppButton(
                  label: _saving ? '…' : l10n.completeProfileSave,
                  onPressed: _saving ? null : _save,
                ),
              ],
            );
          },
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
