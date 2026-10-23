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
import '../../../spots/data/spot_comment_api.dart';
import '../../../spots/data/spot_photo_api.dart';
import '../../../spots/data/spot_video_api.dart';
import '../../../spots/domain/spot_comment.dart';
import '../../application/report_providers.dart';
import '../../application/report_target_providers.dart';
import '../../data/report_api.dart';
import '../../domain/report.dart';

/// Moderador+ únicamente — el backend ya rechaza `GET/PATCH /reports` para
/// cualquier otro rol, acá solo se oculta el punto de entrada (mismo
/// criterio que el resto de la app, ver `drawerCreateEvent` en
/// `home_screen.dart`). Lista reportes de spot/comentario/foto/video —
/// "Accionado" oculta/reactiva un spot (reversible) pero elimina de verdad
/// un comentario/foto/video (irreversible, de ahí la confirmación).
class ModerationQueueScreen extends ConsumerStatefulWidget {
  const ModerationQueueScreen({super.key});

  @override
  ConsumerState<ModerationQueueScreen> createState() =>
      _ModerationQueueScreenState();
}

class _ModerationQueueScreenState
    extends ConsumerState<ModerationQueueScreen> {
  int _state = reportStatePending;
  String _targetType = 'spot';
  bool _busy = false;

  Future<void> _act(Future<void> Function(String idToken) action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) return;
      await action(idToken);
      ref.invalidate(reportQueueProvider(_state, _targetType));
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
    switch (report.targetType) {
      case 'spot':
        await ref
            .read(spotApiProvider)
            .setState(
              spotId: report.targetId,
              state: 'hidden',
              idToken: idToken,
            );
      case 'comment':
        await ref
            .read(spotCommentApiProvider)
            .delete(commentId: report.targetId, idToken: idToken);
        ref.invalidate(reportedCommentProvider(report.targetId));
      case 'photo':
        await ref
            .read(spotPhotoApiProvider)
            .delete(photoId: report.targetId, idToken: idToken);
        ref.invalidate(reportedPhotoProvider(report.targetId));
      case 'video':
        await ref
            .read(spotVideoApiProvider)
            .delete(videoId: report.targetId, idToken: idToken);
        ref.invalidate(reportedVideoProvider(report.targetId));
    }
  });

  Future<void> _confirmAndMarkActioned(Report report) async {
    if (report.targetType == 'spot') {
      await _markActioned(report);
      return;
    }
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: context.colors.surfaceCard,
        title: Text(l10n.moderationConfirmDeleteTitle),
        content: Text(l10n.moderationConfirmDeleteBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.moderationCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.moderationConfirmDelete,
              style: TextStyle(color: context.colors.colorDanger),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) await _markActioned(report);
  }

  Future<void> _reactivateSpot(Report report) => _act(
    (idToken) => ref
        .read(spotApiProvider)
        .setState(spotId: report.targetId, state: 'active', idToken: idToken)
        .then((_) {}),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final reportsAsync = ref.watch(reportQueueProvider(_state, _targetType));

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
              child: AppSegmentedControl<String>(
                value: _targetType,
                segments: [
                  AppSegment(value: 'spot', label: l10n.moderationTypeSpot),
                  AppSegment(
                    value: 'comment',
                    label: l10n.moderationTypeComment,
                  ),
                  AppSegment(value: 'photo', label: l10n.moderationTypePhoto),
                  AppSegment(value: 'video', label: l10n.moderationTypeVideo),
                ],
                onChanged: (value) => setState(() => _targetType = value),
              ),
            ),
            const SizedBox(height: 8),
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
                              onViewSpot: report.targetType == 'spot'
                                  ? () => context.push('/spot/${report.targetId}')
                                  : null,
                              onMarkReviewed: _state == reportStatePending
                                  ? () => _markState(report, reportStateReviewed)
                                  : null,
                              onMarkDismissed: _state == reportStatePending
                                  ? () =>
                                        _markState(report, reportStateDismissed)
                                  : null,
                              onMarkActioned: _state == reportStatePending
                                  ? () => _confirmAndMarkActioned(report)
                                  : null,
                              onReactivateSpot:
                                  _state == reportStateActioned &&
                                      report.targetType == 'spot'
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

