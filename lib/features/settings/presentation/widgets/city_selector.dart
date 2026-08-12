import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../l10n/gen/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/city_api.dart';

/// Sentinel dropdown value for "Otra ciudad" — no real city ever has this id.
const _otherCityId = -1;

/// City field for a rider's profile, cascading off a chosen country —
/// shared by `SettingsScreen` and `CompleteProfileScreen`. The `city`
/// catalog (`citiesProvider`) only covers a curated list of countries/cities
/// (see the seed migrations); for any other country it resolves to an empty
/// list, and this falls back to a free-text field (`cityTextController`)
/// instead of rendering a dropdown with zero options — an empty-items
/// `AppDropdown` isn't a real usable control, so showing one there just
/// traps the rider. Even when the catalog isn't empty, the rider's actual
/// city might not be in the curated list, so the dropdown always carries an
/// "Otra ciudad" option that switches to the same free-text field.
class CitySelector extends ConsumerStatefulWidget {
  const CitySelector({
    super.key,
    required this.countryId,
    required this.cityId,
    required this.cityTextController,
    required this.onCityIdChanged,
  });

  final int? countryId;
  final int? cityId;
  final TextEditingController cityTextController;
  final ValueChanged<int?> onCityIdChanged;

  @override
  ConsumerState<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends ConsumerState<CitySelector> {
  late bool _manualEntry =
      widget.cityId == null && widget.cityTextController.text.trim().isNotEmpty;

  @override
  void didUpdateWidget(CitySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countryId != widget.countryId) {
      // A country switch already clears cityId/cityTextController upstream —
      // drop back to the dropdown so a leftover "Otra ciudad" mode from the
      // previous country doesn't stick around for the new one.
      _manualEntry = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final countryId = widget.countryId;

    if (countryId == null) {
      return const AppDropdown<int>(
        icon: Symbols.location_city,
        value: null,
        items: [],
        onChanged: null,
        extraVerticalPadding: 10,
      );
    }

    final citiesAsync = ref.watch(citiesProvider(countryId));
    return citiesAsync.when(
      loading: () => const LinearProgressIndicator(),
      error: (error, _) => Text('$error'),
      data: (cities) {
        if (cities.isEmpty || _manualEntry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: widget.cityTextController,
                placeholder: l10n.settingsCityLabel,
                icon: Symbols.location_city,
                extraVerticalPadding: 10,
              ),
              if (cities.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _manualEntry = false;
                      widget.cityTextController.clear();
                      widget.onCityIdChanged(null);
                    }),
                    child: Text(
                      l10n.citySelectorBackToList,
                      style: context.typography.meta.copyWith(
                        color: colors.colorAction,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }
        return AppDropdown<int>(
          icon: Symbols.location_city,
          placeholder: l10n.settingsCityLabel,
          value: widget.cityId,
          extraVerticalPadding: 10,
          items: [
            for (final city in cities)
              DropdownMenuItem(value: city.id, child: Text(city.name)),
            DropdownMenuItem(
              value: _otherCityId,
              child: Text(l10n.citySelectorOtherOption),
            ),
          ],
          onChanged: (id) {
            if (id == _otherCityId) {
              setState(() => _manualEntry = true);
              widget.onCityIdChanged(null);
            } else {
              widget.onCityIdChanged(id);
            }
          },
        );
      },
    );
  }
}
