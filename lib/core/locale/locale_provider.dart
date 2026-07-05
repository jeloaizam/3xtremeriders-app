import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_provider.g.dart';

const _localePrefKey = 'app_locale';

/// Loads the persisted locale override before `runApp`, so [AppLocale] can
/// be seeded synchronously via a provider override — Notifiers build
/// synchronously, so without this the app would briefly show the wrong
/// locale while `SharedPreferences` loads asynchronously.
Future<Locale?> loadPersistedLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final code = prefs.getString(_localePrefKey);
  return code == null ? null : Locale(code);
}

/// The user's manual language override. `null` means "follow the device
/// locale" (the default) — set explicitly from Settings to pin a language.
@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale? build() => null;

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(_localePrefKey);
    } else {
      await prefs.setString(_localePrefKey, locale.languageCode);
    }
  }
}
