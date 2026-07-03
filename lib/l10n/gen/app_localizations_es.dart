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
  String get homeTitle => 'INICIO';

  @override
  String get homeWelcome => 'Bienvenido a 3xtreme Riders';

  @override
  String get navHome => 'Inicio';

  @override
  String get navSearch => 'Buscar';

  @override
  String get navEvents => 'Eventos';

  @override
  String get navSettings => 'Ajustes';
}
