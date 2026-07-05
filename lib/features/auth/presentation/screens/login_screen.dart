import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../data/auth_repository.dart';

/// Mirrors `ui_kits/mobile/LoginScreen.jsx` from the design project.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final TapGestureRecognizer _signupRecognizer;

  bool _obscurePassword = true;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _signupRecognizer = TapGestureRecognizer()..onTap = _showComingSoon;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signupRecognizer.dispose();
    super.dispose();
  }

  Future<void> _submitEmailPassword() async {
    setState(() => _submitting = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .signInWithEmailPassword(
            _emailController.text.trim(),
            _passwordController.text,
          );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? e.code);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _submitGoogle() async {
    setState(() => _submitting = true);
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
    } catch (e) {
      _showError('$e');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showComingSoon() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).comingSoon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: ColoredBox(color: colors.surface800)),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 0.26, 0.6, 1],
                  colors: [
                    colors.blue500.withValues(alpha: .25),
                    colors.bg850.withValues(alpha: .25),
                    colors.bg850.withValues(alpha: .8),
                    colors.bg850,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(26, 20, 26, 34),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: (constraints.maxHeight - 20 - 34).clamp(
                      0.0,
                      double.infinity,
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  style: context.typography.displayXl.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 0.9,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '3',
                                      style: TextStyle(
                                        color: colors.colorAction,
                                      ),
                                    ),
                                    const TextSpan(text: 'xtreme Riders'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                l10n.loginTagline,
                                style: GoogleFonts.oswald(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  letterSpacing: 15 * 0.22,
                                  color: colors.colorBrand,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 280,
                                child: Text(
                                  l10n.loginSubtitle,
                                  style: context.typography.body.copyWith(
                                    color: colors.textMuted,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppTextField(
                              controller: _emailController,
                              placeholder: l10n.loginEmailPlaceholder,
                              icon: Symbols.mail,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 11),
                            AppTextField(
                              controller: _passwordController,
                              placeholder: l10n.loginPasswordPlaceholder,
                              icon: Symbols.lock,
                              trailingIcon: _obscurePassword
                                  ? Symbols.visibility
                                  : Symbols.visibility_off,
                              onTrailingTap: () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                              obscureText: _obscurePassword,
                            ),
                            const SizedBox(height: 5),
                            AppButton(
                              label: l10n.loginButton,
                              onPressed: _submitting
                                  ? null
                                  : _submitEmailPassword,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: colors.hairlineStrong,
                                      height: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      l10n.loginDivider,
                                      style: context.typography.meta,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: colors.hairlineStrong,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: _SocialButton(
                                    label: 'Google',
                                    mark: 'G',
                                    color: const Color(0xFF4285F4),
                                    onTap: _submitting ? null : _submitGoogle,
                                  ),
                                ),
                                const SizedBox(width: 11),
                                Expanded(
                                  child: _SocialButton(
                                    label: 'Facebook',
                                    mark: 'f',
                                    color: const Color(0xFF1877F2),
                                    onTap: _showComingSoon,
                                  ),
                                ),
                                const SizedBox(width: 11),
                                Expanded(
                                  child: _SocialButton(
                                    label: 'Hotmail',
                                    mark: '@',
                                    color: colors.teal500,
                                    onTap: _showComingSoon,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: context.typography.bodySm.copyWith(
                                    color: colors.textMuted,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${l10n.loginSignupPrompt} ',
                                    ),
                                    TextSpan(
                                      text: l10n.loginSignupCta,
                                      style: TextStyle(
                                        color: colors.colorAction,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      recognizer: _signupRecognizer,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.mark,
    required this.color,
    required this.onTap,
  });

  final String label;
  final String mark;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(spacing.radiusMd),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: colors.surfaceCard,
          border: Border.all(color: colors.hairlineStrong),
          borderRadius: BorderRadius.circular(spacing.radiusMd),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mark,
              style: GoogleFonts.oswald(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: color,
              ),
            ),
            const SizedBox(width: 7),
            Text(label, style: context.typography.meta),
          ],
        ),
      ),
    );
  }
}
