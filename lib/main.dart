import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'core/locale/locale_provider.dart';
import 'core/map/mapbox_config.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'l10n/gen/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MapboxOptions.setAccessToken(mapboxAccessToken);
  final persistedLocale = await loadPersistedLocale();
  runApp(
    ProviderScope(
      overrides: [
        appLocaleProvider.overrideWith(() => _InitialAppLocale(persistedLocale)),
      ],
      child: const XtremeRidersApp(),
    ),
  );
}

class _InitialAppLocale extends AppLocale {
  _InitialAppLocale(this._initial);

  final Locale? _initial;

  @override
  Locale? build() => _initial;
}

class XtremeRidersApp extends ConsumerWidget {
  const XtremeRidersApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(appLocaleProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.dark,
      routerConfig: router,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
