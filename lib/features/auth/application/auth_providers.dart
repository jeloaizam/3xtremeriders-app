import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/auth_api.dart';
import '../data/rider_api.dart';
import '../domain/rider.dart';
import '../domain/rider_sport.dart';
import 'rider_sports_providers.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@Riverpod(keepAlive: true)
AuthApi authApi(Ref ref) => AuthApi();

/// Raw Firebase auth state — the source of truth for whether someone is
/// signed in. Doesn't touch the backend.
///
/// keepAlive: without it, this (and [isAuthenticatedProvider] below) gets
/// disposed whenever nothing is watching it, so a plain `ref.read()` from
/// the router's `redirect` callback would rebuild it fresh each time — and
/// a freshly rebuilt StreamProvider hasn't received its first async
/// emission yet, reading as `null`/unauthenticated even right after a
/// successful login.
@Riverpod(keepAlive: true)
Stream<User?> firebaseUser(Ref ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
}

/// True once Firebase confirms a signed-in user. Used by the router guard —
/// deliberately doesn't wait on the backend sync below, so navigation isn't
/// blocked by a network round trip.
@Riverpod(keepAlive: true)
bool isAuthenticated(Ref ref) {
  return ref.watch(firebaseUserProvider).value != null;
}

/// Real profile data collected by `SignupScreen` right before creating the
/// Firebase account, consumed once by [CurrentRider.build] the first time
/// it syncs a brand-new rider. Exists to win an unavoidable race: the
/// moment Firebase auth state flips, the router redirects and something
/// else may end up triggering [CurrentRider]'s first build before the
/// signup screen itself would ever get a chance to call `sync()` with the
/// real values — since the backend only uses the *first* sync's body for a
/// given firebase_uid, whoever calls it first wins. Setting this
/// synchronously before Firebase even creates the account sidesteps the
/// race entirely: no matter who ends up triggering the actual network
/// call, it reads the pending values that are already sitting here.
@Riverpod(keepAlive: true)
class PendingSignupProfile extends _$PendingSignupProfile {
  @override
  ({
    String name,
    String lastName,
    String nickname,
    DateTime birthDate,
    String termsVersion,
    String privacyVersion,
    String deviceInfo,
  })?
  build() => null;

  void set(
    String name,
    String lastName,
    String nickname,
    DateTime birthDate,
    String termsVersion,
    String privacyVersion,
    String deviceInfo,
  ) {
    state = (
      name: name,
      lastName: lastName,
      nickname: nickname,
      birthDate: birthDate,
      termsVersion: termsVersion,
      privacyVersion: privacyVersion,
      deviceInfo: deviceInfo,
    );
  }

  void clear() {
    state = null;
  }
}

/// True once a signed-in rider's profile is missing the bare minimum
/// (nickname, gender, or birth date) — nickname-empty in practice only
/// happens for a brand-new social sign-in (Google today), since email
/// sign-up always goes through `SignupScreen` and [PendingSignupProfile]
/// first. Gender-null/birthDate-null hit *every* rider created before those
/// fields existed, not just new signups — both are write-once, so this gate
/// is what forces every existing rider to backfill them the next time they
/// open the app. Drives the router's mandatory `/complete-profile` redirect.
@riverpod
bool needsProfileCompletion(Ref ref) {
  final rider = ref.watch(currentRiderProvider).value;
  return rider != null &&
      (rider.nickname.trim().isEmpty ||
          rider.gender == null ||
          rider.birthDate == null);
}

/// The rider's "current" sport — `Rider.activeSportId` once they've picked
/// one explicitly, falling back to their #1 favorite (lowest `order`) while
/// it's still unset. Drives Home's bottom-nav sport icon, the carousel's
/// sort order, and the sport preselected when creating a new spot.
@riverpod
Future<int?> effectiveActiveSportId(Ref ref) async {
  final rider = await ref.watch(currentRiderProvider.future);
  if (rider == null) return null;
  if (rider.activeSportId != null) return rider.activeSportId;

  final favorites = await ref.watch(riderSportsProvider(rider.id).future);
  RiderSport? top;
  for (final rs in favorites) {
    if (top == null || rs.order < top.order) top = rs;
  }
  return top?.sportId;
}

