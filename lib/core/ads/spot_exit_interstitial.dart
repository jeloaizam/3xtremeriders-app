import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _spotsSeenPrefKey = 'ads_spots_seen_since_interstitial';
// Tunable: cada cuántos spots vistos se muestra el interstitial — más alto
// que 1 a propósito, para que no sea invasivo.
const _spotsPerInterstitial = 3;

/// Interstitial mostrado al salir de `SpotScreen` (botón "←" o back del
/// sistema, ver `spot_screen.dart`) — no en cada salida, solo cada
/// [_spotsPerInterstitial] spots vistos. Nunca bloquea la navegación: si el
/// ad no llegó a cargar a tiempo, el rider sale igual sin ver nada.
class SpotExitInterstitial {
  InterstitialAd? _ad;

  void preload() {
    InterstitialAd.load(
      adUnitId: const String.fromEnvironment('ADMOB_INTERSTITIAL_UNIT_ID'),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _ad = ad,
        onAdFailedToLoad: (_) => _ad = null,
      ),
    );
  }

  Future<void> showIfReady({required VoidCallback onComplete}) async {
    final isSpotNumber3 = await _bumpCounterAndCheck();
    final ad = _ad;
    if (!isSpotNumber3 || ad == null) {
      onComplete();
      // Le tocaba pero no había ad listo: no perder el ciclo, reintentar
      // cargar para que la próxima vez sí esté a tiempo.
      if (isSpotNumber3) preload();
      return;
    }

    _ad = null;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        onComplete();
        preload();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        onComplete();
        preload();
      },
    );
    await ad.show();
  }

  Future<bool> _bumpCounterAndCheck() async {
    final prefs = await SharedPreferences.getInstance();
    final count = (prefs.getInt(_spotsSeenPrefKey) ?? 0) + 1;
    if (count >= _spotsPerInterstitial) {
      await prefs.setInt(_spotsSeenPrefKey, 0);
      return true;
    }
    await prefs.setInt(_spotsSeenPrefKey, count);
    return false;
  }
}

final spotExitInterstitial = SpotExitInterstitial();
