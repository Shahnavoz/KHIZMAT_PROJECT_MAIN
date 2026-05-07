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

  /// `{years} (year)`
  String expiryDateYears(int years) {
    return Intl.message(
      '$years (year)',
      name: 'expiryDateYears',
      desc: '',
      args: [years],
    );
  }

  /// `Loading error: {error}`
  String errorLoading(String error) {
    return Intl.message(
      'Loading error: $error',
      name: 'errorLoading',
      desc: '',
      args: [error],
    );
  }

  /// `Receipt period: Online (instantly)`
  String get srokPolucheniyaOnline {
    return Intl.message(
      'Receipt period: Online (instantly)',
      name: 'srokPolucheniyaOnline',
      desc: '',
      args: [],
    );
  }

  /// `Receipt period: {days} days`
  String srokPolucheniyaDays(int days) {
    return Intl.message(
      'Receipt period: $days days',
      name: 'srokPolucheniyaDays',
      desc: '',
      args: [days],
    );
  }

  /// `Detail information`
  String get detailInformation {
    return Intl.message(
      'Detail information',
      name: 'detailInformation',
      desc: '',
      args: [],
    );
  }

  /// `Specializations`
  String get specialization {
    return Intl.message(
      'Specializations',
      name: 'specialization',
      desc: '',
      args: [],
    );
  }

  /// `Requirements`
  String get requirements {
    return Intl.message(
      'Requirements',
      name: 'requirements',
      desc: '',
      args: [],
    );
  }

  /// `Authorized body`
  String get authorizedBody {
    return Intl.message(
      'Authorized body',
      name: 'authorizedBody',
      desc: '',
      args: [],
    );
  }

  /// `Document type`
  String get documentType {
    return Intl.message(
      'Document type',
      name: 'documentType',
      desc: '',
      args: [],
    );
  }

  /// `Expiry date`
  String get expiryDate {
    return Intl.message('Expiry date', name: 'expiryDate', desc: '', args: []);
  }

  /// `Review and issuance period: `
  String get srokRassmotreniyeIPredostavleniyeUslugi {
    return Intl.message(
      'Review and issuance period: ',
      name: 'srokRassmotreniyeIPredostavleniyeUslugi',
      desc: '',
      args: [],
    );
  }

  /// `{reviewTime} days`
  String allinforeviewtime(String reviewTime) {
    return Intl.message(
      '$reviewTime days',
      name: 'allinforeviewtime',
      desc: '',
      args: [reviewTime],
    );
  }

  /// `Price:`
  String get price {
    return Intl.message('Price:', name: 'price', desc: '', args: []);
  }

  /// `Applicants`
  String get applicants {
    return Intl.message('Applicants', name: 'applicants', desc: '', args: []);
  }

  /// `State fee`
  String get feeState {
    return Intl.message('State fee', name: 'feeState', desc: '', args: []);
  }

  /// `Does not exist`
  String get dontExist {
    return Intl.message(
      'Does not exist',
      name: 'dontExist',
      desc: '',
      args: [],
    );
  }

  /// `Monthly fee`
  String get monthlyFee {
    return Intl.message('Monthly fee', name: 'monthlyFee', desc: '', args: []);
  }

  /// `Service regulation document`
  String get regulatingDocument {
    return Intl.message(
      'Service regulation document',
      name: 'regulatingDocument',
      desc: '',
      args: [],
    );
  }

  /// `Link to supporting document`
  String get linkToDocument {
    return Intl.message(
      'Link to supporting document',
      name: 'linkToDocument',
      desc: '',
      args: [],
    );
  }

  /// `Does not exist`
  String get dosntExist {
    return Intl.message(
      'Does not exist',
      name: 'dosntExist',
      desc: '',
      args: [],
    );
  }

  /// `Get service`
  String get poluchitUslugu {
    return Intl.message(
      'Get service',
      name: 'poluchitUslugu',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Continue`
  String get continueButton {
    return Intl.message('Continue', name: 'continueButton', desc: '', args: []);
  }

  /// `Go to Payment`
  String get goToPayment {
    return Intl.message(
      'Go to Payment',
      name: 'goToPayment',
      desc: '',
      args: [],
    );
  }

  /// `Fill again`
  String get fillAgain {
    return Intl.message('Fill again', name: 'fillAgain', desc: '', args: []);
  }

  /// `Please review and confirm all requirements`
  String get oznakomtesIpotverditeVseTrebovaniya {
    return Intl.message(
      'Please review and confirm all requirements',
      name: 'oznakomtesIpotverditeVseTrebovaniya',
      desc: '',
      args: [],
    );
  }

  /// `Hello, {name}`
  String greeting(String name) {
    return Intl.message(
      'Hello, $name',
      name: 'greeting',
      desc: '',
      args: [name],
    );
  }

  /// `Step № {step}`
  String shagNomer(int step) {
    return Intl.message(
      'Step № $step',
      name: 'shagNomer',
      desc: '',
      args: [step],
    );
  }

  /// `Verified profile`
  String get verifiedProfile {
    return Intl.message(
      'Verified profile',
      name: 'verifiedProfile',
      desc: '',
      args: [],
    );
  }

  /// `General settings`
  String get commonSettings {
    return Intl.message(
      'General settings',
      name: 'commonSettings',
      desc: '',
      args: [],
    );
  }

  /// `Language settings`
  String get languageSettings {
    return Intl.message(
      'Language settings',
      name: 'languageSettings',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `Where are we ?`
  String get whereAreWe {
    return Intl.message(
      'Where are we ?',
      name: 'whereAreWe',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privatePolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privatePolicy',
      desc: '',
      args: [],
    );
  }

  /// `Exit the App`
  String get exitTheApp {
    return Intl.message('Exit the App', name: 'exitTheApp', desc: '', args: []);
  }

  /// `Choose the map`
  String get chooseTheMap {
    return Intl.message(
      'Choose the map',
      name: 'chooseTheMap',
      desc: '',
      args: [],
    );
  }

  /// `There are no maps installed on the device.`
  String get notInstalledMap {
    return Intl.message(
      'There are no maps installed on the device.',
      name: 'notInstalledMap',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load document`
  String get failedToLoadDoc {
    return Intl.message(
      'Failed to load document',
      name: 'failedToLoadDoc',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get repeat {
    return Intl.message('Repeat', name: 'repeat', desc: '', args: []);
  }

  /// `Document is empty`
  String get docIsEmpty {
    return Intl.message(
      'Document is empty',
      name: 'docIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `The document has not yet been uploaded or is empty.`
  String get docIsNotLoadedOrEmpty {
    return Intl.message(
      'The document has not yet been uploaded or is empty.',
      name: 'docIsNotLoadedOrEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Document number`
  String get docNumber {
    return Intl.message(
      'Document number',
      name: 'docNumber',
      desc: '',
      args: [],
    );
  }

  /// `Registration date`
  String get registrationDate {
    return Intl.message(
      'Registration date',
      name: 'registrationDate',
      desc: '',
      args: [],
    );
  }

  /// `Electronic signature of the document`
  String get electronicSIgnature {
    return Intl.message(
      'Electronic signature of the document',
      name: 'electronicSIgnature',
      desc: '',
      args: [],
    );
  }

  /// `Attached documents`
  String get attachments {
    return Intl.message(
      'Attached documents',
      name: 'attachments',
      desc: '',
      args: [],
    );
  }

  /// `Payments`
  String get payments {
    return Intl.message('Payments', name: 'payments', desc: '', args: []);
  }

  /// `Licensee name`
  String get licenseeName {
    return Intl.message(
      'Licensee name',
      name: 'licenseeName',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Licensee TIN`
  String get licenseeTin {
    return Intl.message(
      'Licensee TIN',
      name: 'licenseeTin',
      desc: '',
      args: [],
    );
  }

  /// `Number in Registry`
  String get numberInReestr {
    return Intl.message(
      'Number in Registry',
      name: 'numberInReestr',
      desc: '',
      args: [],
    );
  }

  /// `Valid until`
  String get validUntill {
    return Intl.message('Valid until', name: 'validUntill', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Surname`
  String get surname {
    return Intl.message('Surname', name: 'surname', desc: '', args: []);
  }

  /// `Certificate serial number`
  String get certificateSerialNumber {
    return Intl.message(
      'Certificate serial number',
      name: 'certificateSerialNumber',
      desc: '',
      args: [],
    );
  }

  /// `Signature`
  String get signature {
    return Intl.message('Signature', name: 'signature', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Invoice Number`
  String get invoiceNumber {
    return Intl.message(
      'Invoice Number',
      name: 'invoiceNumber',
      desc: '',
      args: [],
    );
  }

  /// `Payment amount`
  String get paymentAmount {
    return Intl.message(
      'Payment amount',
      name: 'paymentAmount',
      desc: '',
      args: [],
    );
  }

  /// `Payment date`
  String get paymentDate {
    return Intl.message(
      'Payment date',
      name: 'paymentDate',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message('Paid', name: 'paid', desc: '', args: []);
  }

  /// `Open`
  String get open {
    return Intl.message('Open', name: 'open', desc: '', args: []);
  }

  /// `Expired`
  String get expired {
    return Intl.message('Expired', name: 'expired', desc: '', args: []);
  }

  /// `Canceled`
  String get canceled {
    return Intl.message('Canceled', name: 'canceled', desc: '', args: []);
  }

  /// `Application type`
  String get applicationType {
    return Intl.message(
      'Application type',
      name: 'applicationType',
      desc: '',
      args: [],
    );
  }

  /// `Application number`
  String get applicationNumber {
    return Intl.message(
      'Application number',
      name: 'applicationNumber',
      desc: '',
      args: [],
    );
  }

  /// `Field is required`
  String get requiredField {
    return Intl.message(
      'Field is required',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Minimum length: {minLength} characters`
  String minLength(int minLength) {
    return Intl.message(
      'Minimum length: $minLength characters',
      name: 'minLength',
      desc: '',
      args: [minLength],
    );
  }

  /// `Maximum length: {maxLength} characters`
  String maxLength(int maxLength) {
    return Intl.message(
      'Maximum length: $maxLength characters',
      name: 'maxLength',
      desc: '',
      args: [maxLength],
    );
  }

  /// `Actions`
  String get action {
    return Intl.message('Actions', name: 'action', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Select file`
  String get pickFile {
    return Intl.message('Select file', name: 'pickFile', desc: '', args: []);
  }

  /// `Error loading: {error}`
  String loadingError(String error) {
    return Intl.message(
      'Error loading: $error',
      name: 'loadingError',
      desc: '',
      args: [error],
    );
  }

  /// `No specializations available`
  String get noSpecialization {
    return Intl.message(
      'No specializations available',
      name: 'noSpecialization',
      desc: '',
      args: [],
    );
  }

  /// `Not paid`
  String get notPaid {
    return Intl.message('Not paid', name: 'notPaid', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `File`
  String get file {
    return Intl.message('File', name: 'file', desc: '', args: []);
  }

  /// `No file`
  String get noFile {
    return Intl.message('No file', name: 'noFile', desc: '', args: []);
  }

  /// `Application date`
  String get applicationDate {
    return Intl.message(
      'Application date',
      name: 'applicationDate',
      desc: '',
      args: [],
    );
  }

  /// `File is not available`
  String get fileIsNotAvailable {
    return Intl.message(
      'File is not available',
      name: 'fileIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exite {
    return Intl.message('Exit', name: 'exite', desc: '', args: []);
  }

  /// `Are you sure you want to exit the app?`
  String get areYouSure {
    return Intl.message(
      'Are you sure you want to exit the app?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Contact a support specialist`
  String get callTheOperator {
    return Intl.message(
      'Contact a support specialist',
      name: 'callTheOperator',
      desc: '',
      args: [],
    );
  }

  /// `Call the operator`
  String get operatorCall {
    return Intl.message(
      'Call the operator',
      name: 'operatorCall',
      desc: '',
      args: [],
    );
  }

  /// `Write in Telegram`
  String get writeInTelegramm {
    return Intl.message(
      'Write in Telegram',
      name: 'writeInTelegramm',
      desc: '',
      args: [],
    );
  }

  /// `Choose the language`
  String get chooseTheLanguage {
    return Intl.message(
      'Choose the language',
      name: 'chooseTheLanguage',
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