/// The backend Rider profile for the current Firebase user, synced via
/// POST /auth/sync. For an already-registered rider the backend ignores the
/// placeholder profile fields and just returns the stored profile — real
/// values are only needed the first time a given firebase_uid signs in.
///
/// keepAlive: this must survive even when no screen is actively watching it
/// (e.g. between Home and Settings), otherwise a rider who never opens
/// Settings never gets synced — and anything that calls an authenticated
/// endpoint (Spot ratings, likes) gets a 401 "Rider no registrado" even
/// though they're validly signed in with Firebase.
@Riverpod(keepAlive: true)
class CurrentRider extends _$CurrentRider {
  @override
  Future<Rider?> build() async {
    final user = await ref.watch(firebaseUserProvider.future);
    if (user == null) return null;

    final idToken = await user.getIdToken();
    if (idToken == null) return null;

    final pending = ref.read(pendingSignupProfileProvider);
    final rider = await ref
        .read(authApiProvider)
        .sync(
          idToken: idToken,
          name: pending?.name ?? '',
          lastName: pending?.lastName ?? '',
          nickname: pending?.nickname ?? '',
          birthDate: pending?.birthDate,
        );
    if (pending != null) {
      ref.read(pendingSignupProfileProvider.notifier).clear();
      // Only a brand-new email sign-up reaches here with a pending profile
      // — the consent checkboxes were shown and checked on SignupScreen
      // right before this sync, so it's safe to log acceptance now.
      await ref
          .read(authApiProvider)
          .acceptConsent(
            idToken: idToken,
            termsVersion: pending.termsVersion,
            privacyVersion: pending.privacyVersion,
            deviceInfo: pending.deviceInfo,
          );
    }
    return rider;
  }

  /// Logs acceptance of the current Terms/Privacy versions for a rider who
  /// didn't go through [PendingSignupProfile] (Google sign-up, or a legacy
  /// rider backfilling via `CompleteProfileScreen`).
  Future<void> acceptConsent({
    required String termsVersion,
    required String privacyVersion,
    required String deviceInfo,
  }) async {
    final user = ref.read(firebaseAuthProvider).currentUser;
    if (user == null) return;

    final idToken = await user.getIdToken();
    if (idToken == null) return;

    await ref
        .read(authApiProvider)
        .acceptConsent(
          idToken: idToken,
          termsVersion: termsVersion,
          privacyVersion: privacyVersion,
          deviceInfo: deviceInfo,
        );
  }

  /// Updates the signed-in rider's profile fields via `PATCH /riders/{id}`
  /// and refreshes local state with the response.
  ///
  /// `cityName` is always sent explicitly (as the picked name or a real
  /// `null`), never omitted — unlike `RiderApi.update`'s general
  /// partial-update semantics, this method is only ever called from
  /// Settings/CompleteProfile, which always own the whole city field: on
  /// every save it's either the name just picked in `CitySearchField` or
  /// `null` (country changed, no city picked yet), never left stale.
  /// `iconImage` follows the same always-explicit convention — Settings
  /// always resends the rider's current avatar URL (or `null` to clear it)
  /// on every save, since it's the sole owner of that field too.
  Future<void> updateProfile({
    String? name,
    String? lastName,
    String? nickname,
    String? iconImage,
    String? bio,
    String? cityName,
    int? countryId,
    // Write-once — only ever sent by CompleteProfileScreen the one time
    // it's actually still unset. No `clearGender`-style flag on purpose:
    // there's no legitimate way to unset it once fixed.
    String? gender,
    // Same write-once convention as gender.
    DateTime? birthDate,
  }) async {
    final rider = state.value;
    final user = ref.read(firebaseAuthProvider).currentUser;
    if (rider == null || user == null) return;

    final idToken = await user.getIdToken();
    if (idToken == null) return;

    final updated = await ref
        .read(riderApiProvider)
        .update(
          riderId: rider.id,
          idToken: idToken,
          name: name,
          lastName: lastName,
          nickname: nickname,
          iconImage: iconImage,
          clearIconImage: iconImage == null,
          bio: bio,
          cityName: cityName,
          clearCityName: cityName == null,
          countryId: countryId,
          gender: gender,
          birthDate: birthDate,
        );
    state = AsyncData(updated);
  }

  /// Sets the rider's "active" sport — see [effectiveActiveSportId].
  Future<void> setActiveSport(int sportId) async {
    final rider = state.value;
    final user = ref.read(firebaseAuthProvider).currentUser;
    if (rider == null || user == null) return;

    final idToken = await user.getIdToken();
    if (idToken == null) return;

    final updated = await ref
        .read(riderApiProvider)
        .update(riderId: rider.id, idToken: idToken, activeSportId: sportId);
    state = AsyncData(updated);
  }

  /// Sets which sports show on Home's map ("Personalizar mapa"). `null`
  /// clears the filter (show every sport, including future ones); an
  /// explicit list — even empty — is the active filter.
  Future<void> setMapSportFilter(List<int>? sportIds) async {
    final rider = state.value;
    final user = ref.read(firebaseAuthProvider).currentUser;
    if (rider == null || user == null) return;

    final idToken = await user.getIdToken();
    if (idToken == null) return;

    final updated = await ref
        .read(riderApiProvider)
        .update(
          riderId: rider.id,
          idToken: idToken,
          mapSportFilter: sportIds,
          clearMapSportFilter: sportIds == null,
        );
    state = AsyncData(updated);
  }
}
