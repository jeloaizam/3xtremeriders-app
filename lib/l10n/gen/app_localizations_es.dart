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
  String get homeSheetViewSpot => 'VER SPOT';

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

  @override
  String get spotCreatedBy => 'Creado por';

  @override
  String get spotDifficulty => 'Dificultad';

  @override
  String spotRatingsCount(int count) {
    return '$count calificaciones';
  }

  @override
  String get spotSeason => 'Temporada';

  @override
  String get spotSchedule => 'HORARIOS';

  @override
  String get spotDescription => 'DESCRIPCIÓN';

  @override
  String spotElementsTitle(int count) {
    return 'ELEMENTOS · $count';
  }

  @override
  String get spotNoElements => 'Sin elementos reportados todavía';

  @override
  String spotHazardRatingsCount(int count) {
    return '$count calificaciones de peligro';
  }

  @override
  String spotHazardsTitle(int count) {
    return 'PELIGROS · $count';
  }

  @override
  String get spotNoHazards => 'Sin peligros reportados';

  @override
  String spotCommentsTitle(int count) {
    return 'COMENTARIOS · $count';
  }

  @override
  String get spotNoComments => 'Sin comentarios todavía';

  @override
  String get spotCommentPlaceholder => 'Escribe un comentario…';

  @override
  String get spotVote => 'VOTAR';

  @override
  String get spotNoMedia => 'Sin fotos todavía';

  @override
  String get spotNoVideos => 'Sin videos todavía';

  @override
  String get spotMediaVideoTab => 'VIDEO';

  @override
  String get spotMediaPhotoTab => 'FOTOS';

  @override
  String get spotMediaMore => 'MÁS';

  @override
  String get spotBack => 'Regresar';

  @override
  String get spotMediaLibraryTitle => 'GALERÍA COMPLETA';

  @override
  String get createSpotTitle => 'NUEVO SPOT';

  @override
  String get createSpotNameLabel => 'NOMBRE DEL SPOT';

  @override
  String get createSpotNamePlaceholder => 'Ej. Bowl del parque…';

  @override
  String get createSpotSportLabel => 'DEPORTE';

  @override
  String get createSpotLocationLabel => 'UBICACIÓN';

  @override
  String get createSpotUseCurrentLocation => 'USAR MI UBICACIÓN ACTUAL';

  @override
  String get createSpotLocationSet => 'Ubicación fijada ✓';

  @override
  String get createSpotLocationDenied =>
      'Necesitamos permiso de ubicación para fijar el spot';

  @override
  String get createSpotDifficultyLabel => 'DIFICULTAD · 1–5';

  @override
  String get createSpotSeasonLabel => 'TEMPORADA';

  @override
  String get createSpotElementsLabel => 'ELEMENTOS DEL SPOT';

  @override
  String get createSpotHazardsLabel => 'PELIGROS';

  @override
  String get createSpotAddHazard => 'Añadir peligro (grieta, tráfico, marea…)';

  @override
  String get createSpotHazardNamePlaceholder => 'Ej. Grieta en el borde norte';

  @override
  String get createSpotHazardSeverityLabel => 'GRAVEDAD · 1–5';

  @override
  String get createSpotDescriptionLabel => 'DESCRIPCIÓN';

  @override
  String get createSpotDescriptionPlaceholder =>
      'Describe el terreno, superficie, peligros…';

  @override
  String get createSpotMediaLabel => 'MULTIMEDIA';

  @override
  String get createSpotUseCamera => 'Tomar foto';

  @override
  String get createSpotUseGallery => 'Elegir de la galería';

  @override
  String get createSpotUploadPhoto => 'SUBIR FOTO';

  @override
  String get createSpotUploadVideo => 'SUBIR VIDEO';

  @override
  String get createSpotLinkVideo => 'ENLAZAR VIDEO';

  @override
  String get createSpotVideoUrlPlaceholder => 'https://youtube.com/…';

  @override
  String get searchTitle => 'BÚSQUEDA';

  @override
  String get searchPlaceholder => 'Nombre, zona o rider…';

  @override
  String get searchSportLabel => 'DEPORTE';

  @override
  String get searchDifficultyLabel => 'DIFICULTAD · 1–5';

  @override
  String get searchDistanceLabel => 'DISTANCIA';

  @override
  String searchDistanceValue(int km) {
    return '≤ $km KM';
  }

  @override
  String get searchSeasonLabel => 'MEJOR TEMPORADA';

  @override
  String get searchSeasonAll => 'TODO EL AÑO';

  @override
  String get searchSeasonDry => 'SECA (NOV–ABR)';

  @override
  String get searchSeasonRain => 'LLUVIAS';

  @override
  String get searchHazardLabel => 'NIVEL DE PELIGRO';

  @override
  String get searchHazardLow => 'BAJO';

  @override
  String get searchHazardMedium => 'MEDIO';

  @override
  String get searchHazardHigh => 'ALTO';

  @override
  String searchResultsCount(int count) {
    return 'RESULTADOS · $count';
  }

  @override
  String get searchNoResults => 'No encontramos resultados con esos filtros';

  @override
  String get searchTabSpots => 'SPOTS';

  @override
  String get searchTabRiders => 'RIDERS';

  @override
  String get searchTabEvents => 'EVENTOS';

  @override
  String get createSpotVideoTooLong =>
      'El video no puede durar más de 1:30 minutos';

  @override
  String get ridesTitle => 'MIS RIDES';

  @override
  String get ridesEmpty => 'Todavía no tienes rides';

  @override
  String get rideStateActive => 'ACTIVO';

  @override
  String get rideStateOnSale => 'EN VENTA';

  @override
  String get rideStateWasted => 'DAÑADO';

  @override
  String get rideStateToGift => 'PARA REGALAR';

  @override
  String get createRideTitle => 'NUEVO RIDE';

  @override
  String get createRideNameLabel => 'NOMBRE DEL RIDE';

  @override
  String get createRideNamePlaceholder => 'Ej. BMX Mongoose…';

  @override
  String get createRideStateLabel => 'ESTADO';

  @override
  String get createRideElementsLabel => 'ELEMENTOS';

  @override
  String get createRideAddElement => 'Agregar elemento';

  @override
  String get createRideElementNamePlaceholder => 'Ej. Pedales Odyssey…';

  @override
  String get createRideElementTypePlaceholder =>
      'Tipo (pedales, manubrio, sillín…)';

  @override
  String get createRidePublish => 'PUBLICAR RIDE';

  @override
  String get createRideNameRequired => 'El nombre es obligatorio';

  @override
  String get createRideConditionLabel => 'CONDICIÓN · 1–5';

  @override
  String get createRideConditionWorst => 'Muy dañado';

  @override
  String get createRideConditionBest => 'Como nuevo';

  @override
  String get createRidePhotoRequired => 'Agrega al menos una foto';

  @override
  String get createRideCoverHint => 'Toca una foto para elegirla como portada';

  @override
  String rideElementsTitle(int count) {
    return 'ELEMENTOS · $count';
  }

  @override
  String get rideNoElements => 'Sin elementos agregados todavía';

  @override
  String get createSpotPublish => 'PUBLICAR SPOT';

  @override
  String get createSpotNameRequired => 'El nombre es obligatorio';

  @override
  String get createSpotDescriptionRequired => 'La descripción es obligatoria';

  @override
  String get dialogCancel => 'Cancelar';

  @override
  String get dialogAdd => 'Agregar';

  @override
  String get drawerMyProfile => 'MI PERFIL (RIDER)';

  @override
  String get drawerMyRides => 'MIS RIDES';

  @override
  String get drawerEvents => 'EVENTOS';

  @override
  String get drawerCreateSpot => 'CREAR SPOT';

  @override
  String get drawerCreateEvent => 'CREAR EVENTO';

  @override
  String get drawerLogout => 'CERRAR SESIÓN';
}
