import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/legal/legal_links.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_checkbox.dart';
import '../../../../l10n/gen/app_localizations.dart';

/// Minimum age to use 3xtreme Riders — self-declared, Meta/Instagram-style
/// (no real verification), enforced client-side before Firebase account
/// creation ever happens. See the plan doc for the Ley 1581/2012 rationale.
const minimumAge = 13;

/// Shared birthdate picker + Terms/Privacy checkboxes, used by both
/// `SignupScreen` (new email sign-ups) and `CompleteProfileScreen` (Google
/// sign-ups and legacy riders backfilling). The caller owns all state —
/// this widget is purely presentational plus the date-picker dialog and the
/// external-link launches.
class ConsentFields extends StatelessWidget {
  const ConsentFields({
    super.key,
    required this.birthDate,
    required this.onBirthDateChanged,
    required this.termsAccepted,
    required this.onTermsAcceptedChanged,
    required this.privacyAccepted,
    required this.onPrivacyAcceptedChanged,
    required this.showErrors,
  });

  final DateTime? birthDate;
  final ValueChanged<DateTime?> onBirthDateChanged;
  final bool termsAccepted;
  final ValueChanged<bool> onTermsAcceptedChanged;
  final bool privacyAccepted;
  final ValueChanged<bool> onPrivacyAcceptedChanged;

  /// Mirrors each screen's own `_showErrors` — only paint error text once
  /// the caller has attempted to submit.
  final bool showErrors;

  static bool meetsMinimumAge(DateTime birthDate) {
    final now = DateTime.now();
    var age = now.year - birthDate.year;
    final hasHadBirthdayThisYear =
        now.month > birthDate.month ||
        (now.month == birthDate.month && now.day >= birthDate.day);
    if (!hasHadBirthdayThisYear) age -= 1;
    return age >= minimumAge;
  }

  Future<void> _pickBirthDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: birthDate ?? DateTime(now.year - minimumAge, now.month, now.day),
      firstDate: DateTime(now.year - 100),
      lastDate: now,
    );
    if (picked != null) onBirthDateChanged(picked);
  }

  Future<void> _openLink(String url) {
    return launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final underAge = birthDate != null && !meetsMinimumAge(birthDate!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => _pickBirthDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: colors.surfaceCard,
              border: Border.all(color: colors.hairlineStrong),
              borderRadius: BorderRadius.circular(context.spacing.radiusMd),
            ),
            child: Row(
              children: [
                Icon(Symbols.calendar_month, size: 20, color: colors.textMuted),
                const SizedBox(width: 10),
                Text(
                  birthDate == null
                      ? l10n.consentBirthDatePlaceholder
                      : DateFormat('dd/MM/yyyy').format(birthDate!),
                  style: context.typography.body.copyWith(
                    color: birthDate == null ? colors.textMuted : colors.text100,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showErrors && birthDate == null) _ErrorText(l10n.signupFieldRequired),
        if (showErrors && underAge) _ErrorText(l10n.consentAgeError),
        const SizedBox(height: 14),
        _ConsentCheckboxRow(
          checked: termsAccepted,
          onChanged: onTermsAcceptedChanged,
          prefix: l10n.consentTermsPrefix,
          linkText: l10n.consentTermsLink,
          onLinkTap: () => _openLink(LegalLinks.termsUrl),
        ),
        if (showErrors && !termsAccepted) _ErrorText(l10n.signupFieldRequired),
        const SizedBox(height: 10),
        _ConsentCheckboxRow(
          checked: privacyAccepted,
          onChanged: onPrivacyAcceptedChanged,
          prefix: l10n.consentPrivacyPrefix,
          linkText: l10n.consentPrivacyLink,
          onLinkTap: () => _openLink(LegalLinks.privacyUrl),
        ),
        if (showErrors && !privacyAccepted) _ErrorText(l10n.signupFieldRequired),
      ],
    );
  }
}

class _ConsentCheckboxRow extends StatefulWidget {
  const _ConsentCheckboxRow({
    required this.checked,
    required this.onChanged,
    required this.prefix,
    required this.linkText,
    required this.onLinkTap,
  });

  final bool checked;
  final ValueChanged<bool> onChanged;
  final String prefix;
  final String linkText;
  final VoidCallback onLinkTap;

  @override
  State<_ConsentCheckboxRow> createState() => _ConsentCheckboxRowState();
}

class _ConsentCheckboxRowState extends State<_ConsentCheckboxRow> {
  late final TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = widget.onLinkTap;
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCheckbox(
          checked: widget.checked,
          onChanged: (value) => widget.onChanged(value),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: RichText(
              text: TextSpan(
                style: context.typography.bodySm.copyWith(color: colors.textMuted),
                children: [
                  TextSpan(text: widget.prefix),
                  TextSpan(
                    text: widget.linkText,
                    style: TextStyle(
                      color: colors.colorAction,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: _recognizer,
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
