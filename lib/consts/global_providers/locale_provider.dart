import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Nash LocaleProvider
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(Locale("ru"));

  void setLocale(Locale locale) {
    state = locale;
  }
}

String getLanguageName(String code,context) {
  switch (code) {
    case 'ru':
      return "RU";
    case 'en':
      return 'EN';
    case 'fr':
      return 'TJ';
    default:
      return "";
  }

  
}

// String get languageName=>_getLanguageName(code);
