import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../application/auth_providers.dart';
import '../../data/auth_repository.dart';

/// Real email/password registration form — the previous "Crear cuenta" link
/// on [LoginScreen] just showed a "coming soon" snackbar. Same visual shell
/// as `LoginScreen` (background gradient, `AppTextField`/`AppButton`), plus
/// the name/last name/nickname fields the backend's `RiderCreate` schema
/// requires. See `PendingSignupProfile` for why those get stashed in a
/// provider before Firebase account creation rather than sent directly.
class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final TapGestureRecognizer _loginRecognizer;

  bool _obscurePassword = true;
  bool _submitting = false;
  bool _showErrors = false;

  @override
  void initState() {
    super.initState();
    _loginRecognizer = TapGestureRecognizer()..onTap = () => context.pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _loginRecognizer.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _nameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _nicknameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty;

  Future<void> _submit() async {
    setState(() => _showErrors = true);
    if (!_isValid || _submitting) return;

    setState(() => _submitting = true);
    try {
      ref
          .read(pendingSignupProfileProvider.notifier)
          .set(
            _nameController.text.trim(),
            _lastNameController.text.trim(),
            _nicknameController.text.trim(),
          );
      await ref
          .read(authRepositoryProvider)
          .signUpWithEmailPassword(
            _emailController.text.trim(),
            _passwordController.text,
          );
      // The router redirects to /home on its own once Firebase's auth
      // state flips, same as LoginScreen never navigating manually either.
    } on FirebaseAuthException catch (e) {
      ref.read(pendingSignupProfileProvider.notifier).clear();
      _showError(e.message ?? e.code);
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(26, 12, 26, 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppIconButton(
                    icon: Symbols.arrow_back,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    l10n.signupTitle,
                    style: context.typography.displayXl.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.signupSubtitle,
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      letterSpacing: 14 * 0.1,
                      color: colors.colorBrand,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                    controller: _nameController,
                    placeholder: l10n.signupNamePlaceholder,
                    icon: Symbols.badge,
                  ),
                  if (_showErrors && _nameController.text.trim().isEmpty)
                    _ErrorText(l10n.signupFieldRequired),
                  const SizedBox(height: 11),
                  AppTextField(
                    controller: _lastNameController,
                    placeholder: l10n.signupLastNamePlaceholder,
                    icon: Symbols.badge,
                  ),
                  if (_showErrors && _lastNameController.text.trim().isEmpty)
                    _ErrorText(l10n.signupFieldRequired),
                  const SizedBox(height: 11),
                  AppTextField(
                    controller: _nicknameController,
                    placeholder: l10n.signupNicknamePlaceholder,
                    icon: Symbols.alternate_email,
                  ),
                  if (_showErrors && _nicknameController.text.trim().isEmpty)
                    _ErrorText(l10n.signupFieldRequired),
                  const SizedBox(height: 11),
                  AppTextField(
                    controller: _emailController,
                    placeholder: l10n.loginEmailPlaceholder,
                    icon: Symbols.mail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  if (_showErrors && _emailController.text.trim().isEmpty)
                    _ErrorText(l10n.signupFieldRequired),
                  const SizedBox(height: 11),
                  AppTextField(
                    controller: _passwordController,
                    placeholder: l10n.loginPasswordPlaceholder,
                    icon: Symbols.lock,
                    trailingIcon: _obscurePassword
                        ? Symbols.visibility
                        : Symbols.visibility_off,
                    onTrailingTap: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    obscureText: _obscurePassword,
                  ),
                  if (_showErrors && _passwordController.text.isEmpty)
                    _ErrorText(l10n.signupFieldRequired),
                  const SizedBox(height: 20),
                  AppButton(
                    label: _submitting ? '…' : l10n.signupButton,
                    onPressed: _submitting ? null : _submit,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: context.typography.bodySm.copyWith(
                          color: colors.textMuted,
                        ),
                        children: [
                          TextSpan(text: '${l10n.signupLoginPrompt} '),
                          TextSpan(
                            text: l10n.signupLoginCta,
                            style: TextStyle(
                              color: colors.colorAction,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: _loginRecognizer,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: context.typography.micro.copyWith(
          color: context.colors.colorDanger,
        ),
      ),
    );
  }
}
