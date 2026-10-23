import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../core/widgets/app_avatar.dart';
import '../../../../../../l10n/gen/app_localizations.dart';
import '../../../../../moderation/presentation/widgets/report_dialog.dart';
import '../../../../../auth/application/auth_providers.dart';
import '../../../../application/spot_detail.dart';
import '../../../../application/spot_detail_providers.dart';
import '../../../../data/spot_comment_api.dart';

/// `MoreInfoBox`'s "Comentarios" tab: the comment thread + composer.
class CommentsTab extends StatelessWidget {
  const CommentsTab({super.key, required this.spotId, required this.comments});

  final int spotId;
  final List<SpotCommentWithAuthor> comments;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.spotCommentsTitle(comments.length),
            style: context.typography.tag.copyWith(color: colors.text300),
          ),
          const SizedBox(height: 12),
          if (comments.isEmpty)
            Text(l10n.spotNoComments, style: context.typography.bodySm)
          else
            for (final entry in comments) _CommentRow(entry: entry),
          const SizedBox(height: 12),
          _CommentComposer(spotId: spotId),
        ],
      ),
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({required this.entry});

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
                    const Spacer(),
                    GestureDetector(
                      onTap: () => ReportDialog.show(
                        context,
                        targetType: 'comment',
                        targetId: comment.id,
                      ),
                      child: Icon(
                        Symbols.flag,
                        size: 15,
                        color: colors.textMuted,
                      ),
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
  const _CommentComposer({required this.spotId});

  final int spotId;

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
            targetType: 'spot',
            targetId: widget.spotId,
            body: body,
            idToken: idToken,
          );
      _controller.clear();
      ref.invalidate(spotDetailProvider(widget.spotId));
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
