import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'core/ads/ad_consent.dart';
import 'core/locale/locale_provider.dart';
import 'core/map/mapbox_config.dart';
import 'core/startup/app_bootstrap.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Sends both fatal crashes and any error explicitly reported via
  // `FirebaseCrashlytics.instance.recordError(...)` to the Firebase console —
  // without this, a field-testing failure (e.g. a media upload error caught
  // and shown only as a transient SnackBar) leaves no trace anywhere once
  // the rider dismisses it.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await MobileAds.instance.initialize();
  await requestAdConsent();

  MapboxOptions.setAccessToken(mapboxAccessToken);
  final persistedLocale = await loadPersistedLocale();
  runApp(
    ProviderScope(
      overrides: [
        appLocaleProvider.overrideWith(
          () => _InitialAppLocale(persistedLocale),
        ),
      ],
      // `AppBootstrap` (`core/startup/`) gates on the min-version handshake
      // before ever building the real app (`XtremeRidersApp`, now in
      // `app.dart`) — see its doc comment for why that must happen before
      // the router/auth-dependent tree exists at all, not as a redirect.
      child: const AppBootstrap(),
    ),
  );
}

class _InitialAppLocale extends AppLocale {
  _InitialAppLocale(this._initial);

  final Locale? _initial;

  @override
  Locale? build() => _initial;
}
