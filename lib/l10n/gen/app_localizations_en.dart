// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => '3xtreme Riders';

  @override
  String get loginTagline => 'FIND · LAND THE TRICK · SHARE';

  @override
  String get loginSubtitle =>
      'The collaborative spot map for extreme athletes.';

  @override
  String get loginEmailPlaceholder => 'you@email.com';

  @override
  String get loginPasswordPlaceholder => '••••••••';

  @override
  String get loginButton => 'Log in';

  @override
  String get loginDivider => 'or continue with';

  @override
  String get loginSignupPrompt => 'New here?';

  @override
  String get loginSignupCta => 'Create account';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String homeActiveSpots(int count, String city) {
    return '$count ACTIVE SPOTS · $city';
  }

  @override
  String get homeSearchPlaceholder => 'Search spots, riders…';

  @override
  String get homeNearYou => 'NEAR YOU';

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Search';

  @override
  String get navMenu => 'Menu';

  @override
  String get navRide => 'Ride';

  @override
  String get navEvents => 'Events';

  @override
  String get navSettings => 'Settings';
}
