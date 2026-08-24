import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/media_comments.dart';
import '../../application/spot_detail.dart';
import '../../data/spot_comment_api.dart';

/// Comment thread for anything the backend's polymorphic `/comments`
/// endpoint supports — the photo/video detail screens' equivalent of the
/// comment list + composer already built into `SpotScreen` (kept separate
/// from that one since it's not tied to `spotDetailProvider`'s lifecycle).
class CommentSection extends ConsumerWidget {
  const CommentSection({
    super.key,
    required this.targetType,
    required this.targetId,
  });

  final String targetType;
  final int targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final commentsAsync = ref.watch(
      mediaCommentsProvider(targetType, targetId),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.mediaCommentsTitle(commentsAsync.value?.length ?? 0),
          style: context.typography.tag.copyWith(color: colors.text300),
        ),
        const SizedBox(height: 12),
        commentsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text('$error'),
          data: (comments) => comments.isEmpty
              ? Text(l10n.spotNoComments, style: context.typography.bodySm)
              : Column(
                  children: [
                    for (final entry in comments)
                      _MediaCommentRow(entry: entry),
                  ],
                ),
        ),
        const SizedBox(height: 12),
        _CommentComposer(targetType: targetType, targetId: targetId),
      ],
    );
  }
}

class _MediaCommentRow extends StatelessWidget {
  const _MediaCommentRow({required this.entry});

  final SpotCommentWithAuthor entry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final author = entry.author;
    final comment = entry.comment;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(
            initial: author.nickname.isNotEmpty
                ? author.nickname[0].toUpperCase()
                : '?',
            imageUrl: author.iconImage,
            size: AppAvatarSize.sm,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      author.nickname,
                      style: context.typography.title.copyWith(fontSize: 14),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      DateFormat.yMMMd(
                        Localizations.localeOf(context).toString(),
                      ).format(comment.createdDate),
                      style: context.typography.micro,
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(comment.body, style: context.typography.bodySm),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Symbols.favorite, size: 15, color: colors.textMuted),
                    const SizedBox(width: 5),
                    Text(
                      '${comment.voteCount}',
                      style: context.typography.meta,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentComposer extends ConsumerStatefulWidget {
  const _CommentComposer({required this.targetType, required this.targetId});

  final String targetType;
  final int targetId;

  @override
  ConsumerState<_CommentComposer> createState() => _CommentComposerState();
}

class _CommentComposerState extends ConsumerState<_CommentComposer> {
  final _controller = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final body = _controller.text.trim();
    if (body.isEmpty || _sending) return;

    final user = ref.read(firebaseAuthProvider).currentUser;
    final idToken = await user?.getIdToken();
    if (idToken == null) return;

    setState(() => _sending = true);
    try {
      await ref
          .read(spotCommentApiProvider)
          .create(
            targetType: widget.targetType,
            targetId: widget.targetId,
            body: body,
            idToken: idToken,
          );
      _controller.clear();
      ref.invalidate(mediaCommentsProvider(widget.targetType, widget.targetId));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        border: Border.all(color: colors.hairlineStrong),
        borderRadius: BorderRadius.circular(context.spacing.radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: context.typography.bodySm,
              decoration: InputDecoration(
                hintText: l10n.spotCommentPlaceholder,
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: _sending ? null : _send,
            icon: Icon(Symbols.send, color: colors.colorAction),
          ),
        ],
      ),
    );
  }
}
