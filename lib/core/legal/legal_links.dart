import '../network/api_config.dart';

/// URLs and version constants for the legal documents served as static HTML
/// by the backend (`app/static/legal/*.html`, mounted at `/legal`).
///
/// `currentTermsVersion`/`currentPrivacyVersion` must match
/// `backend/app/core/legal.py`'s `CURRENT_TERMS_VERSION`/
/// `CURRENT_PRIVACY_VERSION` exactly — there's no automated sync between the
/// two repos, so bumping one requires manually bumping the other.
class LegalLinks {
  LegalLinks._();

  static String get termsUrl => '${ApiConfig.baseUrl}/legal/terms.html';
  static String get privacyUrl => '${ApiConfig.baseUrl}/legal/privacy.html';
  static String get refundUrl => '${ApiConfig.baseUrl}/legal/refund.html';

  static const currentTermsVersion = '2026-10-22';
  static const currentPrivacyVersion = '2026-10-22';
}
