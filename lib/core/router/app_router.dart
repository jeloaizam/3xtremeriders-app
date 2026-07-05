import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/auth_providers.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
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
    ],
  );
}
