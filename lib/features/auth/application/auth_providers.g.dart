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

@ProviderFor(firebaseUser)
final firebaseUserProvider = FirebaseUserProvider._();

/// Raw Firebase auth state — the source of truth for whether someone is
/// signed in. Doesn't touch the backend.

final class FirebaseUserProvider
    extends $FunctionalProvider<AsyncValue<User?>, User?, Stream<User?>>
    with $FutureModifier<User?>, $StreamProvider<User?> {
  /// Raw Firebase auth state — the source of truth for whether someone is
  /// signed in. Doesn't touch the backend.
  FirebaseUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseUserProvider',
        isAutoDispose: true,
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

String _$firebaseUserHash() => r'3b82d85d6c9cfd8ce4db008e733909274570bd18';

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
        isAutoDispose: true,
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

String _$isAuthenticatedHash() => r'747021410b617a69d525563ba419ec509170e3ea';

/// The backend Rider profile for the current Firebase user, synced via
/// POST /auth/sync. For an already-registered rider the backend ignores the
/// placeholder profile fields and just returns the stored profile — real
/// values are only needed the first time a given firebase_uid signs in.

@ProviderFor(CurrentRider)
final currentRiderProvider = CurrentRiderProvider._();

/// The backend Rider profile for the current Firebase user, synced via
/// POST /auth/sync. For an already-registered rider the backend ignores the
/// placeholder profile fields and just returns the stored profile — real
/// values are only needed the first time a given firebase_uid signs in.
final class CurrentRiderProvider
    extends $AsyncNotifierProvider<CurrentRider, Rider?> {
  /// The backend Rider profile for the current Firebase user, synced via
  /// POST /auth/sync. For an already-registered rider the backend ignores the
  /// placeholder profile fields and just returns the stored profile — real
  /// values are only needed the first time a given firebase_uid signs in.
  CurrentRiderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentRiderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentRiderHash();

  @$internal
  @override
  CurrentRider create() => CurrentRider();
}

String _$currentRiderHash() => r'a811b994fa78bbcc1ab44af6d71cc34cffebbdfe';

/// The backend Rider profile for the current Firebase user, synced via
/// POST /auth/sync. For an already-registered rider the backend ignores the
/// placeholder profile fields and just returns the stored profile — real
/// values are only needed the first time a given firebase_uid signs in.

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
