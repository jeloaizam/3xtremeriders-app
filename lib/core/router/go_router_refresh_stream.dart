import 'package:flutter/foundation.dart';

/// A [Listenable] for go_router's `refreshListenable`, triggered manually
/// via [notify].
///
/// Deliberately *not* wired to a raw `Stream` (e.g. `authStateChanges()`)
/// directly: a second, independent subscription to that stream fires on its
/// own schedule, racing with whatever Riverpod provider derives the actual
/// auth flag `redirect` reads — so the redirect can run before that
/// provider's value has updated. Feed this from `ref.listen` on the same
/// provider `redirect` reads instead, so Riverpod's own dependency-ordering
/// guarantees the value is already current by the time this notifies.
class GoRouterRefreshNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}
