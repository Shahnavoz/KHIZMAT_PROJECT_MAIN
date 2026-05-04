// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(registrationDate) => "Дата выдачи: ${registrationDate}";

  static String m1(position, count) => "Шаг ${position} из ${count}";

  static String m2(count) => "${count} услуг";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "InPaymentProcess": MessageLookupByLibrary.simpleMessage(
      "В процессе оплаты",
    ),
    "active": MessageLookupByLibrary.simpleMessage("Активный"),
    "all": MessageLookupByLibrary.simpleMessage("Все"),
    "allApplications": MessageLookupByLibrary.simpleMessage("Все заявки"),
    "allCategories": MessageLookupByLibrary.simpleMessage("Все категории"),
    "allDocuments": MessageLookupByLibrary.simpleMessage("Все документы"),
    "applicationWasWithdrawn": MessageLookupByLibrary.simpleMessage(
      "Заявление отозвана",
    ),
    "applications": MessageLookupByLibrary.simpleMessage("Заявки"),
    "bottom_text": MessageLookupByLibrary.simpleMessage(
      "© 2024-2025 ОАО\'Удостоверяющие центры, государственные услуги и разработка цифровых программ\'",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Отменить"),
    "categories": MessageLookupByLibrary.simpleMessage("Категории"),
    "cherez_imzo": MessageLookupByLibrary.simpleMessage(
      "Для доступа в мобильное приложение, произведите вход при помощи сервиса ИМЗО.",
    ),
    "documents": MessageLookupByLibrary.simpleMessage("Документы"),
    "favorites": MessageLookupByLibrary.simpleMessage("Избранное"),
    "filtereddocumentsindexregistrationdate": m0,
    "gosOrganizations": MessageLookupByLibrary.simpleMessage(
      "Государственные организации",
    ),
    "hasExpired": MessageLookupByLibrary.simpleMessage("Срок действия истек"),
    "inFillingProcess": MessageLookupByLibrary.simpleMessage(
      "В процессе заполнения",
    ),
    "inFillingProcessStep": m1,
    "main": MessageLookupByLibrary.simpleMessage("Главная"),
    "myApplications": MessageLookupByLibrary.simpleMessage("Мои заявки"),
    "myDocuments": MessageLookupByLibrary.simpleMessage("Мои документы"),
    "naRasmotrenii": MessageLookupByLibrary.simpleMessage("На рассмотрении"),
    "ne_udayotsa_voyti": MessageLookupByLibrary.simpleMessage(
      "Не удается войти?",
    ),
    "noApplication": MessageLookupByLibrary.simpleMessage("Нет заявлений"),
    "noDocuments": MessageLookupByLibrary.simpleMessage("Нет документов"),
    "noServices": MessageLookupByLibrary.simpleMessage("Нет услуг"),
    "notAssigned": MessageLookupByLibrary.simpleMessage("Не подписанный"),
    "notFoundOrgs": MessageLookupByLibrary.simpleMessage(
      "Организации не найдены",
    ),
    "nothingFound": MessageLookupByLibrary.simpleMessage("Ничего не найдено"),
    "orgdocumentscount": m2,
    "osnovniye_voprosi": MessageLookupByLibrary.simpleMessage(
      "Основные вопросы",
    ),
    "podrobnee": MessageLookupByLibrary.simpleMessage("Подробнее"),
    "poisk_uslug": MessageLookupByLibrary.simpleMessage("Поиск услуг"),
    "poluchay_uslugi_ne_vikhodya_iz_doma": MessageLookupByLibrary.simpleMessage(
      "Получай услуги не выходя из дома",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "proizvesti_vkhod": MessageLookupByLibrary.simpleMessage(
      "Произвести вход в приложение",
    ),
    "rejected": MessageLookupByLibrary.simpleMessage("Отказано"),
    "reviewPeriodExpired": MessageLookupByLibrary.simpleMessage(
      "Срок рассмотрения истек",
    ),
    "ru": MessageLookupByLibrary.simpleMessage("RU"),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "searchDocsAndApplications": MessageLookupByLibrary.simpleMessage(
      "Поиск документов и заявок",
    ),
    "searchOrganization": MessageLookupByLibrary.simpleMessage(
      "Поиск организаций",
    ),
    "seenSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Успешно рассмотрено",
    ),
    "serviceCategories": MessageLookupByLibrary.simpleMessage(
      "Категории услуг",
    ),
    "services": MessageLookupByLibrary.simpleMessage("Услуги"),
    "startSearching": MessageLookupByLibrary.simpleMessage("Начните поиск!"),
    "svernut": MessageLookupByLibrary.simpleMessage("Свернуть"),
    "voyti_cherez_imzo": MessageLookupByLibrary.simpleMessage(
      "Войти с помощью ИМЗО",
    ),
  };
}
