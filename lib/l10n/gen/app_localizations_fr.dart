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
  String get homeSheetViewSpot => 'VOIR LE SPOT';

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
}
