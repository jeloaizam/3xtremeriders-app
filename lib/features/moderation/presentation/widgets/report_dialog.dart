import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../data/report_api.dart';

/// Reusable "Reportar" sheet — only wired up for `targetType == 'spot'`
/// this round (see the moderation plan), but takes `targetType`/`targetId`
/// generically since the backend's `/reports` endpoint already supports
/// comment/photo/video/event too.
class ReportDialog {
  static Future<void> show(
    BuildContext context, {
    required String targetType,
    required int targetId,
  }) async {
    final sent = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colors.surfaceCard,
      builder: (_) =>
          _ReportSheet(targetType: targetType, targetId: targetId),
    );
    if (sent == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).reportSent)),
      );
    }
  }
}

class _ReportSheet extends ConsumerStatefulWidget {
  const _ReportSheet({required this.targetType, required this.targetId});

  final String targetType;
  final int targetId;

  @override
  ConsumerState<_ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends ConsumerState<_ReportSheet> {
  final _detailsController = TextEditingController();
  String? _reason;
  bool _sending = false;

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  String _title(AppLocalizations l10n) => switch (widget.targetType) {
    'comment' => l10n.reportDialogTitleComment,
    'photo' => l10n.reportDialogTitlePhoto,
    'video' => l10n.reportDialogTitleVideo,
    _ => l10n.reportDialogTitle,
  };

  List<String> _reasons(AppLocalizations l10n) => [
    l10n.reportReasonSpam,
    l10n.reportReasonDangerous,
    l10n.reportReasonInaccurate,
    l10n.reportReasonOther,
  ];

  Future<void> _submit() async {
    if (_reason == null || _sending) return;
    setState(() => _sending = true);
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(reportApiProvider)
          .create(
            targetType: widget.targetType,
            targetId: widget.targetId,
            reason: _reason!,
            details: _detailsController.text.trim().isEmpty
                ? null
                : _detailsController.text.trim(),
            idToken: idToken,
          );
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final reasons = _reasons(l10n);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_title(l10n), style: context.typography.title),
            const SizedBox(height: 16),
            AppDropdown<String>(
              value: _reason,
              placeholder: l10n.reportReasonPlaceholder,
              items: [
                for (final reason in reasons)
                  DropdownMenuItem(value: reason, child: Text(reason)),
              ],
              onChanged: (value) => setState(() => _reason = value),
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _detailsController,
              placeholder: l10n.reportDetailsPlaceholder,
              multiline: true,
            ),
            const SizedBox(height: 16),
            AppButton(
              label: _sending ? l10n.reportSending : l10n.reportSubmit,
              onPressed: _reason == null || _sending ? null : _submit,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
