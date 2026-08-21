import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/map/mapbox_geocoding_api.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../l10n/gen/app_localizations.dart';

/// City field for a rider's profile, backed by Mapbox's search-as-you-type
/// geocoding rather than the old static `City` dropdown — replaces
/// `CitySelector`. Typing debounces into a text search scoped to
/// [countryIsoCode] (so "Sant..." under Spain doesn't surface Chilean
/// results); only tapping a suggestion actually sets a value, so whatever
/// ends up saved is always a Mapbox-canonical name the backend can
/// resolve-or-create a real `City` row for (see `crud_city
/// .resolve_or_create`) — free-typed text that was never confirmed against
/// a suggestion is deliberately not accepted, since an uncanonical name
/// defeats the whole point of a catalog other screens can filter by.
class CitySearchField extends ConsumerStatefulWidget {
  const CitySearchField({
    super.key,
    required this.countryIsoCode,
    required this.cityName,
    required this.onCityNameChanged,
  });

  final String? countryIsoCode;
  final String? cityName;
  final ValueChanged<String?> onCityNameChanged;

  @override
  ConsumerState<CitySearchField> createState() => _CitySearchFieldState();
}

class _CitySearchFieldState extends ConsumerState<CitySearchField> {
  late final _controller = TextEditingController(text: widget.cityName ?? '');
  Timer? _debounce;
  List<GeocodedPlace> _suggestions = [];
  bool _searching = false;

  @override
  void didUpdateWidget(CitySearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A country switch already clears the parent's cityName — drop any
    // suggestions/text left over from the previous country too.
    if (oldWidget.countryIsoCode != widget.countryIsoCode) {
      _controller.clear();
      setState(() => _suggestions = []);
    } else if (widget.cityName != oldWidget.cityName &&
        widget.cityName != _controller.text) {
      _controller.text = widget.cityName ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    // Typing invalidates whatever was picked before, until a suggestion is
    // tapped again — see the class doc for why free text alone never
    // becomes the saved value.
    widget.onCityNameChanged(null);
    _debounce?.cancel();
    final countryIsoCode = widget.countryIsoCode;
    if (value.trim().isEmpty || countryIsoCode == null) {
      setState(() => _suggestions = []);
      return;
    }
    _debounce = Timer(
      const Duration(milliseconds: 400),
      () => _search(value, countryIsoCode),
    );
  }

  Future<void> _search(String query, String countryIsoCode) async {
    setState(() => _searching = true);
    final results = await ref
        .read(mapboxGeocodingApiProvider)
        .search(query, countryIsoCode: countryIsoCode);
    if (!mounted) return;
    setState(() {
      _suggestions = results;
      _searching = false;
    });
  }

  void _select(GeocodedPlace place) {
    _controller.text = place.cityName;
    _controller.selection = TextSelection.collapsed(
      offset: _controller.text.length,
    );
    setState(() => _suggestions = []);
    widget.onCityNameChanged(place.cityName);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final enabled = widget.countryIsoCode != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: _controller,
          enabled: enabled,
          placeholder: l10n.settingsCityLabel,
          icon: Symbols.location_city,
          extraVerticalPadding: 10,
          onChanged: _onChanged,
        ),
        if (_searching)
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: LinearProgressIndicator(),
          ),
        if (!_searching && _suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: colors.surfaceCard,
              border: Border.all(color: colors.hairlineStrong),
              borderRadius: BorderRadius.circular(context.spacing.radiusMd),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final place in _suggestions)
                  InkWell(
                    onTap: () => _select(place),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Text(
                        '${place.cityName}, ${place.countryName}',
                        style: context.typography.body,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
