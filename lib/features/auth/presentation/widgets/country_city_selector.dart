import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../settings/data/country_api.dart';
import '../../../settings/domain/country.dart';
import '../../../settings/presentation/widgets/city_search_field.dart';

/// Country dropdown + Mapbox-backed city search, shared by `SignupScreen`
/// and `CompleteProfileScreen` — both screens need the same pair (city is
/// scoped to whichever country is picked, see `CitySearchField`).
class CountryCitySelector extends ConsumerWidget {
  const CountryCitySelector({
    super.key,
    required this.countryId,
    required this.cityName,
    required this.onCountryChanged,
    required this.onCityChanged,
    this.showErrors = false,
  });

  final int? countryId;
  final String? cityName;
  final ValueChanged<int?> onCountryChanged;
  final ValueChanged<String?> onCityChanged;
  final bool showErrors;

  static String? _isoCodeFor(List<Country>? countries, int? countryId) {
    if (countries == null || countryId == null) return null;
    for (final country in countries) {
      if (country.id == countryId) return country.isoCode;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final countriesAsync = ref.watch(countriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        countriesAsync.when(
          loading: () => const LinearProgressIndicator(),
          error: (error, _) => Text('$error'),
          data: (countries) => AppDropdown<int>(
            icon: Symbols.public,
            placeholder: l10n.settingsCountryLabel,
            value: countryId,
            extraVerticalPadding: 10,
            items: [
              for (final country in countries)
                DropdownMenuItem(value: country.id, child: Text(country.name)),
            ],
            onChanged: onCountryChanged,
          ),
        ),
        if (showErrors && countryId == null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              l10n.signupFieldRequired,
              style: context.typography.micro.copyWith(
                color: colors.colorDanger,
              ),
            ),
          ),
        const SizedBox(height: 11),
        CitySearchField(
          countryIsoCode: _isoCodeFor(countriesAsync.value, countryId),
          cityName: cityName,
          onCityNameChanged: onCityChanged,
        ),
        if (showErrors && cityName == null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              l10n.signupFieldRequired,
              style: context.typography.micro.copyWith(
                color: colors.colorDanger,
              ),
            ),
          ),
      ],
    );
  }
}
