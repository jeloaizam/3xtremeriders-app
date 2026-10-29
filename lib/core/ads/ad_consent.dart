import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Pide el consentimiento de ads vía UMP (User Messaging Platform) de
/// Google — obligatorio para cualquier app con AdMob, chequeado por Play
/// Console independientemente de si el rider está en EEA/UK o no. No
/// bloquea el arranque de la app si falla: solo lo intenta, en silencio.
Future<void> requestAdConsent() async {
  final params = ConsentRequestParameters();
  ConsentInformation.instance.requestConsentInfoUpdate(
    params,
    () => ConsentForm.loadAndShowConsentFormIfRequired((_) {}),
    (_) {},
  );
}
