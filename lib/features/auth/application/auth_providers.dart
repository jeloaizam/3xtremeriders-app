import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/auth_api.dart';
import '../data/rider_api.dart';
import '../domain/rider.dart';

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

/// The backend Rider profile for the current Firebase user, synced via
/// POST /auth/sync. For an already-registered rider the backend ignores the
/// placeholder profile fields and just returns the stored profile — real
/// values are only needed the first time a given firebase_uid signs in.
@riverpod
class CurrentRider extends _$CurrentRider {
  @override
  Future<Rider?> build() async {
    final user = await ref.watch(firebaseUserProvider.future);
    if (user == null) return null;

    final idToken = await user.getIdToken();
    if (idToken == null) return null;

    return ref.read(authApiProvider).sync(
      idToken: idToken,
      name: '',
      lastName: '',
      nickname: '',
    );
  }

  /// Updates the signed-in rider's profile fields via `PATCH /riders/{id}`
  /// and refreshes local state with the response.
  Future<void> updateProfile({
    String? name,
    String? lastName,
    String? nickname,
    String? bio,
    String? city,
    int? countryId,
  }) async {
    final rider = state.value;
    final user = ref.read(firebaseAuthProvider).currentUser;
    if (rider == null || user == null) return;

    final idToken = await user.getIdToken();
    if (idToken == null) return;

    final updated = await ref.read(riderApiProvider).update(
      riderId: rider.id,
      idToken: idToken,
      name: name,
      lastName: lastName,
      nickname: nickname,
      bio: bio,
      city: city,
      countryId: countryId,
    );
    state = AsyncData(updated);
  }
}
