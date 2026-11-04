import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/locale/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/gen/app_localizations.dart';

/// The real app — built only once [AppBootstrap] (`core/startup/`) confirms
/// the installed version satisfies the backend's `min_app_version`. Moved
/// out of `main.dart` so `AppBootstrap` can reference it without a circular
/// import.
class XtremeRidersApp extends ConsumerWidget {
  const XtremeRidersApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(appLocaleProvider);

    // PopScope(canPop: false) + a manual pop below the system's default
    // `WidgetsBinding.handlePopRoute()` is needed because that default
    // handler races GoRouter's async redirect/pop resolution: on a slow or
    // mid-flight redirect (e.g. `refreshListenable` firing from a provider
    // refresh at the same moment), Flutter can see "not handled yet" and
    // fall through to `SystemNavigator.pop()` — closing the Activity — even
    // though GoRouter's own pop completes correctly a moment later (bug:
    // system back from Settings closed the app instead of returning to
    // Home). Driving `router.pop()` directly here is synchronous and never
    // loses that race.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (router.canPop()) {
          router.pop();
        } else {
          SystemNavigator.pop();
        }
      },
      child: MaterialApp.router(
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        theme: AppTheme.dark,
        routerConfig: router,
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) {
          if (!MediaQuery.of(context).disableAnimations) return child!;
          return Theme(
            data: Theme.of(context).copyWith(
              pageTransitionsTheme: AppTheme.reducedMotionPageTransitions,
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
