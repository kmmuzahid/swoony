// state.dart
import 'dart:ui';

class LanguageState {
  const LanguageState({
    required this.selectedCountry,
    required this.availableCountries,
    required this.locale,
  });
  final MapEntry<String, String> selectedCountry;
  final Map<String, String> availableCountries;
  final Locale locale;

  LanguageState copyWith({MapEntry<String, String>? selectedCountry, Locale? locale}) {
    return LanguageState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      availableCountries: availableCountries,
      locale: locale ?? this.locale,
    );
  }
}
