import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/auth_providers.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/rider_profile_screen.dart';
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
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authenticated = ref.read(isAuthenticatedProvider);
      final loggingIn = state.matchedLocation == '/login';
      if (!authenticated && !loggingIn) return '/login';
      if (authenticated && loggingIn) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
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
