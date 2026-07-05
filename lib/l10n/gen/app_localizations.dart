import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// Nombre de la app, usado en el título del sistema y splash
  ///
  /// In es, this message translates to:
  /// **'3xtreme Riders'**
  String get appTitle;

  /// Eyebrow tracked bajo el wordmark en la pantalla de login
  ///
  /// In es, this message translates to:
  /// **'ENCUENTRA · TIRA EL TRUCO · COMPARTE'**
  String get loginTagline;

  /// Frase descriptiva bajo el tagline en login
  ///
  /// In es, this message translates to:
  /// **'El mapa colaborativo de spots para deportistas extremos.'**
  String get loginSubtitle;

  /// No description provided for @loginEmailPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'tu@correo.com'**
  String get loginEmailPlaceholder;

  /// No description provided for @loginPasswordPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'••••••••'**
  String get loginPasswordPlaceholder;

  /// Texto del botón principal de acción en la pantalla de login (se muestra en mayúsculas vía el widget)
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get loginButton;

  /// No description provided for @loginDivider.
  ///
  /// In es, this message translates to:
  /// **'o continúa con'**
  String get loginDivider;

  /// No description provided for @loginSignupPrompt.
  ///
  /// In es, this message translates to:
  /// **'¿Nuevo por aquí?'**
  String get loginSignupPrompt;

  /// No description provided for @loginSignupCta.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get loginSignupCta;

  /// No description provided for @comingSoon.
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get comingSoon;

  /// Eyebrow bajo el wordmark en Home, cantidad de spots activos y ciudad
  ///
  /// In es, this message translates to:
  /// **'{count} SPOTS ACTIVOS · {city}'**
  String homeActiveSpots(int count, String city);

  /// No description provided for @homeSearchPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Buscar spots, riders…'**
  String get homeSearchPlaceholder;

  /// No description provided for @homeNearYou.
  ///
  /// In es, this message translates to:
  /// **'CERCA DE TI'**
  String get homeNearYou;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navSearch.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get navSearch;

  /// No description provided for @navMenu.
  ///
  /// In es, this message translates to:
  /// **'Menú'**
  String get navMenu;

  /// No description provided for @navRide.
  ///
  /// In es, this message translates to:
  /// **'Ride'**
  String get navRide;

  /// No description provided for @navEvents.
  ///
  /// In es, this message translates to:
  /// **'Eventos'**
  String get navEvents;

  /// No description provided for @navSettings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get navSettings;

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settingsTitle;

  /// No description provided for @settingsProfileSection.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get settingsProfileSection;

  /// No description provided for @settingsNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get settingsNameLabel;

  /// No description provided for @settingsLastNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Apellido'**
  String get settingsLastNameLabel;

  /// No description provided for @settingsNicknameLabel.
  ///
  /// In es, this message translates to:
  /// **'Apodo'**
  String get settingsNicknameLabel;

  /// No description provided for @settingsCityLabel.
  ///
  /// In es, this message translates to:
  /// **'Ciudad'**
  String get settingsCityLabel;

  /// No description provided for @settingsCountryLabel.
  ///
  /// In es, this message translates to:
  /// **'País'**
  String get settingsCountryLabel;

  /// No description provided for @settingsBioLabel.
  ///
  /// In es, this message translates to:
  /// **'Bio'**
  String get settingsBioLabel;

  /// No description provided for @settingsSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar cambios'**
  String get settingsSave;

  /// No description provided for @settingsSaved.
  ///
  /// In es, this message translates to:
  /// **'Perfil actualizado'**
  String get settingsSaved;

  /// No description provided for @settingsAccountSection.
  ///
  /// In es, this message translates to:
  /// **'Cuenta'**
  String get settingsAccountSection;

  /// No description provided for @settingsEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo'**
  String get settingsEmailLabel;

  /// No description provided for @settingsRoleLabel.
  ///
  /// In es, this message translates to:
  /// **'Rol'**
  String get settingsRoleLabel;

  /// No description provided for @settingsRoleUser.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get settingsRoleUser;

  /// No description provided for @settingsRoleModerator.
  ///
  /// In es, this message translates to:
  /// **'Moderador'**
  String get settingsRoleModerator;

  /// No description provided for @settingsRoleAdmin.
  ///
  /// In es, this message translates to:
  /// **'Administrador'**
  String get settingsRoleAdmin;

  /// No description provided for @settingsReputationLabel.
  ///
  /// In es, this message translates to:
  /// **'Reputación'**
  String get settingsReputationLabel;

  /// No description provided for @settingsLanguageSection.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get settingsLanguageSection;

  /// No description provided for @settingsFollowDevice.
  ///
  /// In es, this message translates to:
  /// **'Seguir idioma del dispositivo'**
  String get settingsFollowDevice;

  /// No description provided for @settingsLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get settingsLogout;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
