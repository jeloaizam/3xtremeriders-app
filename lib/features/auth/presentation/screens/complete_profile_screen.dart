import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/legal/legal_links.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../application/auth_providers.dart';
import '../../domain/rider.dart';
import '../widgets/consent_fields.dart';
import '../widgets/country_city_selector.dart';
import '../widgets/gender_selector.dart';

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
  int? _countryId;
  String? _cityName;
  String? _gender;
  // True if the rider already had a gender saved when this screen loaded
  // (they only landed here because something *else* was missing, e.g.
  // nickname) — locks the buttons instead of letting them tap a different
  // one, since the backend would reject the change anyway.
  bool _genderLocked = false;
  bool _seeded = false;
  bool _saving = false;
  bool _showErrors = false;

  // True when this rider never backfilled birth_date/consent — the only
  // case where this screen shows ConsentFields and logs acceptance.
  // Riders who already have a birth_date (e.g. only missing nickname) skip
  // this section entirely, since they accepted it already.
  bool _needsConsent = false;
  DateTime? _birthDate;
  bool _termsAccepted = false;
  bool _privacyAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _seed(Rider rider) {
    if (_seeded) return;
    _nameController.text = rider.name;
    _lastNameController.text = rider.lastName;
    _nicknameController.text = rider.nickname;
    _countryId = rider.countryId;
    _cityName = rider.cityName;
    _gender = rider.gender;
    _genderLocked = rider.gender != null;
    _needsConsent = rider.birthDate == null;
    _seeded = true;
  }

  bool get _isValid =>
      _nameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _nicknameController.text.trim().isNotEmpty &&
      _countryId != null &&
      _cityName != null &&
      _gender != null &&
      (!_needsConsent ||
          (_birthDate != null &&
              ConsentFields.meetsMinimumAge(_birthDate!) &&
              _termsAccepted &&
              _privacyAccepted));

  Future<void> _save() async {
    setState(() => _showErrors = true);
    if (!_isValid || _saving) return;

    setState(() => _saving = true);
    try {
      await ref
          .read(currentRiderProvider.notifier)
          .updateProfile(
            name: _nameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            nickname: _nicknameController.text.trim(),
            countryId: _countryId,
            cityName: _cityName,
            gender: _gender,
            birthDate: _needsConsent ? _birthDate : null,
          );
      if (_needsConsent) {
        await ref
            .read(currentRiderProvider.notifier)
            .acceptConsent(
              termsVersion: LegalLinks.currentTermsVersion,
              privacyVersion: LegalLinks.currentPrivacyVersion,
              deviceInfo:
                  '${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
            );
      }
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
                  maxLength: 50,
                ),
                if (_showErrors && _nameController.text.trim().isEmpty)
                  _ErrorText(l10n.signupFieldRequired),
                const SizedBox(height: 11),
                AppTextField(
                  controller: _lastNameController,
                  placeholder: l10n.settingsLastNameLabel,
                  icon: Symbols.badge,
                  maxLength: 50,
                ),
                if (_showErrors && _lastNameController.text.trim().isEmpty)
                  _ErrorText(l10n.signupFieldRequired),
                const SizedBox(height: 11),
                AppTextField(
                  controller: _nicknameController,
                  placeholder: l10n.settingsNicknameLabel,
                  icon: Symbols.alternate_email,
                  maxLength: 50,
                ),
                if (_showErrors && _nicknameController.text.trim().isEmpty)
                  _ErrorText(l10n.signupFieldRequired),
                const SizedBox(height: 11),
                CountryCitySelector(
                  countryId: _countryId,
                  cityName: _cityName,
                  onCountryChanged: (id) => setState(() {
                    _countryId = id;
                    _cityName = null;
                  }),
                  onCityChanged: (name) => setState(() => _cityName = name),
                  showErrors: _showErrors,
                ),
                const SizedBox(height: 20),
                GenderSelector(
                  value: _gender,
                  locked: _genderLocked,
                  onChanged: (gender) => setState(() => _gender = gender),
                  showError: _showErrors,
                ),
                if (_needsConsent) ...[
                  const SizedBox(height: 20),
                  ConsentFields(
                    birthDate: _birthDate,
                    onBirthDateChanged: (date) =>
                        setState(() => _birthDate = date),
                    termsAccepted: _termsAccepted,
                    onTermsAcceptedChanged: (value) =>
                        setState(() => _termsAccepted = value),
                    privacyAccepted: _privacyAccepted,
                    onPrivacyAcceptedChanged: (value) =>
                        setState(() => _privacyAccepted = value),
                    showErrors: _showErrors,
                  ),
                ],
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
