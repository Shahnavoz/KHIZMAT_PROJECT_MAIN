// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `RU`
  String get ru {
    return Intl.message(
      'RU',
      name: 'ru',
      desc: '',
      args: [],
    );
  }

  /// `Get services without leaving your home`
  String get poluchay_uslugi_ne_vikhodya_iz_doma {
    return Intl.message(
      'Get services without leaving your home',
      name: 'poluchay_uslugi_ne_vikhodya_iz_doma',
      desc: '',
      args: [],
    );
  }

  /// `Log in to the app`
  String get proizvesti_vkhod {
    return Intl.message(
      'Log in to the app',
      name: 'proizvesti_vkhod',
      desc: '',
      args: [],
    );
  }

  /// `To access the mobile app, log in using the IMZO service.`
  String get cherez_imzo {
    return Intl.message(
      'To access the mobile app, log in using the IMZO service.',
      name: 'cherez_imzo',
      desc: '',
      args: [],
    );
  }

  /// `Log in with IMZO`
  String get voyti_cherez_imzo {
    return Intl.message(
      'Log in with IMZO',
      name: 'voyti_cherez_imzo',
      desc: '',
      args: [],
    );
  }

  /// `Main questions`
  String get osnovniye_voprosi {
    return Intl.message(
      'Main questions',
      name: 'osnovniye_voprosi',
      desc: '',
      args: [],
    );
  }

  /// `Can’t log in?`
  String get ne_udayotsa_voyti {
    return Intl.message(
      'Can’t log in?',
      name: 'ne_udayotsa_voyti',
      desc: '',
      args: [],
    );
  }

  /// `© 2024-2025 JSC "Certification Centers, Public Services and Digital Software Development"`
  String get bottom_text {
    return Intl.message(
      '© 2024-2025 JSC "Certification Centers, Public Services and Digital Software Development"',
      name: 'bottom_text',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