String _actionedLabel(AppLocalizations l10n, String targetType) =>
    switch (targetType) {
      'comment' => l10n.moderationDeleteComment,
      'photo' => l10n.moderationDeletePhoto,
      'video' => l10n.moderationDeleteVideo,
      _ => l10n.moderationMarkActioned,
    };

class _ReportRow extends StatelessWidget {
  const _ReportRow({
    required this.report,
    required this.busy,
    this.onViewSpot,
    this.onMarkReviewed,
    this.onMarkDismissed,
    this.onMarkActioned,
    this.onReactivateSpot,
  });

  final Report report;
  final bool busy;
  final VoidCallback? onViewSpot;
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
            switch (report.targetType) {
              'comment' => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: _CommentPreview(commentId: report.targetId),
              ),
              'photo' => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: _PhotoPreview(photoId: report.targetId),
              ),
              'video' => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: _VideoPreview(videoId: report.targetId),
              ),
              _ => const SizedBox.shrink(),
            },
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
                if (onViewSpot != null)
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
                    label: _actionedLabel(l10n, report.targetType),
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

class _CommentPreview extends ConsumerWidget {
  const _CommentPreview({required this.commentId});

  final int commentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final async = ref.watch(reportedCommentProvider(commentId));
    return async.when(
      loading: () => const SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, _) => Text(
        l10n.moderationContentUnavailable,
        style: context.typography.bodySm.copyWith(color: colors.textMuted),
      ),
      data: (comment) {
        if (comment == null || comment.state == commentStateDeleted) {
          return Text(
            l10n.moderationCommentDeleted,
            style: context.typography.bodySm.copyWith(
              color: colors.textMuted,
              fontStyle: FontStyle.italic,
            ),
          );
        }
        return Text(
          '"${comment.body}"',
          style: context.typography.bodySm.copyWith(
            fontStyle: FontStyle.italic,
          ),
        );
      },
    );
  }
}

class _PhotoPreview extends ConsumerWidget {
  const _PhotoPreview({required this.photoId});

  final int photoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final async = ref.watch(reportedPhotoProvider(photoId));
    return async.when(
      loading: () => const SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, _) => Text(
        l10n.moderationContentUnavailable,
        style: context.typography.bodySm.copyWith(color: colors.textMuted),
      ),
      data: (photo) {
        if (photo == null) {
          return Text(
            l10n.moderationContentDeleted,
            style: context.typography.bodySm.copyWith(
              color: colors.textMuted,
              fontStyle: FontStyle.italic,
            ),
          );
        }
        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 52,
                height: 52,
                child: Image.network(
                  photo.url,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: colors.bg850,
                    child: Icon(Symbols.broken_image, color: colors.textMuted),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '@${photo.uploaderNickname}',
                style: context.typography.bodySm,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _VideoPreview extends ConsumerWidget {
  const _VideoPreview({required this.videoId});

  final int videoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final async = ref.watch(reportedVideoProvider(videoId));
    return async.when(
      loading: () => const SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, _) => Text(
        l10n.moderationContentUnavailable,
        style: context.typography.bodySm.copyWith(color: colors.textMuted),
      ),
      data: (video) {
        if (video == null) {
          return Text(
            l10n.moderationContentDeleted,
            style: context.typography.bodySm.copyWith(
              color: colors.textMuted,
              fontStyle: FontStyle.italic,
            ),
          );
        }
        final thumbnailUrl = video.thumbnailUrl;
        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 52,
                height: 52,
                child: thumbnailUrl == null
                    ? Container(
                        color: colors.bg850,
                        child: Icon(
                          Symbols.videocam,
                          color: colors.textMuted,
                        ),
                      )
                    : Image.network(
                        thumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          color: colors.bg850,
                          child: Icon(
                            Symbols.videocam,
                            color: colors.textMuted,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '@${video.uploaderNickname}',
                style: context.typography.bodySm,
              ),
            ),
          ],
        );
      },
    );
  }
}
