// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseAuth)
final firebaseAuthProvider = FirebaseAuthProvider._();

final class FirebaseAuthProvider
    extends $FunctionalProvider<FirebaseAuth, FirebaseAuth, FirebaseAuth>
    with $Provider<FirebaseAuth> {
  FirebaseAuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseAuthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseAuthHash();

  @$internal
  @override
  $ProviderElement<FirebaseAuth> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseAuth create(Ref ref) {
    return firebaseAuth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseAuth value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseAuth>(value),
    );
  }
}

String _$firebaseAuthHash() => r'8c3e9d11b27110ca96130356b5ef4d5d34a5ffc2';

@ProviderFor(authApi)
final authApiProvider = AuthApiProvider._();

final class AuthApiProvider
    extends $FunctionalProvider<AuthApi, AuthApi, AuthApi>
    with $Provider<AuthApi> {
  AuthApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authApiHash();

  @$internal
  @override
  $ProviderElement<AuthApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthApi create(Ref ref) {
    return authApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthApi>(value),
    );
  }
}

String _$authApiHash() => r'6466c060dfa0d8c1a4883e17cac0870b5bfa1875';

/// Raw Firebase auth state — the source of truth for whether someone is
/// signed in. Doesn't touch the backend.
///
/// keepAlive: without it, this (and [isAuthenticatedProvider] below) gets
/// disposed whenever nothing is watching it, so a plain `ref.read()` from
/// the router's `redirect` callback would rebuild it fresh each time — and
/// a freshly rebuilt StreamProvider hasn't received its first async
/// emission yet, reading as `null`/unauthenticated even right after a
/// successful login.

@ProviderFor(firebaseUser)
final firebaseUserProvider = FirebaseUserProvider._();

/// Raw Firebase auth state — the source of truth for whether someone is
/// signed in. Doesn't touch the backend.
///
/// keepAlive: without it, this (and [isAuthenticatedProvider] below) gets
/// disposed whenever nothing is watching it, so a plain `ref.read()` from
/// the router's `redirect` callback would rebuild it fresh each time — and
/// a freshly rebuilt StreamProvider hasn't received its first async
/// emission yet, reading as `null`/unauthenticated even right after a
/// successful login.

final class FirebaseUserProvider
    extends $FunctionalProvider<AsyncValue<User?>, User?, Stream<User?>>
    with $FutureModifier<User?>, $StreamProvider<User?> {
  /// Raw Firebase auth state — the source of truth for whether someone is
  /// signed in. Doesn't touch the backend.
  ///
  /// keepAlive: without it, this (and [isAuthenticatedProvider] below) gets
  /// disposed whenever nothing is watching it, so a plain `ref.read()` from
  /// the router's `redirect` callback would rebuild it fresh each time — and
  /// a freshly rebuilt StreamProvider hasn't received its first async
  /// emission yet, reading as `null`/unauthenticated even right after a
  /// successful login.
  FirebaseUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseUserHash();

  @$internal
  @override
  $StreamProviderElement<User?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<User?> create(Ref ref) {
    return firebaseUser(ref);
  }
}

String _$firebaseUserHash() => r'1929d12922ddfbefc7761d7934e072b1feb0982f';

/// True once Firebase confirms a signed-in user. Used by the router guard —
/// deliberately doesn't wait on the backend sync below, so navigation isn't
/// blocked by a network round trip.

@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = IsAuthenticatedProvider._();

/// True once Firebase confirms a signed-in user. Used by the router guard —
/// deliberately doesn't wait on the backend sync below, so navigation isn't
/// blocked by a network round trip.

final class IsAuthenticatedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// True once Firebase confirms a signed-in user. Used by the router guard —
  /// deliberately doesn't wait on the backend sync below, so navigation isn't
  /// blocked by a network round trip.
  IsAuthenticatedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAuthenticatedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAuthenticatedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAuthenticated(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAuthenticatedHash() => r'7e4b76e019a785102d684103bb31a7554dde248f';

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

@ProviderFor(PendingSignupProfile)
final pendingSignupProfileProvider = PendingSignupProfileProvider._();

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
final class PendingSignupProfileProvider
    extends
        $NotifierProvider<
          PendingSignupProfile,
          ({String lastName, String name, String nickname})?
        > {
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
  PendingSignupProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingSignupProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingSignupProfileHash();

  @$internal
  @override
  PendingSignupProfile create() => PendingSignupProfile();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    ({String lastName, String name, String nickname})? value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            ({String lastName, String name, String nickname})?
          >(value),
    );
  }
}

