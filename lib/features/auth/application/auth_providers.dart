import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/auth_api.dart';
import '../domain/rider.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@Riverpod(keepAlive: true)
AuthApi authApi(Ref ref) => AuthApi();

/// Raw Firebase auth state — the source of truth for whether someone is
/// signed in. Doesn't touch the backend.
@riverpod
Stream<User?> firebaseUser(Ref ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
}

/// True once Firebase confirms a signed-in user. Used by the router guard —
/// deliberately doesn't wait on the backend sync below, so navigation isn't
/// blocked by a network round trip.
@riverpod
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
}
