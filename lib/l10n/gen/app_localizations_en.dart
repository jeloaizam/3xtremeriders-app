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
  String get homeSheetViewSpot => 'VIEW SPOT';

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

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsProfileSection => 'Profile';

  @override
  String get settingsNameLabel => 'First name';

  @override
  String get settingsLastNameLabel => 'Last name';

  @override
  String get settingsNicknameLabel => 'Nickname';

  @override
  String get settingsCityLabel => 'City';

  @override
  String get settingsCountryLabel => 'Country';

  @override
  String get settingsBioLabel => 'Bio';

  @override
  String get settingsSave => 'Save changes';

  @override
  String get settingsSaved => 'Profile updated';

  @override
  String get settingsAccountSection => 'Account';

  @override
  String get settingsEmailLabel => 'Email';

  @override
  String get settingsRoleLabel => 'Role';

  @override
  String get settingsRoleUser => 'Rider';

  @override
  String get settingsRoleModerator => 'Moderator';

  @override
  String get settingsRoleAdmin => 'Admin';

  @override
  String get settingsReputationLabel => 'Reputation';

  @override
  String get settingsLanguageSection => 'Language';

  @override
  String get settingsFollowDevice => 'Follow device language';

  @override
  String get settingsLogout => 'Log out';

  @override
  String get spotCreatedBy => 'Created by';

  @override
  String get spotDifficulty => 'Difficulty';

  @override
  String spotRatingsCount(int count) {
    return '$count ratings';
  }

  @override
  String get spotSeason => 'Season';

  @override
  String get spotSchedule => 'SCHEDULE';

  @override
  String get spotDescription => 'DESCRIPTION';

  @override
  String spotElementsTitle(int count) {
    return 'ELEMENTS · $count';
  }

  @override
  String get spotNoElements => 'No elements reported yet';

  @override
  String spotHazardRatingsCount(int count) {
    return '$count hazard ratings';
  }

  @override
  String spotHazardsTitle(int count) {
    return 'HAZARDS · $count';
  }

  @override
  String get spotNoHazards => 'No hazards reported';

  @override
  String spotCommentsTitle(int count) {
    return 'COMMENTS · $count';
  }

  @override
  String get spotNoComments => 'No comments yet';

  @override
  String get spotCommentPlaceholder => 'Write a comment…';

  @override
  String get spotVote => 'VOTE';

  @override
  String get spotNoMedia => 'No photos yet';

  @override
  String get spotNoVideos => 'No videos yet';

  @override
  String get spotMediaVideoTab => 'VIDEO';

  @override
  String get spotMediaPhotoTab => 'PHOTOS';

  @override
  String get spotMediaMore => 'MORE';

  @override
  String get spotBack => 'Back';
}
