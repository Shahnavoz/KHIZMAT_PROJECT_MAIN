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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `RU`
  String get ru {
    return Intl.message('RU', name: 'ru', desc: '', args: []);
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

  /// `Can't log in?`
  String get ne_udayotsa_voyti {
    return Intl.message(
      'Can\'t log in?',
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

  /// `Applications`
  String get allApplications {
    return Intl.message(
      'Applications',
      name: 'allApplications',
      desc: '',
      args: [],
    );
  }

  /// `Search for services`
  String get poisk_uslug {
    return Intl.message(
      'Search for services',
      name: 'poisk_uslug',
      desc: '',
      args: [],
    );
  }

  /// `All categories`
  String get allCategories {
    return Intl.message(
      'All categories',
      name: 'allCategories',
      desc: '',
      args: [],
    );
  }

  /// `Service categories`
  String get serviceCategories {
    return Intl.message(
      'Service categories',
      name: 'serviceCategories',
      desc: '',
      args: [],
    );
  }

  /// `No applications`
  String get noApplication {
    return Intl.message(
      'No applications',
      name: 'noApplication',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Successfully reviewed`
  String get seenSuccessfully {
    return Intl.message(
      'Successfully reviewed',
      name: 'seenSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Under review`
  String get naRasmotrenii {
    return Intl.message(
      'Under review',
      name: 'naRasmotrenii',
      desc: '',
      args: [],
    );
  }

  /// `In the process of filling`
  String get inFillingProcess {
    return Intl.message(
      'In the process of filling',
      name: 'inFillingProcess',
      desc: '',
      args: [],
    );
  }

  /// `Applications`
  String get applications {
    return Intl.message(
      'Applications',
      name: 'applications',
      desc: '',
      args: [],
    );
  }

  /// `In the process of payment`
  String get InPaymentProcess {
    return Intl.message(
      'In the process of payment',
      name: 'InPaymentProcess',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected {
    return Intl.message('Rejected', name: 'rejected', desc: '', args: []);
  }

  /// `Review period expired`
  String get reviewPeriodExpired {
    return Intl.message(
      'Review period expired',
      name: 'reviewPeriodExpired',
      desc: '',
      args: [],
    );
  }

  /// `Application was withdrawn`
  String get applicationWasWithdrawn {
    return Intl.message(
      'Application was withdrawn',
      name: 'applicationWasWithdrawn',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Not signed`
  String get notAssigned {
    return Intl.message('Not signed', name: 'notAssigned', desc: '', args: []);
  }

  /// `Expired`
  String get hasExpired {
    return Intl.message('Expired', name: 'hasExpired', desc: '', args: []);
  }

  /// `Search documents and applications`
  String get searchDocsAndApplications {
    return Intl.message(
      'Search documents and applications',
      name: 'searchDocsAndApplications',
      desc: '',
      args: [],
    );
  }

  /// `My Documents`
  String get myDocuments {
    return Intl.message(
      'My Documents',
      name: 'myDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `No documents`
  String get noDocuments {
    return Intl.message(
      'No documents',
      name: 'noDocuments',
      desc: '',
      args: [],
    );
  }

  /// `All documents`
  String get allDocuments {
    return Intl.message(
      'All documents',
      name: 'allDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Start searching!`
  String get startSearching {
    return Intl.message(
      'Start searching!',
      name: 'startSearching',
      desc: '',
      args: [],
    );
  }

  /// `Nothing found`
  String get nothingFound {
    return Intl.message(
      'Nothing found',
      name: 'nothingFound',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Services`
  String get services {
    return Intl.message('Services', name: 'services', desc: '', args: []);
  }

  /// `Government organizations`
  String get gosOrganizations {
    return Intl.message(
      'Government organizations',
      name: 'gosOrganizations',
      desc: '',
      args: [],
    );
  }

  /// `Search organizations`
  String get searchOrganization {
    return Intl.message(
      'Search organizations',
      name: 'searchOrganization',
      desc: '',
      args: [],
    );
  }

  /// `Organizations not found`
  String get notFoundOrgs {
    return Intl.message(
      'Organizations not found',
      name: 'notFoundOrgs',
      desc: '',
      args: [],
    );
  }

  /// `{count} services`
  String orgdocumentscount(int count) {
    return Intl.message(
      '$count services',
      name: 'orgdocumentscount',
      desc: '',
      args: [count],
    );
  }

  /// `No services`
  String get noServices {
    return Intl.message('No services', name: 'noServices', desc: '', args: []);
  }

  /// `Main`
  String get main {
    return Intl.message('Main', name: 'main', desc: '', args: []);
  }

  /// `Documents`
  String get documents {
    return Intl.message('Documents', name: 'documents', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Step {position} of {count}`
  String inFillingProcessStep(int position, int count) {
    return Intl.message(
      'Step $position of $count',
      name: 'inFillingProcessStep',
      desc: '',
      args: [position, count],
    );
  }

  /// `Registration Date: {registrationDate}`
  String filtereddocumentsindexregistrationdate(String registrationDate) {
    return Intl.message(
      'Registration Date: $registrationDate',
      name: 'filtereddocumentsindexregistrationdate',
      desc: '',
      args: [registrationDate],
    );
  }

  /// `My applications`
  String get myApplications {
    return Intl.message(
      'My applications',
      name: 'myApplications',
      desc: '',
      args: [],
    );
  }

  /// `In detail`
  String get podrobnee {
    return Intl.message('In detail', name: 'podrobnee', desc: '', args: []);
  }

  /// `Collapse`
  String get svernut {
    return Intl.message('Collapse', name: 'svernut', desc: '', args: []);
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
