import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../sport_visuals.dart';

const elementTypeOptions = ['bowl', 'ramps', 'rail', 'stairs', 'jump'];

/// Quick "Agregar elemento" dialog (nombre + tipo + dificultad 1-5) for
/// `ElementsTab`'s crowd-sourced entry point — distinct from the toggle-chip
/// grid in Create/Edit Spot (one element per fixed type, owner-only), this
/// lets any rider add a free-named element and tag it with one of the same
/// types purely for the icon.
Future<({String name, String? type, int difficulty})?> showElementFormDialog(
  BuildContext context,
) {
  final l10n = AppLocalizations.of(context);
  final nameController = TextEditingController();
  String? type;
  var difficulty = 3;

  return showDialog<({String name, String? type, int difficulty})>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (dialogContext, setDialogState) => AlertDialog(
        backgroundColor: context.colors.surfaceCard,
        title: Text(l10n.spotElementsAddTitle, style: context.typography.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              controller: nameController,
              placeholder: l10n.spotElementsNamePlaceholder,
              maxLength: 100,
            ),
            const SizedBox(height: 14),
            Text(l10n.spotElementsTypeLabel, style: context.typography.meta),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in elementTypeOptions)
                  GestureDetector(
                    onTap: () => setDialogState(
                      () => type = type == option ? null : option,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: type == option
                            ? context.colors.colorAction
                            : context.colors.surfaceMedia,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        elementIcon(option),
                        size: 18,
                        color: type == option
                            ? context.colors.colorOnAction
                            : context.colors.text300,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 14),
            Text(l10n.createSpotDifficultyLabel, style: context.typography.meta),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () => setDialogState(() => difficulty = i),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: difficulty == i
                          ? context.colors.colorAction
                          : context.colors.surfaceMedia,
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: difficulty == i
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
              Navigator.of(
                dialogContext,
              ).pop((name: name, type: type, difficulty: difficulty));
            },
            child: Text(l10n.dialogAdd),
          ),
        ],
      ),
    ),
  );
}
