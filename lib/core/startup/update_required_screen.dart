import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/gen/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';

const _playStoreId = 'com.terpenoestudios.xtremeriders';

/// Full-screen, non-dismissible "your app is too old" state — shown by
/// `AppBootstrap` instead of the real app when `GET /version`'s
/// `min_app_version` is above the installed version. No retry button: there
/// is nothing to retry, only to update. Same visual language as
/// `ServerUnreachableScreen`/the Home location gate.
class UpdateRequiredScreen extends StatelessWidget {
  const UpdateRequiredScreen({super.key});

  Future<void> _openStore() async {
    final marketUri = Uri.parse('market://details?id=$_playStoreId');
    if (await launchUrl(marketUri, mode: LaunchMode.externalApplication)) {
      return;
    }
    final webUri = Uri.parse(
      'https://play.google.com/store/apps/details?id=$_playStoreId',
    );
    await launchUrl(webUri, mode: LaunchMode.externalApplication);
  }

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
              Icon(Symbols.system_update, size: 56, color: colors.colorBrand),
              const SizedBox(height: 18),
              Text(
                l10n.startupUpdateRequiredTitle,
                style: context.typography.displaySm,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                l10n.startupUpdateRequiredBody,
                style: context.typography.bodySm.copyWith(
                  color: colors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AppButton(
                label: l10n.startupUpdateRequiredButton,
                onPressed: _openStore,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
