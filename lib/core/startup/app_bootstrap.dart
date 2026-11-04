import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../app.dart';
import '../../l10n/gen/app_localizations.dart';
import '../locale/locale_provider.dart';
import '../network/min_version_api.dart';
import '../theme/app_theme.dart';
import '../widgets/server_unreachable_screen.dart';
import 'update_required_screen.dart';
import 'version_compare.dart';

enum _VersionGateStatus { checking, ok, outdated, networkError }

/// Root widget installed by `main.dart` in place of [XtremeRidersApp].
/// Blocks on a version handshake (`GET /version`) before the real app —
/// including the router and everything it depends on — is ever built, so
/// an app below the backend's `min_app_version` truly never starts, instead
/// of just getting redirected once inside a running router (which is how
/// the existing auth/profile gates in `app_router.dart` work — fine for
/// those, not strict enough for this).
class AppBootstrap extends ConsumerStatefulWidget {
  const AppBootstrap({super.key});

  @override
  ConsumerState<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends ConsumerState<AppBootstrap> {
  _VersionGateStatus _status = _VersionGateStatus.checking;

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    setState(() => _status = _VersionGateStatus.checking);
    try {
      final info = await MinVersionApi().fetch();
      final packageInfo = await PackageInfo.fromPlatform();
      final outdated = isVersionOlderThan(
        packageInfo.version,
        info.minAppVersion,
      );
      if (!mounted) return;
      setState(
        () => _status = outdated
            ? _VersionGateStatus.outdated
            : _VersionGateStatus.ok,
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _status = _VersionGateStatus.networkError);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_status == _VersionGateStatus.ok) return const XtremeRidersApp();

    final locale = ref.watch(appLocaleProvider);
    return MaterialApp(
      theme: AppTheme.dark,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: switch (_status) {
        _VersionGateStatus.checking => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        _VersionGateStatus.outdated => const UpdateRequiredScreen(),
        _VersionGateStatus.networkError => ServerUnreachableScreen(
          onRetry: _check,
        ),
        _VersionGateStatus.ok => throw StateError('unreachable'),
      },
    );
  }
}
