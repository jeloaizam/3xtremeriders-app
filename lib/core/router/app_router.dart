import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/auth_providers.dart';
import '../../features/auth/presentation/screens/complete_profile_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/rider_profile_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/events/presentation/screens/create_event_screen.dart';
import '../../features/events/presentation/screens/event_screen.dart';
import '../../features/events/presentation/screens/events_list_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/rides/presentation/screens/create_ride_screen.dart';
import '../../features/rides/presentation/screens/edit_ride_screen.dart';
import '../../features/rides/presentation/screens/my_rides_screen.dart';
import '../../features/rides/presentation/screens/ride_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/spots/presentation/screens/create_spot_screen.dart';
import '../../features/spots/presentation/screens/search_screen.dart';
import '../../features/spots/presentation/screens/spot_screen.dart';
import '../../features/spots/presentation/screens/sport_screen.dart';
import 'go_router_refresh_stream.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refreshNotifier = GoRouterRefreshNotifier();
  ref.listen(isAuthenticatedProvider, (_, _) => refreshNotifier.notify());
  // Without this, the router never re-evaluates `redirect` once the rider
  // profile finishes resolving asynchronously after login — the exact same
  // class of ordering bug already hit once before with `isAuthenticated`
  // alone (see project memory). Needed for the `/complete-profile` gate
  // below, which depends on `currentRiderProvider`'s resolved value.
  ref.listen(currentRiderProvider, (_, _) => refreshNotifier.notify());
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authenticated = ref.read(isAuthenticatedProvider);
      final loggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';
      if (!authenticated && !loggingIn) return '/login';
      if (!authenticated) return null;

      // Mandatory profile-completion gate — only relevant once
      // authenticated. `.value` reads null while `currentRiderProvider` is
      // still resolving; treated as "not blocking yet" rather than forced,
      // to avoid bouncing the rider mid-sync.
      final needsCompletion = ref.read(needsProfileCompletionProvider);
      final onCompletion = state.matchedLocation == '/complete-profile';
      if (needsCompletion && !onCompletion) return '/complete-profile';
      if (!needsCompletion && onCompletion) return '/home';
      if (loggingIn) return needsCompletion ? '/complete-profile' : '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/complete-profile',
        builder: (context, state) => const CompleteProfileScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => SearchScreen(
          initialTab: state.extra is SearchTab
              ? state.extra as SearchTab
              : SearchTab.spots,
        ),
      ),
      GoRoute(
        path: '/spot/new',
        builder: (context, state) => const CreateSpotScreen(),
      ),
      GoRoute(
        path: '/spot/:id',
        builder: (context, state) =>
            SpotScreen(spotId: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/rides',
        builder: (context, state) => const MyRidesScreen(),
      ),
      GoRoute(
        path: '/rides/new',
        builder: (context, state) => const CreateRideScreen(),
      ),
      GoRoute(
        path: '/rides/:id',
        builder: (context, state) =>
            RideScreen(rideId: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/rides/:id/edit',
        builder: (context, state) =>
            EditRideScreen(rideId: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/riders/:id',
        builder: (context, state) =>
            RiderProfileScreen(riderId: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/events',
        builder: (context, state) => const EventsListScreen(),
      ),
      GoRoute(
        path: '/events/new',
        builder: (context, state) => const CreateEventScreen(),
      ),
      GoRoute(
        path: '/events/:id',
        builder: (context, state) =>
            EventScreen(eventId: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/sports/:id',
        builder: (context, state) =>
            SportScreen(sportId: int.parse(state.pathParameters['id']!)),
      ),
    ],
  );
}
