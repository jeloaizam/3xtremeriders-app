// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's manual language override. `null` means "follow the device
/// locale" (the default) — set explicitly from Settings to pin a language.

@ProviderFor(AppLocale)
final appLocaleProvider = AppLocaleProvider._();

/// The user's manual language override. `null` means "follow the device
/// locale" (the default) — set explicitly from Settings to pin a language.
final class AppLocaleProvider extends $NotifierProvider<AppLocale, Locale?> {
  /// The user's manual language override. `null` means "follow the device
  /// locale" (the default) — set explicitly from Settings to pin a language.
  AppLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocaleHash();

  @$internal
  @override
  AppLocale create() => AppLocale();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale?>(value),
    );
  }
}

String _$appLocaleHash() => r'9168ee327c50176bd6fba5326f52037bfda0ecf8';

/// The user's manual language override. `null` means "follow the device
/// locale" (the default) — set explicitly from Settings to pin a language.

abstract class _$AppLocale extends $Notifier<Locale?> {
  Locale? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Locale?, Locale?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale?, Locale?>,
              Locale?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
