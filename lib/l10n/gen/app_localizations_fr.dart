// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => '3xtreme Riders';

  @override
  String get loginTagline => 'TROUVE · RÉUSSIS LA FIGURE · PARTAGE';

  @override
  String get loginSubtitle =>
      'La carte collaborative des spots pour sportifs extrêmes.';

  @override
  String get loginEmailPlaceholder => 'toi@email.com';

  @override
  String get loginPasswordPlaceholder => '••••••••';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get loginDivider => 'ou continuer avec';

  @override
  String get loginSignupPrompt => 'Nouveau ici ?';

  @override
  String get loginSignupCta => 'Créer un compte';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String homeActiveSpots(int count, String city) {
    return '$count SPOTS ACTIFS · $city';
  }

  @override
  String get homeSearchPlaceholder => 'Chercher spots, riders…';

  @override
  String get homeNearYou => 'PRÈS DE TOI';

  @override
  String get navHome => 'Accueil';

  @override
  String get navSearch => 'Recherche';

  @override
  String get navMenu => 'Menu';

  @override
  String get navRide => 'Ride';

  @override
  String get navEvents => 'Événements';

  @override
  String get navSettings => 'Paramètres';
}
