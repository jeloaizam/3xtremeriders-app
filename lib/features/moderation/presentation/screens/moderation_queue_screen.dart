import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_segmented_control.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../spots/data/spot_api.dart';
import '../../application/report_providers.dart';
import '../../data/report_api.dart';
import '../../domain/report.dart';

/// Moderador+ únicamente — el backend ya rechaza `GET/PATCH /reports` para
/// cualquier otro rol, acá solo se oculta el punto de entrada (mismo
/// criterio que el resto de la app, ver `drawerCreateEvent` en
/// `home_screen.dart`). Solo lista reportes de spots por ahora (ver plan de
/// moderación) — comentarios/fotos/videos quedan para una ronda futura.
class ModerationQueueScreen extends ConsumerStatefulWidget {
  const ModerationQueueScreen({super.key});

  @override
  ConsumerState<ModerationQueueScreen> createState() =>
      _ModerationQueueScreenState();
}

class _ModerationQueueScreenState
    extends ConsumerState<ModerationQueueScreen> {
  int _state = reportStatePending;
  bool _busy = false;

  Future<void> _act(Future<void> Function(String idToken) action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) return;
      await action(idToken);
      ref.invalidate(reportQueueProvider(_state, 'spot'));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _markState(Report report, int state) => _act(
    (idToken) => ref
        .read(reportApiProvider)
        .updateState(reportId: report.id, state: state, idToken: idToken)
        .then((_) {}),
  );

  Future<void> _markActioned(Report report) => _act((idToken) async {
    await ref
        .read(reportApiProvider)
        .updateState(
          reportId: report.id,
          state: reportStateActioned,
          idToken: idToken,
        );
    await ref
        .read(spotApiProvider)
        .setState(spotId: report.targetId, state: 'hidden', idToken: idToken);
  });

  Future<void> _reactivateSpot(Report report) => _act(
    (idToken) => ref
        .read(spotApiProvider)
        .setState(spotId: report.targetId, state: 'active', idToken: idToken)
        .then((_) {}),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final reportsAsync = ref.watch(reportQueueProvider(_state, 'spot'));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
              child: Row(
                children: [
                  AppIconButton(
                    icon: Symbols.arrow_back,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      l10n.moderationQueueTitle,
                      style: context.typography.displaySm,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: AppSegmentedControl<int>(
                value: _state,
                segments: [
                  AppSegment(
                    value: reportStatePending,
                    label: l10n.moderationTabPending,
                  ),
                  AppSegment(
                    value: reportStateReviewed,
                    label: l10n.moderationTabReviewed,
                  ),
                  AppSegment(
                    value: reportStateDismissed,
                    label: l10n.moderationTabDismissed,
                  ),
                  AppSegment(
                    value: reportStateActioned,
                    label: l10n.moderationTabActioned,
                  ),
                ],
                onChanged: (value) => setState(() => _state = value),
              ),
            ),
            Expanded(
              child: reportsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('$error')),
                data: (reports) => reports.isEmpty
                    ? Center(
                        child: Text(
                          l10n.moderationQueueEmpty,
                          style: context.typography.bodySm,
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(18, 4, 18, 20),
                        children: [
                          for (final report in reports)
                            _ReportRow(
                              report: report,
                              busy: _busy,
                              onViewSpot: () =>
                                  context.push('/spot/${report.targetId}'),
                              onMarkReviewed: _state == reportStatePending
                                  ? () => _markState(report, reportStateReviewed)
                                  : null,
                              onMarkDismissed: _state == reportStatePending
                                  ? () =>
                                        _markState(report, reportStateDismissed)
                                  : null,
                              onMarkActioned: _state == reportStatePending
                                  ? () => _markActioned(report)
                                  : null,
                              onReactivateSpot: _state == reportStateActioned
                                  ? () => _reactivateSpot(report)
                                  : null,
                            ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  const _ReportRow({
    required this.report,
    required this.busy,
    required this.onViewSpot,
    this.onMarkReviewed,
    this.onMarkDismissed,
    this.onMarkActioned,
    this.onReactivateSpot,
  });

  final Report report;
  final bool busy;
  final VoidCallback onViewSpot;
  final VoidCallback? onMarkReviewed;
  final VoidCallback? onMarkDismissed;
  final VoidCallback? onMarkActioned;
  final VoidCallback? onReactivateSpot;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: colors.surfaceCard,
          border: Border.all(color: colors.hairline),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report.reason,
              style: context.typography.title.copyWith(fontSize: 15),
            ),
            if (report.details != null && report.details!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(report.details!, style: context.typography.bodySm),
            ],
            const SizedBox(height: 6),
            Text(
              DateFormat.yMMMd(
                Localizations.localeOf(context).toString(),
              ).format(report.createdDate),
              style: context.typography.micro,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                AppButton(
                  label: l10n.moderationViewSpot,
                  variant: AppButtonVariant.secondary,
                  size: AppButtonSize.md,
                  fullWidth: false,
                  onPressed: onViewSpot,
                ),
                if (onMarkReviewed != null)
                  AppButton(
                    label: l10n.moderationMarkReviewed,
                    variant: AppButtonVariant.secondary,
                    size: AppButtonSize.md,
                    fullWidth: false,
                    onPressed: busy ? null : onMarkReviewed,
                  ),
                if (onMarkDismissed != null)
                  AppButton(
                    label: l10n.moderationMarkDismissed,
                    variant: AppButtonVariant.ghost,
                    size: AppButtonSize.md,
                    fullWidth: false,
                    onPressed: busy ? null : onMarkDismissed,
                  ),
                if (onMarkActioned != null)
                  AppButton(
                    label: l10n.moderationMarkActioned,
                    variant: AppButtonVariant.danger,
                    size: AppButtonSize.md,
                    fullWidth: false,
                    onPressed: busy ? null : onMarkActioned,
                  ),
                if (onReactivateSpot != null)
                  AppButton(
                    label: l10n.moderationReactivateSpot,
                    variant: AppButtonVariant.danger,
                    size: AppButtonSize.md,
                    fullWidth: false,
                    onPressed: busy ? null : onReactivateSpot,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
