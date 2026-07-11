import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../l10n/gen/app_localizations.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/city_api.dart';

/// City field for a rider's profile, cascading off a chosen country —
/// shared by `SettingsScreen` and `CompleteProfileScreen`. The `city`
/// catalog (`citiesProvider`) only covers 16 countries (see the seed
/// migration); for any other country it resolves to an empty list, and
/// this falls back to a free-text field (`cityTextController`) instead of
/// rendering a dropdown with zero options — an empty-items `AppDropdown`
/// isn't a real usable control, so showing one there just traps the rider.
class CitySelector extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final countryId = this.countryId;

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
        if (cities.isEmpty) {
          return AppTextField(
            controller: cityTextController,
            placeholder: l10n.settingsCityLabel,
            icon: Symbols.location_city,
            extraVerticalPadding: 10,
          );
        }
        return AppDropdown<int>(
          icon: Symbols.location_city,
          placeholder: l10n.settingsCityLabel,
          value: cityId,
          extraVerticalPadding: 10,
          items: [
            for (final city in cities)
              DropdownMenuItem(value: city.id, child: Text(city.name)),
          ],
          onChanged: onCityIdChanged,
        );
      },
    );
  }
}
