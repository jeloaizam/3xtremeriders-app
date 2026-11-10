import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';

/// Shared "Añadir/editar peligro" dialog (nombre + severidad 1-5) — used by
/// `EditSpotScreen` (dueño del spot) and `HazardsTab`'s quick-add "+" (ahora
/// abierto a cualquier rider autenticado).
Future<({String name, int severity})?> showHazardFormDialog(
  BuildContext context, {
  String? existingName,
  int existingSeverity = 3,
}) {
  final l10n = AppLocalizations.of(context);
  final nameController = TextEditingController(text: existingName ?? '');
  var severity = existingSeverity;

  return showDialog<({String name, int severity})>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (dialogContext, setDialogState) => AlertDialog(
        backgroundColor: context.colors.surfaceCard,
        title: Text(l10n.createSpotAddHazard, style: context.typography.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              controller: nameController,
              placeholder: l10n.createSpotHazardNamePlaceholder,
              maxLength: 100,
            ),
            const SizedBox(height: 14),
            Text(l10n.createSpotHazardSeverityLabel, style: context.typography.meta),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () => setDialogState(() => severity = i),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: severity == i
                          ? context.colors.colorAction
                          : context.colors.surfaceMedia,
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: severity == i
                              ? context.colors.colorOnAction
                              : context.colors.text300,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.dialogCancel),
          ),
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isEmpty) return;
              Navigator.of(dialogContext).pop((name: name, severity: severity));
            },
            child: Text(existingName == null ? l10n.dialogAdd : l10n.settingsSave),
          ),
        ],
      ),
    ),
  );
}
