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
  String get signupTitle => 'Create account';

  @override
  String get signupSubtitle => 'Join the community';

  @override
  String get signupNamePlaceholder => 'First name';

  @override
  String get signupLastNamePlaceholder => 'Last name';

  @override
  String get signupNicknamePlaceholder => 'Nickname';

  @override
  String get signupFieldRequired => 'This field is required';

  @override
  String get signupButton => 'Sign up';

  @override
  String get signupLoginPrompt => 'Already have an account?';

  @override
  String get signupLoginCta => 'Log in';

  @override
  String get completeProfileTitle => 'COMPLETE YOUR PROFILE';

  @override
  String get completeProfileBody =>
      'We just need a bit more info from you before you can use 3xtreme Riders — it only takes a moment.';

  @override
  String get completeProfileSave => 'Continue';

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
  String get homeLocationGateTitle => 'LOCATION REQUIRED';

  @override
  String get homeLocationGateServiceBody =>
      'Turn on your device\'s GPS to see the map centered on your location.';

  @override
  String get homeLocationGateEnableButton => 'ENABLE LOCATION';

  @override
  String get homeLocationGatePermissionBody =>
      '3xtreme Riders needs your location to show you the map and spots near you.';

  @override
  String get homeLocationGateGrantButton => 'GRANT PERMISSION';

  @override
  String get homeLocationGateDeniedForeverBody =>
      'You set location permission to \"never\". Enable it from the app settings to continue.';

  @override
  String get homeLocationGateOpenSettingsButton => 'OPEN SETTINGS';

  @override
  String get homeLocationGateRetry => 'RETRY';

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
  String get settingsAvatarCamera => 'Take photo';

  @override
  String get settingsAvatarGallery => 'Choose from gallery';

  @override
  String get settingsAvatarRemove => 'Remove photo';

  @override
  String get settingsAvatarReframe => 'Reframe photo';

  @override
  String get settingsAvatarCropTitle => 'Adjust photo';

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

  @override
  String get spotMediaLibraryTitle => 'FULL GALLERY';

  @override
  String get createSpotTitle => 'NEW SPOT';

  @override
  String get createSpotNameLabel => 'SPOT NAME';

  @override
  String get createSpotNamePlaceholder => 'E.g. Park bowl…';

  @override
  String get createSpotSportLabel => 'SPORT';

  @override
  String get createSpotLocationLabel => 'LOCATION';

  @override
  String get createSpotUseCurrentLocation => 'USE MY CURRENT LOCATION';

  @override
  String get createSpotLocationSet => 'Location set ✓';

  @override
  String get createSpotLocationDenied =>
      'We need location permission to set the spot';

  @override
  String get createSpotDifficultyLabel => 'DIFFICULTY · 1–5';

  @override
  String get createSpotSeasonLabel => 'SEASON';

  @override
  String get createSpotElementsLabel => 'SPOT ELEMENTS';

  @override
  String get createSpotHazardsLabel => 'HAZARDS';

  @override
  String get createSpotAddHazard => 'Add hazard (crack, traffic, tide…)';

  @override
  String get createSpotHazardNamePlaceholder => 'E.g. Crack on the north edge';

  @override
  String get createSpotHazardSeverityLabel => 'SEVERITY · 1–5';

  @override
  String get createSpotDescriptionLabel => 'DESCRIPTION';

  @override
  String get createSpotDescriptionPlaceholder =>
      'Describe the terrain, surface, hazards…';

  @override
  String get createSpotMediaLabel => 'MEDIA';

  @override
  String get createSpotUseCamera => 'Take photo';

  @override
  String get createSpotUseGallery => 'Choose from gallery';

  @override
  String get createSpotUploadPhoto => 'UPLOAD PHOTO';

  @override
  String get createSpotUploadVideo => 'UPLOAD VIDEO';

  @override
  String get createSpotLinkVideo => 'LINK VIDEO';

  @override
  String get createSpotVideoUrlPlaceholder => 'https://youtube.com/…';

  @override
  String get searchTitle => 'SEARCH';

  @override
  String get searchPlaceholder => 'Name, area or rider…';

  @override
  String get searchSportLabel => 'SPORT';

  @override
  String get searchDifficultyLabel => 'DIFFICULTY · 1–5';

  @override
  String get searchDistanceLabel => 'DISTANCE';

  @override
  String searchDistanceValue(int km) {
    return '≤ $km KM';
  }

  @override
  String get searchSeasonLabel => 'BEST SEASON';

  @override
  String get searchSeasonAll => 'ALL YEAR';

  @override
  String get searchSeasonDry => 'DRY (NOV–APR)';

  @override
  String get searchSeasonRain => 'RAINY';

  @override
  String get searchHazardLabel => 'HAZARD LEVEL';

  @override
  String get searchHazardLow => 'LOW';

  @override
  String get searchHazardMedium => 'MEDIUM';

  @override
  String get searchHazardHigh => 'HIGH';

  @override
  String searchResultsCount(int count) {
    return 'RESULTS · $count';
  }

  @override
  String get searchNoResults => 'No results match those filters';

  @override
  String get searchTabSpots => 'SPOTS';

  @override
  String get searchTabRiders => 'RIDERS';

  @override
  String get searchTabEvents => 'EVENTS';

  @override
  String get createSpotVideoTooLong =>
      'Video can\'t be longer than 1:30 minutes';

  @override
  String get ridesTitle => 'MY RIDES';

  @override
  String get ridesEmpty => 'You don\'t have any rides yet';

  @override
  String get rideStateActive => 'ACTIVE';

  @override
  String get rideStateOnSale => 'FOR SALE';

  @override
  String get rideStateWasted => 'DAMAGED';

  @override
  String get rideStateToGift => 'TO GIVE AWAY';

  @override
  String get createRideTitle => 'NEW RIDE';

  @override
  String get createRideNameLabel => 'RIDE NAME';

  @override
  String get createRideNamePlaceholder => 'E.g. BMX Mongoose…';

  @override
  String get createRideStateLabel => 'STATUS';

  @override
  String get createRideElementsLabel => 'ELEMENTS';

  @override
  String get createRideAddElement => 'Add element';

  @override
  String get createRideElementNamePlaceholder => 'E.g. Odyssey pedals…';

  @override
  String get createRideElementTypePlaceholder =>
      'Type (pedals, handlebar, seat…)';

  @override
  String get createRidePublish => 'PUBLISH RIDE';

  @override
  String get createRideNameRequired => 'Name is required';

  @override
  String get createRideConditionLabel => 'CONDITION · 1–5';

  @override
  String get createRideConditionWorst => 'Very damaged';

  @override
  String get createRideConditionBest => 'Brand new';

  @override
  String get createRidePhotoRequired => 'Add at least one photo';

  @override
  String get createRideCoverHint => 'Tap a photo to set it as the cover';

  @override
  String riderProfileRidesTitle(int count) {
    return 'RIDES · $count';
  }

  @override
  String get riderProfileNoRides => 'No rides yet';

  @override
  String get riderProfileChangeRoleTitle => 'CHANGE ROLE';

  @override
  String get riderProfileChangeRoleConfirm =>
      'Are you sure you want to change this rider\'s role?';

  @override
  String get eventsTitle => 'EVENTS';

  @override
  String get eventsCreate => 'CREATE';

  @override
  String get eventsTabUpcoming => 'UPCOMING';

  @override
  String get eventsTabNearby => 'NEARBY';

  @override
  String get eventsTabGoing => 'GOING';

  @override
  String get eventsEmpty => 'No events right now';

  @override
  String get eventStateActive => 'ACTIVE';

  @override
  String get eventStateCancelled => 'CANCELLED';

  @override
  String get eventStateHidden => 'HIDDEN';

  @override
  String get eventOrganizedBy => 'Organized by';

  @override
  String get eventViewSpot => 'View spot →';

  @override
  String get eventAboutTitle => 'ABOUT THIS EVENT';

  @override
  String eventAttendeesTitle(int count) {
    return 'ATTENDEES · $count';
  }

  @override
  String eventInterestedCount(int count) {
    return '$count interested';
  }

  @override
  String get rsvpGoing => 'GOING';

  @override
  String get rsvpInterested => 'INTERESTED';

  @override
  String get rsvpDeclined => 'NOT GOING';

  @override
  String get createEventTitle => 'NEW EVENT';

  @override
  String get createEventNameLabel => 'EVENT NAME';

  @override
  String get createEventNamePlaceholder => 'E.g. Bowl jam…';

  @override
  String get createEventStartLabel => 'STARTS';

  @override
  String get createEventEndLabel => 'ENDS';

  @override
  String get createEventEndOptional => 'Optional';

  @override
  String get createEventLocationLabel => 'LOCATION';

  @override
  String get createEventLocationExistingSpot => 'EXISTING SPOT';

  @override
  String get createEventLocationOwnPoint => 'OWN POINT';

  @override
  String get createEventPickSpot => 'Pick a spot…';

  @override
  String get createEventSportsLabel => 'SPORTS';

  @override
  String get createEventDescriptionPlaceholder =>
      'Categories, prizes, what to bring…';

  @override
  String get createEventPublish => 'PUBLISH EVENT';

  @override
  String get createEventNameRequired => 'Name is required';

  @override
  String get createEventStartRequired => 'Start date is required';

  @override
  String get createEventLocationRequired => 'Select a location';

  @override
  String rideElementsTitle(int count) {
    return 'ELEMENTS · $count';
  }

  @override
  String get rideNoElements => 'No elements added yet';

  @override
  String get createSpotPublish => 'PUBLISH SPOT';

  @override
  String get createSpotNameRequired => 'Name is required';

  @override
  String get createSpotDescriptionRequired => 'Description is required';

  @override
  String get dialogCancel => 'Cancel';

  @override
  String get dialogAdd => 'Add';

  @override
  String get drawerMyProfile => 'MY PROFILE (RIDER)';

  @override
  String get drawerMyRides => 'MY RIDES';

  @override
  String get drawerEvents => 'EVENTS';

  @override
  String get drawerCreateSpot => 'CREATE SPOT';

  @override
  String get drawerCreateEvent => 'CREATE EVENT';

  @override
  String get drawerLogout => 'LOG OUT';

  @override
  String get settingsFavoriteSportsSection => 'Favorite sports';

  @override
  String get settingsFavoriteSportsHint =>
      'Pick up to 10 — the first one you pick personalizes the bottom menu';

  @override
  String get settingsFavoriteSportsMax =>
      'You already have 10 favorite sports, remove one to add another';

  @override
  String get navSport => 'Sports';

  @override
  String get searchTabSports => 'SPORTS';

  @override
  String get sportRankingSection => 'RANKING';

  @override
  String get sportTopRidersLabel => 'Top riders';

  @override
  String get sportNoRidersYet => 'No one has favorited this sport yet';

  @override
  String get sportTopSpotsLabel => 'Top spots';

  @override
  String get sportNoSpotsYet => 'No rated spots for this sport yet';

  @override
  String get sportEventsSection => 'EVENTS';

  @override
  String get sportUpcomingEventsLabel => 'Upcoming';

  @override
  String get sportPastEventsLabel => 'Past';

  @override
  String get sportNoEventsYet => 'No events for this sport yet';

  @override
  String get sportTopMediaSection => 'MOST VOTED';

  @override
  String get sportTopPhotosLabel => 'Photos';

  @override
  String get sportTopVideosLabel => 'Videos';

  @override
  String get sportNoMediaYet => 'No voted content for this sport yet';

  @override
  String get rideEdit => 'Edit ride';

  @override
  String get rideEditElement => 'Edit element';

  @override
  String get rideDelete => 'Delete ride';

  @override
  String get rideDeleteConfirmTitle => 'Delete this ride?';

  @override
  String get rideDeleteConfirmBody =>
      'This can\'t be undone. The ride will be deleted along with its elements.';
}
