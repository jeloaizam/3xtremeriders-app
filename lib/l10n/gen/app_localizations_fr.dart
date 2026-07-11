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
  String get signupTitle => 'Créer un compte';

  @override
  String get signupSubtitle => 'Rejoins la communauté';

  @override
  String get signupNamePlaceholder => 'Prénom';

  @override
  String get signupLastNamePlaceholder => 'Nom de famille';

  @override
  String get signupNicknamePlaceholder => 'Pseudo';

  @override
  String get signupFieldRequired => 'Ce champ est obligatoire';

  @override
  String get signupButton => 'S\'inscrire';

  @override
  String get signupLoginPrompt => 'Tu as déjà un compte ?';

  @override
  String get signupLoginCta => 'Connecte-toi';

  @override
  String get completeProfileTitle => 'COMPLÈTE TON PROFIL';

  @override
  String get completeProfileBody =>
      'Il nous manque un peu d\'informations avant que tu puisses utiliser 3xtreme Riders — ça ne prend qu\'un instant.';

  @override
  String get completeProfileSave => 'Continuer';

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
  String get homeSheetViewSpot => 'VOIR LE SPOT';

  @override
  String get homeLocationGateTitle => 'LOCALISATION REQUISE';

  @override
  String get homeLocationGateServiceBody =>
      'Active le GPS de ton appareil pour voir la carte centrée sur ta position.';

  @override
  String get homeLocationGateEnableButton => 'ACTIVER LA LOCALISATION';

  @override
  String get homeLocationGatePermissionBody =>
      '3xtreme Riders a besoin de ta position pour t\'afficher la carte et les spots près de toi.';

  @override
  String get homeLocationGateGrantButton => 'AUTORISER';

  @override
  String get homeLocationGateDeniedForeverBody =>
      'Tu as réglé l\'autorisation de localisation sur \"jamais\". Active-la depuis les paramètres de l\'application pour continuer.';

  @override
  String get homeLocationGateOpenSettingsButton => 'OUVRIR LES PARAMÈTRES';

  @override
  String get homeLocationGateRetry => 'RÉESSAYER';

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

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsProfileSection => 'Profil';

  @override
  String get settingsNameLabel => 'Prénom';

  @override
  String get settingsLastNameLabel => 'Nom';

  @override
  String get settingsNicknameLabel => 'Surnom';

  @override
  String get settingsCityLabel => 'Ville';

  @override
  String get settingsCountryLabel => 'Pays';

  @override
  String get settingsBioLabel => 'Bio';

  @override
  String get settingsSave => 'Enregistrer';

  @override
  String get settingsSaved => 'Profil mis à jour';

  @override
  String get settingsAccountSection => 'Compte';

  @override
  String get settingsEmailLabel => 'E-mail';

  @override
  String get settingsRoleLabel => 'Rôle';

  @override
  String get settingsRoleUser => 'Rider';

  @override
  String get settingsRoleModerator => 'Modérateur';

  @override
  String get settingsRoleAdmin => 'Admin';

  @override
  String get settingsReputationLabel => 'Réputation';

  @override
  String get settingsLanguageSection => 'Langue';

  @override
  String get settingsFollowDevice => 'Suivre la langue de l\'appareil';

  @override
  String get settingsLogout => 'Déconnexion';

  @override
  String get spotCreatedBy => 'Créé par';

  @override
  String get spotDifficulty => 'Difficulté';

  @override
  String spotRatingsCount(int count) {
    return '$count notes';
  }

  @override
  String get spotSeason => 'Saison';

  @override
  String get spotSchedule => 'HORAIRES';

  @override
  String get spotDescription => 'DESCRIPTION';

  @override
  String spotElementsTitle(int count) {
    return 'ÉLÉMENTS · $count';
  }

  @override
  String get spotNoElements => 'Aucun élément signalé pour l\'instant';

  @override
  String spotHazardRatingsCount(int count) {
    return '$count notes de danger';
  }

  @override
  String spotHazardsTitle(int count) {
    return 'DANGERS · $count';
  }

  @override
  String get spotNoHazards => 'Aucun danger signalé';

  @override
  String spotCommentsTitle(int count) {
    return 'COMMENTAIRES · $count';
  }

  @override
  String get spotNoComments => 'Aucun commentaire pour l\'instant';

  @override
  String get spotCommentPlaceholder => 'Écris un commentaire…';

  @override
  String get spotVote => 'VOTER';

  @override
  String get spotNoMedia => 'Aucune photo pour l\'instant';

  @override
  String get spotNoVideos => 'Aucune vidéo pour l\'instant';

  @override
  String get spotMediaVideoTab => 'VIDÉO';

  @override
  String get spotMediaPhotoTab => 'PHOTOS';

  @override
  String get spotMediaMore => 'PLUS';

  @override
  String get spotBack => 'Retour';

  @override
  String get spotMediaLibraryTitle => 'GALERIE COMPLÈTE';

  @override
  String get createSpotTitle => 'NOUVEAU SPOT';

  @override
  String get createSpotNameLabel => 'NOM DU SPOT';

  @override
  String get createSpotNamePlaceholder => 'Ex. Bowl du parc…';

  @override
  String get createSpotSportLabel => 'SPORT';

  @override
  String get createSpotLocationLabel => 'EMPLACEMENT';

  @override
  String get createSpotUseCurrentLocation => 'UTILISER MA POSITION ACTUELLE';

  @override
  String get createSpotLocationSet => 'Position définie ✓';

  @override
  String get createSpotLocationDenied =>
      'Nous avons besoin de la permission de localisation pour définir le spot';

  @override
  String get createSpotDifficultyLabel => 'DIFFICULTÉ · 1–5';

  @override
  String get createSpotSeasonLabel => 'SAISON';

  @override
  String get createSpotElementsLabel => 'ÉLÉMENTS DU SPOT';

  @override
  String get createSpotHazardsLabel => 'DANGERS';

  @override
  String get createSpotAddHazard =>
      'Ajouter un danger (fissure, circulation, marée…)';

  @override
  String get createSpotHazardNamePlaceholder => 'Ex. Fissure sur le bord nord';

  @override
  String get createSpotHazardSeverityLabel => 'GRAVITÉ · 1–5';

  @override
  String get createSpotDescriptionLabel => 'DESCRIPTION';

  @override
  String get createSpotDescriptionPlaceholder =>
      'Décris le terrain, la surface, les dangers…';

  @override
  String get createSpotMediaLabel => 'MÉDIAS';

  @override
  String get createSpotUseCamera => 'Prendre une photo';

  @override
  String get createSpotUseGallery => 'Choisir dans la galerie';

  @override
  String get createSpotUploadPhoto => 'AJOUTER PHOTO';

  @override
  String get createSpotUploadVideo => 'AJOUTER VIDÉO';

  @override
  String get createSpotLinkVideo => 'LIER VIDÉO';

  @override
  String get createSpotVideoUrlPlaceholder => 'https://youtube.com/…';

  @override
  String get searchTitle => 'RECHERCHE';

  @override
  String get searchPlaceholder => 'Nom, zone ou rider…';

  @override
  String get searchSportLabel => 'SPORT';

  @override
  String get searchDifficultyLabel => 'DIFFICULTÉ · 1–5';

  @override
  String get searchDistanceLabel => 'DISTANCE';

  @override
  String searchDistanceValue(int km) {
    return '≤ $km KM';
  }

  @override
  String get searchSeasonLabel => 'MEILLEURE SAISON';

  @override
  String get searchSeasonAll => 'TOUTE L\'ANNÉE';

  @override
  String get searchSeasonDry => 'SÈCHE (NOV–AVR)';

  @override
  String get searchSeasonRain => 'PLUIES';

  @override
  String get searchHazardLabel => 'NIVEAU DE DANGER';

  @override
  String get searchHazardLow => 'FAIBLE';

  @override
  String get searchHazardMedium => 'MOYEN';

  @override
  String get searchHazardHigh => 'ÉLEVÉ';

  @override
  String searchResultsCount(int count) {
    return 'RÉSULTATS · $count';
  }

  @override
  String get searchNoResults => 'Aucun résultat ne correspond à ces filtres';

  @override
  String get searchTabSpots => 'SPOTS';

  @override
  String get searchTabRiders => 'RIDERS';

  @override
  String get searchTabEvents => 'ÉVÉNEMENTS';

  @override
  String get createSpotVideoTooLong => 'La vidéo ne peut pas dépasser 1 min 30';

  @override
  String get ridesTitle => 'MES RIDES';

  @override
  String get ridesEmpty => 'Tu n\'as pas encore de ride';

  @override
  String get rideStateActive => 'ACTIF';

  @override
  String get rideStateOnSale => 'EN VENTE';

  @override
  String get rideStateWasted => 'ENDOMMAGÉ';

  @override
  String get rideStateToGift => 'À DONNER';

  @override
  String get createRideTitle => 'NOUVEAU RIDE';

  @override
  String get createRideNameLabel => 'NOM DU RIDE';

  @override
  String get createRideNamePlaceholder => 'Ex. BMX Mongoose…';

  @override
  String get createRideStateLabel => 'STATUT';

  @override
  String get createRideElementsLabel => 'ÉLÉMENTS';

  @override
  String get createRideAddElement => 'Ajouter un élément';

  @override
  String get createRideElementNamePlaceholder => 'Ex. Pédales Odyssey…';

  @override
  String get createRideElementTypePlaceholder =>
      'Type (pédales, guidon, selle…)';

  @override
  String get createRidePublish => 'PUBLIER LE RIDE';

  @override
  String get createRideNameRequired => 'Le nom est obligatoire';

  @override
  String get createRideConditionLabel => 'ÉTAT · 1–5';

  @override
  String get createRideConditionWorst => 'Très abîmé';

  @override
  String get createRideConditionBest => 'Comme neuf';

  @override
  String get createRidePhotoRequired => 'Ajoute au moins une photo';

  @override
  String get createRideCoverHint =>
      'Touche une photo pour la définir comme couverture';

  @override
  String riderProfileRidesTitle(int count) {
    return 'RIDES · $count';
  }

  @override
  String get riderProfileNoRides => 'Aucun ride pour l\'instant';

  @override
  String get riderProfileChangeRoleTitle => 'CHANGER LE RÔLE';

  @override
  String get riderProfileChangeRoleConfirm =>
      'Es-tu sûr de vouloir changer le rôle de ce rider ?';

  @override
  String get eventsTitle => 'ÉVÉNEMENTS';

  @override
  String get eventsCreate => 'CRÉER';

  @override
  String get eventsTabUpcoming => 'À VENIR';

  @override
  String get eventsTabNearby => 'PROCHES';

  @override
  String get eventsTabGoing => 'J\'Y VAIS';

  @override
  String get eventsEmpty => 'Aucun événement pour l\'instant';

  @override
  String get eventStateActive => 'ACTIF';

  @override
  String get eventStateCancelled => 'ANNULÉ';

  @override
  String get eventStateHidden => 'MASQUÉ';

  @override
  String get eventOrganizedBy => 'Organisé par';

  @override
  String get eventViewSpot => 'Voir le spot →';

  @override
  String get eventAboutTitle => 'À PROPOS DE L\'ÉVÉNEMENT';

  @override
  String eventAttendeesTitle(int count) {
    return 'PARTICIPANTS · $count';
  }

  @override
  String eventInterestedCount(int count) {
    return '$count intéressés';
  }

  @override
  String get rsvpGoing => 'J\'Y VAIS';

  @override
  String get rsvpInterested => 'ÇA M\'INTÉRESSE';

  @override
  String get rsvpDeclined => 'PAS PARTANT';

  @override
  String get createEventTitle => 'NOUVEL ÉVÉNEMENT';

  @override
  String get createEventNameLabel => 'NOM DE L\'ÉVÉNEMENT';

  @override
  String get createEventNamePlaceholder => 'Ex. Jam de bowl…';

  @override
  String get createEventStartLabel => 'DÉBUT';

  @override
  String get createEventEndLabel => 'FIN';

  @override
  String get createEventEndOptional => 'Facultatif';

  @override
  String get createEventLocationLabel => 'LIEU';

  @override
  String get createEventLocationExistingSpot => 'SPOT EXISTANT';

  @override
  String get createEventLocationOwnPoint => 'POINT LIBRE';

  @override
  String get createEventPickSpot => 'Choisir un spot…';

  @override
  String get createEventSportsLabel => 'SPORTS';

  @override
  String get createEventDescriptionPlaceholder =>
      'Catégories, prix, quoi apporter…';

  @override
  String get createEventPublish => 'PUBLIER L\'ÉVÉNEMENT';

  @override
  String get createEventNameRequired => 'Le nom est obligatoire';

  @override
  String get createEventStartRequired => 'La date de début est obligatoire';

  @override
  String get createEventLocationRequired => 'Sélectionne un lieu';

  @override
  String rideElementsTitle(int count) {
    return 'ÉLÉMENTS · $count';
  }

  @override
  String get rideNoElements => 'Aucun élément ajouté pour l\'instant';

  @override
  String get createSpotPublish => 'PUBLIER LE SPOT';

  @override
  String get createSpotNameRequired => 'Le nom est obligatoire';

  @override
  String get createSpotDescriptionRequired => 'La description est obligatoire';

  @override
  String get dialogCancel => 'Annuler';

  @override
  String get dialogAdd => 'Ajouter';

  @override
  String get drawerMyProfile => 'MON PROFIL (RIDER)';

  @override
  String get drawerMyRides => 'MES RIDES';

  @override
  String get drawerEvents => 'ÉVÉNEMENTS';

  @override
  String get drawerCreateSpot => 'CRÉER UN SPOT';

  @override
  String get drawerCreateEvent => 'CRÉER UN ÉVÉNEMENT';

  @override
  String get drawerLogout => 'DÉCONNEXION';

  @override
  String get settingsFavoriteSportsSection => 'Sports favoris';

  @override
  String get settingsFavoriteSportsHint =>
      'Choisis jusqu\'à 10 — le premier que tu choisis personnalise le menu du bas';

  @override
  String get settingsFavoriteSportsMax =>
      'Tu as déjà 10 sports favoris, enlève-en un pour en ajouter un autre';

  @override
  String get navSport => 'Sports';

  @override
  String get searchTabSports => 'SPORTS';

  @override
  String get sportRankingSection => 'CLASSEMENT';

  @override
  String get sportTopRidersLabel => 'Meilleurs riders';

  @override
  String get sportNoRidersYet => 'Personne n\'a encore ce sport en favori';

  @override
  String get sportTopSpotsLabel => 'Meilleurs spots';

  @override
  String get sportNoSpotsYet => 'Pas encore de spots notés pour ce sport';

  @override
  String get sportEventsSection => 'ÉVÉNEMENTS';

  @override
  String get sportUpcomingEventsLabel => 'À venir';

  @override
  String get sportPastEventsLabel => 'Passés';

  @override
  String get sportNoEventsYet => 'Pas encore d\'événements pour ce sport';

  @override
  String get sportTopMediaSection => 'LES PLUS VOTÉS';

  @override
  String get sportTopPhotosLabel => 'Photos';

  @override
  String get sportTopVideosLabel => 'Vidéos';

  @override
  String get sportNoMediaYet => 'Pas encore de contenu voté pour ce sport';

  @override
  String get rideEdit => 'Modifier le ride';

  @override
  String get rideEditElement => 'Modifier l\'élément';

  @override
  String get rideDelete => 'Supprimer le ride';

  @override
  String get rideDeleteConfirmTitle => 'Supprimer ce ride ?';

  @override
  String get rideDeleteConfirmBody =>
      'Cette action est irréversible. Le ride sera supprimé avec ses éléments.';
}
