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

  /// No description provided for @signupTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Únete a la comunidad'**
  String get signupSubtitle;

  /// No description provided for @signupNamePlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get signupNamePlaceholder;

  /// No description provided for @signupLastNamePlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Apellido'**
  String get signupLastNamePlaceholder;

  /// No description provided for @signupNicknamePlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Nickname'**
  String get signupNicknamePlaceholder;

  /// No description provided for @signupFieldRequired.
  ///
  /// In es, this message translates to:
  /// **'Este campo es obligatorio'**
  String get signupFieldRequired;

  /// No description provided for @signupButton.
  ///
  /// In es, this message translates to:
  /// **'Registrarme'**
  String get signupButton;

  /// No description provided for @signupLoginPrompt.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta?'**
  String get signupLoginPrompt;

  /// No description provided for @signupLoginCta.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión'**
  String get signupLoginCta;

  /// No description provided for @completeProfileTitle.
  ///
  /// In es, this message translates to:
  /// **'COMPLETA TU PERFIL'**
  String get completeProfileTitle;

  /// No description provided for @completeProfileBody.
  ///
  /// In es, this message translates to:
  /// **'Nos falta un poco de información tuya para que puedas usar 3xtreme Riders — solo te toma un momento.'**
  String get completeProfileBody;

  /// No description provided for @completeProfileSave.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get completeProfileSave;

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

  /// No description provided for @homeNavCustomizeMap.
  ///
  /// In es, this message translates to:
  /// **'Mapa'**
  String get homeNavCustomizeMap;

  /// No description provided for @homeActiveSportPickerTitle.
  ///
  /// In es, this message translates to:
  /// **'Elige tu deporte activo'**
  String get homeActiveSportPickerTitle;

  /// No description provided for @homeActiveSportPickerHint.
  ///
  /// In es, this message translates to:
  /// **'Prioriza este deporte en tu mapa y precarga el picker al crear un spot'**
  String get homeActiveSportPickerHint;

  /// No description provided for @homeActiveSportPickerEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no tienes deportes favoritos — agrégalos desde Ajustes'**
  String get homeActiveSportPickerEmpty;

  /// No description provided for @homeMapFilterTitle.
  ///
  /// In es, this message translates to:
  /// **'Personalizar mapa'**
  String get homeMapFilterTitle;

  /// No description provided for @homeMapFilterHint.
  ///
  /// In es, this message translates to:
  /// **'Elige qué deportes se ven en tu mapa y en \"Cerca de ti\"'**
  String get homeMapFilterHint;

  /// No description provided for @homeMapFilterAll.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get homeMapFilterAll;

  /// No description provided for @homeMapFilterNone.
  ///
  /// In es, this message translates to:
  /// **'Ninguno'**
  String get homeMapFilterNone;

  /// No description provided for @homeSheetViewSpot.
  ///
  /// In es, this message translates to:
  /// **'VER SPOT'**
  String get homeSheetViewSpot;

  /// No description provided for @homeLocationGateTitle.
  ///
  /// In es, this message translates to:
  /// **'UBICACIÓN REQUERIDA'**
  String get homeLocationGateTitle;

  /// No description provided for @homeLocationGateServiceBody.
  ///
  /// In es, this message translates to:
  /// **'Activa el GPS de tu dispositivo para ver el mapa centrado en tu ubicación.'**
  String get homeLocationGateServiceBody;

  /// No description provided for @homeLocationGateEnableButton.
  ///
  /// In es, this message translates to:
  /// **'ACTIVAR UBICACIÓN'**
  String get homeLocationGateEnableButton;

  /// No description provided for @homeLocationGatePermissionBody.
  ///
  /// In es, this message translates to:
  /// **'3xtreme Riders necesita tu ubicación para mostrarte el mapa y los spots cerca de ti.'**
  String get homeLocationGatePermissionBody;

  /// No description provided for @homeLocationGateGrantButton.
  ///
  /// In es, this message translates to:
  /// **'DAR PERMISO'**
  String get homeLocationGateGrantButton;

  /// No description provided for @homeLocationGateDeniedForeverBody.
  ///
  /// In es, this message translates to:
  /// **'Diste permiso de ubicación \"nunca\". Actívalo desde los ajustes de la app para continuar.'**
  String get homeLocationGateDeniedForeverBody;

  /// No description provided for @homeLocationGateOpenSettingsButton.
  ///
  /// In es, this message translates to:
  /// **'ABRIR AJUSTES'**
  String get homeLocationGateOpenSettingsButton;

  /// No description provided for @homeLocationGateRetry.
  ///
  /// In es, this message translates to:
  /// **'REINTENTAR'**
  String get homeLocationGateRetry;

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

  /// No description provided for @settingsAvatarCamera.
  ///
  /// In es, this message translates to:
  /// **'Tomar foto'**
  String get settingsAvatarCamera;

  /// No description provided for @settingsAvatarGallery.
  ///
  /// In es, this message translates to:
  /// **'Elegir de la galería'**
  String get settingsAvatarGallery;

  /// No description provided for @settingsAvatarRemove.
  ///
  /// In es, this message translates to:
  /// **'Quitar foto'**
  String get settingsAvatarRemove;

  /// No description provided for @settingsAvatarReframe.
  ///
  /// In es, this message translates to:
  /// **'Reencuadrar foto'**
  String get settingsAvatarReframe;

  /// No description provided for @settingsAvatarCropTitle.
  ///
  /// In es, this message translates to:
  /// **'Ajustar foto'**
  String get settingsAvatarCropTitle;

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

  /// No description provided for @spotCreatedBy.
  ///
  /// In es, this message translates to:
  /// **'Creado por'**
  String get spotCreatedBy;

  /// No description provided for @spotDifficulty.
  ///
  /// In es, this message translates to:
  /// **'Dificultad'**
  String get spotDifficulty;

  /// Cantidad de calificaciones en estrellas de un spot
  ///
  /// In es, this message translates to:
  /// **'{count} calificaciones'**
  String spotRatingsCount(int count);

  /// No description provided for @spotSeason.
  ///
  /// In es, this message translates to:
  /// **'Temporada'**
  String get spotSeason;

  /// No description provided for @spotSchedule.
  ///
  /// In es, this message translates to:
  /// **'HORARIOS'**
  String get spotSchedule;

  /// No description provided for @spotDescription.
  ///
  /// In es, this message translates to:
  /// **'DESCRIPCIÓN'**
  String get spotDescription;

  /// Título de la sección de elementos del spot con la cantidad
  ///
  /// In es, this message translates to:
  /// **'ELEMENTOS · {count}'**
  String spotElementsTitle(int count);

  /// No description provided for @spotNoElements.
  ///
  /// In es, this message translates to:
  /// **'Sin elementos reportados todavía'**
  String get spotNoElements;

  /// Cantidad de calificaciones de peligro (muletas) de un spot
  ///
  /// In es, this message translates to:
  /// **'{count} calificaciones de peligro'**
  String spotHazardRatingsCount(int count);

  /// Título de la sección de peligros del spot con la cantidad
  ///
  /// In es, this message translates to:
  /// **'PELIGROS · {count}'**
  String spotHazardsTitle(int count);

  /// No description provided for @spotNoHazards.
  ///
  /// In es, this message translates to:
  /// **'Sin peligros reportados'**
  String get spotNoHazards;

  /// Título de la sección de comentarios con la cantidad
  ///
  /// In es, this message translates to:
  /// **'COMENTARIOS · {count}'**
  String spotCommentsTitle(int count);

  /// No description provided for @spotNoComments.
  ///
  /// In es, this message translates to:
  /// **'Sin comentarios todavía'**
  String get spotNoComments;

  /// No description provided for @spotCommentPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Escribe un comentario…'**
  String get spotCommentPlaceholder;

  /// No description provided for @spotVote.
  ///
  /// In es, this message translates to:
  /// **'VOTAR'**
  String get spotVote;

  /// No description provided for @spotNoMedia.
  ///
  /// In es, this message translates to:
  /// **'Sin fotos todavía'**
  String get spotNoMedia;

  /// No description provided for @spotNoVideos.
  ///
  /// In es, this message translates to:
  /// **'Sin videos todavía'**
  String get spotNoVideos;

  /// No description provided for @spotMediaVideoTab.
  ///
  /// In es, this message translates to:
  /// **'VIDEO'**
  String get spotMediaVideoTab;

  /// No description provided for @spotMediaPhotoTab.
  ///
  /// In es, this message translates to:
  /// **'FOTOS'**
  String get spotMediaPhotoTab;

  /// No description provided for @spotMediaMore.
  ///
  /// In es, this message translates to:
  /// **'MÁS'**
  String get spotMediaMore;

  /// No description provided for @spotBack.
  ///
  /// In es, this message translates to:
  /// **'Regresar'**
  String get spotBack;

  /// No description provided for @spotMediaLibraryTitle.
  ///
  /// In es, this message translates to:
  /// **'GALERÍA COMPLETA'**
  String get spotMediaLibraryTitle;

  /// No description provided for @spotMediaSportPickerTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Para cuál deporte es?'**
  String get spotMediaSportPickerTitle;

  /// No description provided for @createSpotTitle.
  ///
  /// In es, this message translates to:
  /// **'NUEVO SPOT'**
  String get createSpotTitle;

  /// No description provided for @createSpotNameLabel.
  ///
  /// In es, this message translates to:
  /// **'NOMBRE DEL SPOT'**
  String get createSpotNameLabel;

  /// No description provided for @createSpotNamePlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Ej. Bowl del parque…'**
  String get createSpotNamePlaceholder;

  /// No description provided for @createSpotSportLabel.
  ///
  /// In es, this message translates to:
  /// **'DEPORTE'**
  String get createSpotSportLabel;

  /// No description provided for @createSpotLocationLabel.
  ///
  /// In es, this message translates to:
  /// **'UBICACIÓN'**
  String get createSpotLocationLabel;

  /// No description provided for @createSpotUseCurrentLocation.
  ///
  /// In es, this message translates to:
  /// **'USAR MI UBICACIÓN ACTUAL'**
  String get createSpotUseCurrentLocation;

  /// No description provided for @createSpotLocationSet.
  ///
  /// In es, this message translates to:
  /// **'Ubicación fijada ✓'**
  String get createSpotLocationSet;

  /// No description provided for @createSpotLocationDenied.
  ///
  /// In es, this message translates to:
  /// **'Necesitamos permiso de ubicación para fijar el spot'**
  String get createSpotLocationDenied;

  /// No description provided for @createSpotDifficultyLabel.
  ///
  /// In es, this message translates to:
  /// **'DIFICULTAD · 1–5'**
  String get createSpotDifficultyLabel;

  /// No description provided for @createSpotSeasonLabel.
  ///
  /// In es, this message translates to:
  /// **'TEMPORADA'**
  String get createSpotSeasonLabel;

  /// No description provided for @createSpotElementsLabel.
  ///
  /// In es, this message translates to:
  /// **'ELEMENTOS DEL SPOT'**
  String get createSpotElementsLabel;

  /// No description provided for @createSpotHazardsLabel.
  ///
  /// In es, this message translates to:
  /// **'PELIGROS'**
  String get createSpotHazardsLabel;

  /// No description provided for @createSpotAddHazard.
  ///
  /// In es, this message translates to:
  /// **'Añadir peligro (grieta, tráfico, marea…)'**
  String get createSpotAddHazard;

  /// No description provided for @createSpotHazardNamePlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Ej. Grieta en el borde norte'**
  String get createSpotHazardNamePlaceholder;

  /// No description provided for @createSpotHazardSeverityLabel.
  ///
  /// In es, this message translates to:
  /// **'GRAVEDAD · 1–5'**
  String get createSpotHazardSeverityLabel;

  /// No description provided for @createSpotDescriptionLabel.
  ///
  /// In es, this message translates to:
  /// **'DESCRIPCIÓN'**
  String get createSpotDescriptionLabel;

  /// No description provided for @createSpotDescriptionPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Describe el terreno, superficie, peligros…'**
  String get createSpotDescriptionPlaceholder;

  /// No description provided for @createSpotMediaLabel.
  ///
  /// In es, this message translates to:
  /// **'MULTIMEDIA'**
  String get createSpotMediaLabel;

  /// No description provided for @createSpotUseCamera.
  ///
  /// In es, this message translates to:
  /// **'Tomar foto'**
  String get createSpotUseCamera;

  /// No description provided for @createSpotUseGallery.
  ///
  /// In es, this message translates to:
  /// **'Elegir de la galería'**
  String get createSpotUseGallery;

  /// No description provided for @createSpotUploadPhoto.
  ///
  /// In es, this message translates to:
  /// **'SUBIR FOTO'**
  String get createSpotUploadPhoto;

  /// No description provided for @createSpotUploadVideo.
  ///
  /// In es, this message translates to:
  /// **'SUBIR VIDEO'**
  String get createSpotUploadVideo;

  /// No description provided for @createSpotLinkVideo.
  ///
  /// In es, this message translates to:
  /// **'ENLAZAR VIDEO'**
  String get createSpotLinkVideo;

  /// No description provided for @createSpotVideoUrlPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'https://youtube.com/…'**
  String get createSpotVideoUrlPlaceholder;

  /// No description provided for @searchTitle.
  ///
  /// In es, this message translates to:
  /// **'BÚSQUEDA'**
  String get searchTitle;

  /// No description provided for @searchPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Nombre, zona o rider…'**
  String get searchPlaceholder;

  /// No description provided for @searchSportLabel.
  ///
  /// In es, this message translates to:
  /// **'DEPORTE'**
  String get searchSportLabel;

  /// No description provided for @searchDifficultyLabel.
  ///
  /// In es, this message translates to:
  /// **'DIFICULTAD · 1–5'**
  String get searchDifficultyLabel;

  /// No description provided for @searchDistanceLabel.
  ///
  /// In es, this message translates to:
  /// **'DISTANCIA'**
  String get searchDistanceLabel;

  /// Valor actual del slider de distancia en la búsqueda
  ///
  /// In es, this message translates to:
  /// **'≤ {km} KM'**
  String searchDistanceValue(int km);

  /// No description provided for @searchSeasonLabel.
  ///
  /// In es, this message translates to:
  /// **'MEJOR TEMPORADA'**
  String get searchSeasonLabel;

  /// No description provided for @searchSeasonAll.
  ///
  /// In es, this message translates to:
  /// **'TODO EL AÑO'**
  String get searchSeasonAll;

  /// No description provided for @searchSeasonDry.
  ///
  /// In es, this message translates to:
  /// **'SECA (NOV–ABR)'**
  String get searchSeasonDry;

  /// No description provided for @searchSeasonRain.
  ///
  /// In es, this message translates to:
  /// **'LLUVIAS'**
  String get searchSeasonRain;

  /// No description provided for @searchHazardLabel.
  ///
  /// In es, this message translates to:
  /// **'NIVEL DE PELIGRO'**
  String get searchHazardLabel;

  /// No description provided for @searchHazardLow.
  ///
  /// In es, this message translates to:
  /// **'BAJO'**
  String get searchHazardLow;

  /// No description provided for @searchHazardMedium.
  ///
  /// In es, this message translates to:
  /// **'MEDIO'**
  String get searchHazardMedium;

  /// No description provided for @searchHazardHigh.
  ///
  /// In es, this message translates to:
  /// **'ALTO'**
  String get searchHazardHigh;

  /// Cantidad de spots que arroja la búsqueda con los filtros actuales
  ///
  /// In es, this message translates to:
  /// **'RESULTADOS · {count}'**
  String searchResultsCount(int count);

  /// No description provided for @searchNoResults.
  ///
  /// In es, this message translates to:
  /// **'No encontramos resultados con esos filtros'**
  String get searchNoResults;

  /// No description provided for @searchTabSpots.
  ///
  /// In es, this message translates to:
  /// **'SPOTS'**
  String get searchTabSpots;

  /// No description provided for @searchTabRiders.
  ///
  /// In es, this message translates to:
  /// **'RIDERS'**
  String get searchTabRiders;

  /// No description provided for @searchTabEvents.
  ///
  /// In es, this message translates to:
  /// **'EVENTOS'**
  String get searchTabEvents;

  /// No description provided for @createSpotVideoTooLong.
  ///
  /// In es, this message translates to:
  /// **'El video no puede durar más de 1:30 minutos'**
  String get createSpotVideoTooLong;

  /// No description provided for @ridesTitle.
  ///
  /// In es, this message translates to:
  /// **'MIS RIDES'**
  String get ridesTitle;

  /// No description provided for @ridesEmpty.
  ///
  /// In es, this message translates to:
  /// **'Todavía no tienes rides'**
  String get ridesEmpty;

  /// No description provided for @rideStateActive.
  ///
  /// In es, this message translates to:
  /// **'ACTIVO'**
  String get rideStateActive;

  /// No description provided for @rideStateOnSale.
  ///
  /// In es, this message translates to:
  /// **'EN VENTA'**
  String get rideStateOnSale;

  /// No description provided for @rideStateWasted.
  ///
  /// In es, this message translates to:
  /// **'DAÑADO'**
  String get rideStateWasted;

  /// No description provided for @rideStateToGift.
  ///
  /// In es, this message translates to:
  /// **'PARA REGALAR'**
  String get rideStateToGift;

  /// No description provided for @createRideTitle.
  ///
  /// In es, this message translates to:
  /// **'NUEVO RIDE'**
  String get createRideTitle;

  /// No description provided for @createRideNameLabel.
  ///
  /// In es, this message translates to:
  /// **'NOMBRE DEL RIDE'**
  String get createRideNameLabel;

  /// No description provided for @createRideNamePlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Ej. BMX Mongoose…'**
  String get createRideNamePlaceholder;

  /// No description provided for @createRideStateLabel.
  ///
  /// In es, this message translates to:
  /// **'ESTADO'**
  String get createRideStateLabel;

  /// No description provided for @createRideElementsLabel.
  ///
  /// In es, this message translates to:
  /// **'ELEMENTOS'**
  String get createRideElementsLabel;

  /// No description provided for @createRideAddElement.
  ///
  /// In es, this message translates to:
  /// **'Agregar elemento'**
  String get createRideAddElement;

  /// No description provided for @createRideElementNamePlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Ej. Pedales Odyssey…'**
  String get createRideElementNamePlaceholder;

  /// No description provided for @createRideElementTypePlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Tipo (pedales, manubrio, sillín…)'**
  String get createRideElementTypePlaceholder;

  /// No description provided for @createRidePublish.
  ///
  /// In es, this message translates to:
  /// **'PUBLICAR RIDE'**
  String get createRidePublish;

  /// No description provided for @createRideNameRequired.
  ///
  /// In es, this message translates to:
  /// **'El nombre es obligatorio'**
  String get createRideNameRequired;

  /// No description provided for @createRideConditionLabel.
  ///
  /// In es, this message translates to:
  /// **'CONDICIÓN · 1–5'**
  String get createRideConditionLabel;

  /// No description provided for @createRideConditionWorst.
  ///
  /// In es, this message translates to:
  /// **'Muy dañado'**
  String get createRideConditionWorst;

  /// No description provided for @createRideConditionBest.
  ///
  /// In es, this message translates to:
  /// **'Como nuevo'**
  String get createRideConditionBest;

  /// No description provided for @createRidePhotoRequired.
  ///
  /// In es, this message translates to:
  /// **'Agrega al menos una foto'**
  String get createRidePhotoRequired;

  /// No description provided for @createRideCoverHint.
  ///
  /// In es, this message translates to:
  /// **'Toca una foto para elegirla como portada'**
  String get createRideCoverHint;

  /// Título de la sección de rides en el perfil de un rider
  ///
  /// In es, this message translates to:
  /// **'RIDES · {count}'**
  String riderProfileRidesTitle(int count);

  /// No description provided for @riderProfileNoRides.
  ///
  /// In es, this message translates to:
  /// **'Sin rides todavía'**
  String get riderProfileNoRides;

  /// No description provided for @riderProfileChangeRoleTitle.
  ///
  /// In es, this message translates to:
  /// **'CAMBIAR ROL'**
  String get riderProfileChangeRoleTitle;

  /// No description provided for @riderProfileChangeRoleConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Seguro que quieres cambiar el rol de este rider?'**
  String get riderProfileChangeRoleConfirm;

  /// No description provided for @eventsTitle.
  ///
  /// In es, this message translates to:
  /// **'EVENTOS'**
  String get eventsTitle;

  /// No description provided for @eventsCreate.
  ///
  /// In es, this message translates to:
  /// **'CREAR'**
  String get eventsCreate;

  /// No description provided for @eventsTabUpcoming.
  ///
  /// In es, this message translates to:
  /// **'PRÓXIMOS'**
  String get eventsTabUpcoming;

  /// No description provided for @eventsTabNearby.
  ///
  /// In es, this message translates to:
  /// **'CERCA'**
  String get eventsTabNearby;

  /// No description provided for @eventsTabGoing.
  ///
  /// In es, this message translates to:
  /// **'VOY'**
  String get eventsTabGoing;

  /// No description provided for @eventsEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay eventos por ahora'**
  String get eventsEmpty;

  /// No description provided for @eventStateActive.
  ///
  /// In es, this message translates to:
  /// **'ACTIVO'**
  String get eventStateActive;

  /// No description provided for @eventStateCancelled.
  ///
  /// In es, this message translates to:
  /// **'CANCELADO'**
  String get eventStateCancelled;

  /// No description provided for @eventStateHidden.
  ///
  /// In es, this message translates to:
  /// **'OCULTO'**
  String get eventStateHidden;

  /// No description provided for @eventOrganizedBy.
  ///
  /// In es, this message translates to:
  /// **'Organiza'**
  String get eventOrganizedBy;

  /// No description provided for @eventViewSpot.
  ///
  /// In es, this message translates to:
  /// **'Ver spot →'**
  String get eventViewSpot;

  /// No description provided for @eventAboutTitle.
  ///
  /// In es, this message translates to:
  /// **'SOBRE EL EVENTO'**
  String get eventAboutTitle;

  /// Título de la sección de asistentes con la cantidad
  ///
  /// In es, this message translates to:
  /// **'ASISTENTES · {count}'**
  String eventAttendeesTitle(int count);

  /// Cantidad de riders interesados (RSVP status=2) en un evento
  ///
  /// In es, this message translates to:
  /// **'{count} interesados'**
  String eventInterestedCount(int count);

  /// No description provided for @rsvpGoing.
  ///
  /// In es, this message translates to:
  /// **'VOY'**
  String get rsvpGoing;

  /// No description provided for @rsvpInterested.
  ///
  /// In es, this message translates to:
  /// **'ME INTERESA'**
  String get rsvpInterested;

  /// No description provided for @rsvpDeclined.
  ///
  /// In es, this message translates to:
  /// **'NO VOY'**
  String get rsvpDeclined;

  /// No description provided for @createEventTitle.
  ///
  /// In es, this message translates to:
  /// **'NUEVO EVENTO'**
  String get createEventTitle;

  /// No description provided for @createEventNameLabel.
  ///
  /// In es, this message translates to:
  /// **'NOMBRE DEL EVENTO'**
  String get createEventNameLabel;

  /// No description provided for @createEventNamePlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Ej. Jam de bowl…'**
  String get createEventNamePlaceholder;

  /// No description provided for @createEventStartLabel.
  ///
  /// In es, this message translates to:
  /// **'INICIA'**
  String get createEventStartLabel;

  /// No description provided for @createEventEndLabel.
  ///
  /// In es, this message translates to:
  /// **'TERMINA'**
  String get createEventEndLabel;

  /// No description provided for @createEventEndOptional.
  ///
  /// In es, this message translates to:
  /// **'Opcional'**
  String get createEventEndOptional;

  /// No description provided for @createEventLocationLabel.
  ///
  /// In es, this message translates to:
  /// **'UBICACIÓN'**
  String get createEventLocationLabel;

  /// No description provided for @createEventLocationExistingSpot.
  ///
  /// In es, this message translates to:
  /// **'SPOT EXISTENTE'**
  String get createEventLocationExistingSpot;

  /// No description provided for @createEventLocationOwnPoint.
  ///
  /// In es, this message translates to:
  /// **'PUNTO PROPIO'**
  String get createEventLocationOwnPoint;

  /// No description provided for @createEventPickSpot.
  ///
  /// In es, this message translates to:
  /// **'Elegir spot…'**
  String get createEventPickSpot;

  /// No description provided for @createEventSportsLabel.
  ///
  /// In es, this message translates to:
  /// **'DEPORTES'**
  String get createEventSportsLabel;

  /// No description provided for @createEventDescriptionPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Categorías, premios, qué traer…'**
  String get createEventDescriptionPlaceholder;

  /// No description provided for @createEventPublish.
  ///
  /// In es, this message translates to:
  /// **'PUBLICAR EVENTO'**
  String get createEventPublish;

  /// No description provided for @createEventNameRequired.
  ///
  /// In es, this message translates to:
  /// **'El nombre es obligatorio'**
  String get createEventNameRequired;

  /// No description provided for @createEventStartRequired.
  ///
  /// In es, this message translates to:
  /// **'La fecha de inicio es obligatoria'**
  String get createEventStartRequired;

  /// No description provided for @createEventLocationRequired.
  ///
  /// In es, this message translates to:
  /// **'Selecciona una ubicación'**
  String get createEventLocationRequired;

  /// Título de la sección de elementos del ride con la cantidad
  ///
  /// In es, this message translates to:
  /// **'ELEMENTOS · {count}'**
  String rideElementsTitle(int count);

  /// No description provided for @rideNoElements.
  ///
  /// In es, this message translates to:
  /// **'Sin elementos agregados todavía'**
  String get rideNoElements;

  /// No description provided for @createSpotPublish.
  ///
  /// In es, this message translates to:
  /// **'PUBLICAR SPOT'**
  String get createSpotPublish;

  /// No description provided for @createSpotNameRequired.
  ///
  /// In es, this message translates to:
  /// **'El nombre es obligatorio'**
  String get createSpotNameRequired;

  /// No description provided for @createSpotDescriptionRequired.
  ///
  /// In es, this message translates to:
  /// **'La descripción es obligatoria'**
  String get createSpotDescriptionRequired;

  /// No description provided for @createSpotSportRequired.
  ///
  /// In es, this message translates to:
  /// **'Elige al menos un deporte'**
  String get createSpotSportRequired;

  /// No description provided for @dialogCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get dialogCancel;

  /// No description provided for @dialogAdd.
  ///
  /// In es, this message translates to:
  /// **'Agregar'**
  String get dialogAdd;

  /// No description provided for @drawerMyProfile.
  ///
  /// In es, this message translates to:
  /// **'MI PERFIL (RIDER)'**
  String get drawerMyProfile;

  /// No description provided for @drawerMyRides.
  ///
  /// In es, this message translates to:
  /// **'MIS RIDES'**
  String get drawerMyRides;

  /// No description provided for @drawerEvents.
  ///
  /// In es, this message translates to:
  /// **'EVENTOS'**
  String get drawerEvents;

  /// No description provided for @drawerCreateSpot.
  ///
  /// In es, this message translates to:
  /// **'CREAR SPOT'**
  String get drawerCreateSpot;

  /// No description provided for @drawerCreateEvent.
  ///
  /// In es, this message translates to:
  /// **'CREAR EVENTO'**
  String get drawerCreateEvent;

  /// No description provided for @drawerLogout.
  ///
  /// In es, this message translates to:
  /// **'CERRAR SESIÓN'**
  String get drawerLogout;

  /// No description provided for @settingsFavoriteSportsSection.
  ///
  /// In es, this message translates to:
  /// **'Deportes favoritos'**
  String get settingsFavoriteSportsSection;

  /// No description provided for @settingsFavoriteSportsHint.
  ///
  /// In es, this message translates to:
  /// **'Elige hasta 10 — el primero que elijas personaliza el menú de abajo'**
  String get settingsFavoriteSportsHint;

  /// No description provided for @settingsFavoriteSportsMax.
  ///
  /// In es, this message translates to:
  /// **'Ya tienes 10 deportes favoritos, quita uno para agregar otro'**
  String get settingsFavoriteSportsMax;

  /// No description provided for @settingsFavoriteSportsAdd.
  ///
  /// In es, this message translates to:
  /// **'Agregar'**
  String get settingsFavoriteSportsAdd;

  /// No description provided for @settingsFavoriteSportsPickerTitle.
  ///
  /// In es, this message translates to:
  /// **'Elige tu deporte'**
  String get settingsFavoriteSportsPickerTitle;

  /// No description provided for @settingsFavoriteSportsPickerHint.
  ///
  /// In es, this message translates to:
  /// **'Toca un ícono para agregarlo a tus favoritos'**
  String get settingsFavoriteSportsPickerHint;

  /// No description provided for @settingsFavoriteSportsLocked.
  ///
  /// In es, this message translates to:
  /// **'No puedes quitar este deporte: tienes spots publicados con él'**
  String get settingsFavoriteSportsLocked;

  /// No description provided for @navSport.
  ///
  /// In es, this message translates to:
  /// **'Deportes'**
  String get navSport;

  /// No description provided for @searchTabSports.
  ///
  /// In es, this message translates to:
  /// **'DEPORTES'**
  String get searchTabSports;

  /// No description provided for @sportRankingSection.
  ///
  /// In es, this message translates to:
  /// **'RANKING'**
  String get sportRankingSection;

  /// No description provided for @sportTopRidersLabel.
  ///
  /// In es, this message translates to:
  /// **'Top riders'**
  String get sportTopRidersLabel;

  /// No description provided for @sportNoRidersYet.
  ///
  /// In es, this message translates to:
  /// **'Todavía nadie tiene este deporte como favorito'**
  String get sportNoRidersYet;

  /// No description provided for @sportTopSpotsLabel.
  ///
  /// In es, this message translates to:
  /// **'Top spots'**
  String get sportTopSpotsLabel;

  /// No description provided for @sportNoSpotsYet.
  ///
  /// In es, this message translates to:
  /// **'Todavía no hay spots calificados para este deporte'**
  String get sportNoSpotsYet;

  /// No description provided for @sportEventsSection.
  ///
  /// In es, this message translates to:
  /// **'EVENTOS'**
  String get sportEventsSection;

  /// No description provided for @sportUpcomingEventsLabel.
  ///
  /// In es, this message translates to:
  /// **'Próximos'**
  String get sportUpcomingEventsLabel;

  /// No description provided for @sportPastEventsLabel.
  ///
  /// In es, this message translates to:
  /// **'Anteriores'**
  String get sportPastEventsLabel;

  /// No description provided for @sportNoEventsYet.
  ///
  /// In es, this message translates to:
  /// **'No hay eventos de este deporte todavía'**
  String get sportNoEventsYet;

  /// No description provided for @sportTopMediaSection.
  ///
  /// In es, this message translates to:
  /// **'MÁS VOTADOS'**
  String get sportTopMediaSection;

  /// No description provided for @sportTopPhotosLabel.
  ///
  /// In es, this message translates to:
  /// **'Fotos'**
  String get sportTopPhotosLabel;

  /// No description provided for @sportTopVideosLabel.
  ///
  /// In es, this message translates to:
  /// **'Videos'**
  String get sportTopVideosLabel;

  /// No description provided for @sportNoMediaYet.
  ///
  /// In es, this message translates to:
  /// **'Todavía no hay contenido votado para este deporte'**
  String get sportNoMediaYet;

  /// No description provided for @rideEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar ride'**
  String get rideEdit;

  /// No description provided for @rideEditElement.
  ///
  /// In es, this message translates to:
  /// **'Editar elemento'**
  String get rideEditElement;

  /// No description provided for @rideDelete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar ride'**
  String get rideDelete;

  /// No description provided for @rideDeleteConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar este ride?'**
  String get rideDeleteConfirmTitle;

  /// No description provided for @rideDeleteConfirmBody.
  ///
  /// In es, this message translates to:
  /// **'Esta acción no se puede deshacer. El ride se eliminará junto con sus elementos.'**
  String get rideDeleteConfirmBody;
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
