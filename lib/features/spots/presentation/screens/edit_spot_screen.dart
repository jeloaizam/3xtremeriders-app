import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/spot_detail.dart';
import '../../application/spots_providers.dart';
import '../../data/spot_api.dart';

const _seasonOptions = [
  'Todo el año',
  'Temporada seca',
  'Temporada de lluvias',
];

const _difficultyLabels = {
  1: '1 · Principiante',
  2: '2 · Básico',
  3: '3 · Intermedio',
  4: '4 · Avanzado',
  5: '5 · Experto',
};

/// Edits an existing [Spot]'s own fields — name, description, difficulty,
/// best season — plus lets an owner or admin delete it outright. Mirrors
/// `EditRideScreen`'s structure/scope; location, sports and media stay
/// out of scope here (same as `SpotUpdate` on the backend, which doesn't
/// support changing those after creation).
class EditSpotScreen extends ConsumerStatefulWidget {
  const EditSpotScreen({super.key, required this.spotId});

  final int spotId;

  @override
  ConsumerState<EditSpotScreen> createState() => _EditSpotScreenState();
}

class _EditSpotScreenState extends ConsumerState<EditSpotScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  int? _difficulty;
  String? _bestSeason;
  bool _seeded = false;
  bool _saving = false;
  bool _deleting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _seed(SpotDetailData detail) {
    if (_seeded) return;
    _nameController.text = detail.spot.name;
    _descriptionController.text = detail.spot.description;
    _difficulty = detail.spot.difficulty;
    _bestSeason = detail.spot.bestSeason;
    _seeded = true;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(spotApiProvider)
          .update(
            spotId: widget.spotId,
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            difficulty: _difficulty,
            bestSeason: _bestSeason,
            idToken: idToken,
          );

      ref.invalidate(spotDetailProvider(widget.spotId));
      ref.invalidate(nearbySpotsProvider);
      if (mounted) context.pop();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _confirmDelete() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: context.colors.surfaceCard,
        title: Text(
          l10n.spotDeleteConfirmTitle,
          style: context.typography.title,
        ),
        content: Text(l10n.spotDeleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.dialogCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.spotDelete,
              style: TextStyle(color: context.colors.colorDanger),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _deleting = true);
    try {
      final idToken = await ref
          .read(firebaseAuthProvider)
          .currentUser
          ?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(spotApiProvider)
          .delete(spotId: widget.spotId, idToken: idToken);

      ref.invalidate(nearbySpotsProvider);
      if (mounted) {
        // Pop back past the now-deleted spot's own SpotScreen (not
        // `context.go('/home')`, which would replace the whole navigation
        // stack and strand it out of the back history).
        final navigator = Navigator.of(context);
        navigator.pop();
        navigator.pop();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final detailAsync = ref.watch(spotDetailProvider(widget.spotId));

    return Scaffold(
      body: SafeArea(
        child: detailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (detail) {
            _seed(detail);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
                  child: Row(
                    children: [
                      AppIconButton(
                        icon: Symbols.close,
                        onPressed: () => context.pop(),
                      ),
                      const SizedBox(width: 14),
                      Text(l10n.spotEdit, style: context.typography.displaySm),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(18, 4, 18, 20),
                    children: [
                      _SectionLabel(l10n.createSpotNameLabel),
                      AppTextField(
                        controller: _nameController,
                        placeholder: l10n.createSpotNamePlaceholder,
                      ),

                      _SectionLabel(l10n.createSpotDescriptionLabel, top: 18),
                      AppTextField(
                        controller: _descriptionController,
                        placeholder: l10n.createSpotDescriptionPlaceholder,
                        multiline: true,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _SectionLabel(
                                  l10n.createSpotDifficultyLabel,
                                  top: 18,
                                ),
                                AppDropdown<int>(
                                  value: _difficulty,
                                  placeholder: '—',
                                  items: [
                                    for (final entry
                                        in _difficultyLabels.entries)
                                      DropdownMenuItem(
                                        value: entry.key,
                                        child: Text(entry.value),
                                      ),
                                  ],
                                  onChanged: (value) =>
                                      setState(() => _difficulty = value),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _SectionLabel(
                                  l10n.createSpotSeasonLabel,
                                  top: 18,
                                ),
                                AppDropdown<String>(
                                  value: _bestSeason,
                                  placeholder: '—',
                                  items: [
                                    for (final season in _seasonOptions)
                                      DropdownMenuItem(
                                        value: season,
                                        child: Text(season),
                                      ),
                                  ],
                                  onChanged: (value) =>
                                      setState(() => _bestSeason = value),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: _deleting ? null : _confirmDelete,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Symbols.delete,
                              size: 18,
                              color: context.colors.colorDanger,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.spotDelete,
                              style: context.typography.title.copyWith(
                                color: context.colors.colorDanger,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceApp,
                    border: Border(
                      top: BorderSide(color: context.colors.hairlineSoft),
                    ),
                  ),
                  child: AppButton(
                    label: _saving ? '…' : l10n.settingsSave,
                    onPressed: _saving ? null : _save,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label, {this.top = 8});

  final String label;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: 8),
      child: Text(
        label,
        style: context.typography.eyebrow.copyWith(
          color: context.colors.textMuted,
        ),
      ),
    );
  }
}
