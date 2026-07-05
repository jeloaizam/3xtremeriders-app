import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

enum AppAvatarSize { sm, md, lg, xl }

/// Circular avatar with a monogram fallback on the brand gradient.
/// Mirrors `components/core/Avatar.jsx` from the design system.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.initial,
    this.imageUrl,
    this.size = AppAvatarSize.md,
    this.squircle = false,
  });

  final String initial;
  final String? imageUrl;
  final AppAvatarSize size;
  final bool squircle;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final dim = switch (size) {
      AppAvatarSize.sm => spacing.avatarSm,
      AppAvatarSize.md => spacing.avatarMd,
      AppAvatarSize.lg => spacing.avatarLg,
      AppAvatarSize.xl => spacing.avatarXl,
    };
    final fontSize = switch (size) {
      AppAvatarSize.sm => 13.0,
      AppAvatarSize.md => 15.0,
      AppAvatarSize.lg => 19.0,
      AppAvatarSize.xl => 34.0,
    };

    return Container(
      width: dim,
      height: dim,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(squircle ? 22 : dim / 2),
        gradient: imageUrl == null ? AppColors.brandGradient : null,
        image: imageUrl != null
            ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
            : null,
      ),
      alignment: Alignment.center,
      child: imageUrl == null
          ? Text(
              initial,
              style: GoogleFonts.oswald(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
