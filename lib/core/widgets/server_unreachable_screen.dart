import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../l10n/gen/app_localizations.dart';
import '../theme/app_theme.dart';
import 'app_button.dart';

/// Full-screen, non-dismissible "can't reach the backend" state. Originally
/// private to `HomeScreen` (shown when `nearbySpotsProvider` fails); made
/// public so the app-startup version gate (`AppBootstrap`) can show the same
/// message/style when the min-version handshake itself can't be reached —
/// same `homeServerError*` l10n strings either way.
class ServerUnreachableScreen extends StatelessWidget {
  const ServerUnreachableScreen({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: colors.surfaceApp,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Symbols.cloud_off, size: 56, color: colors.colorDanger),
              const SizedBox(height: 18),
              Text(
                l10n.homeServerErrorTitle,
                style: context.typography.displaySm,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                l10n.homeServerErrorBody,
                style: context.typography.bodySm.copyWith(
                  color: colors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AppButton(label: l10n.homeServerErrorRetry, onPressed: onRetry),
            ],
          ),
        ),
      ),
    );
  }
}
