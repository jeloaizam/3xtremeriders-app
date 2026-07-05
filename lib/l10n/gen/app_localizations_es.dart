// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => '3xtreme Riders';

  @override
  String get loginTagline => 'ENCUENTRA · TIRA EL TRUCO · COMPARTE';

  @override
  String get loginSubtitle =>
      'El mapa colaborativo de spots para deportistas extremos.';

  @override
  String get loginEmailPlaceholder => 'tu@correo.com';

  @override
  String get loginPasswordPlaceholder => '••••••••';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get loginDivider => 'o continúa con';

  @override
  String get loginSignupPrompt => '¿Nuevo por aquí?';

  @override
  String get loginSignupCta => 'Crear cuenta';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String homeActiveSpots(int count, String city) {
    return '$count SPOTS ACTIVOS · $city';
  }

  @override
  String get homeSearchPlaceholder => 'Buscar spots, riders…';

  @override
  String get homeNearYou => 'CERCA DE TI';

  @override
  String get navHome => 'Inicio';

  @override
  String get navSearch => 'Buscar';

  @override
  String get navMenu => 'Menú';

  @override
  String get navRide => 'Ride';

  @override
  String get navEvents => 'Eventos';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsProfileSection => 'Perfil';

  @override
  String get settingsNameLabel => 'Nombre';

  @override
  String get settingsLastNameLabel => 'Apellido';

  @override
  String get settingsNicknameLabel => 'Apodo';

  @override
  String get settingsCityLabel => 'Ciudad';

  @override
  String get settingsCountryLabel => 'País';

  @override
  String get settingsBioLabel => 'Bio';

  @override
  String get settingsSave => 'Guardar cambios';

  @override
  String get settingsSaved => 'Perfil actualizado';

  @override
  String get settingsAccountSection => 'Cuenta';

  @override
  String get settingsEmailLabel => 'Correo';

  @override
  String get settingsRoleLabel => 'Rol';

  @override
  String get settingsRoleUser => 'Usuario';

  @override
  String get settingsRoleModerator => 'Moderador';

  @override
  String get settingsRoleAdmin => 'Administrador';

  @override
  String get settingsReputationLabel => 'Reputación';

  @override
  String get settingsLanguageSection => 'Idioma';

  @override
  String get settingsFollowDevice => 'Seguir idioma del dispositivo';

  @override
  String get settingsLogout => 'Cerrar sesión';
}