String _$pendingSignupProfileHash() =>
    r'18b0c5301ad50f1ee227f0904d0854492cc8b2a0';

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

abstract class _$PendingSignupProfile
    extends $Notifier<({String lastName, String name, String nickname})?> {
  ({String lastName, String name, String nickname})? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({String lastName, String name, String nickname})?,
              ({String lastName, String name, String nickname})?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({String lastName, String name, String nickname})?,
                ({String lastName, String name, String nickname})?
              >,
              ({String lastName, String name, String nickname})?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// True once a signed-in rider's profile is missing the bare minimum
/// (nickname) — in practice this only happens for a brand-new social
/// sign-in (Google today), since email sign-up always goes through
/// `SignupScreen` and [PendingSignupProfile] first. Drives the router's
/// mandatory `/complete-profile` redirect.

@ProviderFor(needsProfileCompletion)
final needsProfileCompletionProvider = NeedsProfileCompletionProvider._();

/// True once a signed-in rider's profile is missing the bare minimum
/// (nickname) — in practice this only happens for a brand-new social
/// sign-in (Google today), since email sign-up always goes through
/// `SignupScreen` and [PendingSignupProfile] first. Drives the router's
/// mandatory `/complete-profile` redirect.

final class NeedsProfileCompletionProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// True once a signed-in rider's profile is missing the bare minimum
  /// (nickname) — in practice this only happens for a brand-new social
  /// sign-in (Google today), since email sign-up always goes through
  /// `SignupScreen` and [PendingSignupProfile] first. Drives the router's
  /// mandatory `/complete-profile` redirect.
  NeedsProfileCompletionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'needsProfileCompletionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$needsProfileCompletionHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return needsProfileCompletion(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$needsProfileCompletionHash() =>
    r'76b136470937c237616e288339a0fd1f1b36873f';

/// The rider's "current" sport — `Rider.activeSportId` once they've picked
/// one explicitly, falling back to their #1 favorite (lowest `order`) while
/// it's still unset. Drives Home's bottom-nav sport icon, the carousel's
/// sort order, and the sport preselected when creating a new spot.

@ProviderFor(effectiveActiveSportId)
final effectiveActiveSportIdProvider = EffectiveActiveSportIdProvider._();

/// The rider's "current" sport — `Rider.activeSportId` once they've picked
/// one explicitly, falling back to their #1 favorite (lowest `order`) while
/// it's still unset. Drives Home's bottom-nav sport icon, the carousel's
/// sort order, and the sport preselected when creating a new spot.

final class EffectiveActiveSportIdProvider
    extends $FunctionalProvider<AsyncValue<int?>, int?, FutureOr<int?>>
    with $FutureModifier<int?>, $FutureProvider<int?> {
  /// The rider's "current" sport — `Rider.activeSportId` once they've picked
  /// one explicitly, falling back to their #1 favorite (lowest `order`) while
  /// it's still unset. Drives Home's bottom-nav sport icon, the carousel's
  /// sort order, and the sport preselected when creating a new spot.
  EffectiveActiveSportIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'effectiveActiveSportIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$effectiveActiveSportIdHash();

  @$internal
  @override
  $FutureProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int?> create(Ref ref) {
    return effectiveActiveSportId(ref);
  }
}

String _$effectiveActiveSportIdHash() =>
    r'dc451e5a18e33689fdab35d9abfe76104a013031';

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

@ProviderFor(CurrentRider)
final currentRiderProvider = CurrentRiderProvider._();

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
final class CurrentRiderProvider
    extends $AsyncNotifierProvider<CurrentRider, Rider?> {
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
  CurrentRiderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentRiderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentRiderHash();

  @$internal
  @override
  CurrentRider create() => CurrentRider();
}

String _$currentRiderHash() => r'44f3d96215815fe2143b57046af9a067be47f5c6';

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

abstract class _$CurrentRider extends $AsyncNotifier<Rider?> {
  FutureOr<Rider?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Rider?>, Rider?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Rider?>, Rider?>,
              AsyncValue<Rider?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
