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

  static String m0(reviewTime) => "${reviewTime} дней";

  static String m1(error) => "Ошибка загрузки: ${error}";

  static String m2(years) => "${years} (год)";

  static String m3(registrationDate) => "Дата выдачи: ${registrationDate}";

  static String m4(name) => "${name}, Привет";

  static String m5(position, count) => "Шаг ${position} из ${count}";

  static String m6(error) => "Ошибка загрузки: ${error}";

  static String m7(maxLength) => "Максимальная длина: ${maxLength} символов";

  static String m8(minLength) => "Минимальная длина: ${minLength} символов";

  static String m9(count) => "${count} услуг";

  static String m10(step) => "Шаг № ${step}";

  static String m11(days) => "Срок получения: ${days} дней";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "InPaymentProcess": MessageLookupByLibrary.simpleMessage(
      "В процессе оплаты",
    ),
    "action": MessageLookupByLibrary.simpleMessage("Действия"),
    "active": MessageLookupByLibrary.simpleMessage("Активный"),
    "add": MessageLookupByLibrary.simpleMessage("Добавить"),
    "address": MessageLookupByLibrary.simpleMessage("Адрес"),
    "all": MessageLookupByLibrary.simpleMessage("Все"),
    "allApplications": MessageLookupByLibrary.simpleMessage("Все заявки"),
    "allCategories": MessageLookupByLibrary.simpleMessage("Все категории"),
    "allDocuments": MessageLookupByLibrary.simpleMessage("Все документы"),
    "allinforeviewtime": m0,
    "applicants": MessageLookupByLibrary.simpleMessage("Заявители"),
    "applicationDate": MessageLookupByLibrary.simpleMessage("Дата заявки"),
    "applicationNumber": MessageLookupByLibrary.simpleMessage("Номер заявки"),
    "applicationType": MessageLookupByLibrary.simpleMessage("Тип заявки"),
    "applicationWasWithdrawn": MessageLookupByLibrary.simpleMessage(
      "Заявление отозвана",
    ),
    "applications": MessageLookupByLibrary.simpleMessage("Заявки"),
    "areYouSure": MessageLookupByLibrary.simpleMessage(
      "Вы хотите выйти из приложения?",
    ),
    "attachments": MessageLookupByLibrary.simpleMessage(
      "Приложенные документы",
    ),
    "authorizedBody": MessageLookupByLibrary.simpleMessage(
      "Уполномоченный орган",
    ),
    "back": MessageLookupByLibrary.simpleMessage("Назад"),
    "bottom_text": MessageLookupByLibrary.simpleMessage(
      "© 2024-2025 ОАО\'Удостоверяющие центры, государственные услуги и разработка цифровых программ\'",
    ),
    "callTheOperator": MessageLookupByLibrary.simpleMessage(
      "Связаться с специалистом поддержки",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Отменить"),
    "canceled": MessageLookupByLibrary.simpleMessage("Отменён"),
    "categories": MessageLookupByLibrary.simpleMessage("Категории"),
    "certificateSerialNumber": MessageLookupByLibrary.simpleMessage(
      "Серийный номер сертификата",
    ),
    "cherez_imzo": MessageLookupByLibrary.simpleMessage(
      "Для доступа в мобильное приложение, произведите вход при помощи сервиса ИМЗО.",
    ),
    "chooseTheLanguage": MessageLookupByLibrary.simpleMessage("Выберите язык"),
    "chooseTheMap": MessageLookupByLibrary.simpleMessage("Выберите карту"),
    "commonSettings": MessageLookupByLibrary.simpleMessage("Общие настройки"),
    "continueButton": MessageLookupByLibrary.simpleMessage("Продолжить"),
    "detailInformation": MessageLookupByLibrary.simpleMessage(
      "Детальная информация",
    ),
    "docIsEmpty": MessageLookupByLibrary.simpleMessage("Документ пустой"),
    "docIsNotLoadedOrEmpty": MessageLookupByLibrary.simpleMessage(
      "Документ ещё не загружен или пустой",
    ),
    "docNumber": MessageLookupByLibrary.simpleMessage("Номер документа"),
    "documentType": MessageLookupByLibrary.simpleMessage("Тип документа"),
    "documents": MessageLookupByLibrary.simpleMessage("Документы"),
    "dontExist": MessageLookupByLibrary.simpleMessage("Не имеется"),
    "dosntExist": MessageLookupByLibrary.simpleMessage("Не применяется"),
    "electronicSIgnature": MessageLookupByLibrary.simpleMessage(
      "Электронная подпись документа",
    ),
    "errorLoading": m1,
    "exitTheApp": MessageLookupByLibrary.simpleMessage("Выход с приложения"),
    "exite": MessageLookupByLibrary.simpleMessage("Выход"),
    "expired": MessageLookupByLibrary.simpleMessage("Просрочен"),
    "expiryDate": MessageLookupByLibrary.simpleMessage("Срок действия"),
    "expiryDateYears": m2,
    "failedToLoadDoc": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить документ",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Избранное"),
    "feeState": MessageLookupByLibrary.simpleMessage("Государственная пошлина"),
    "file": MessageLookupByLibrary.simpleMessage("Файл"),
    "fileIsNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Файл недоступен",
    ),
    "fillAgain": MessageLookupByLibrary.simpleMessage("Заполнить заново"),
    "filtereddocumentsindexregistrationdate": m3,
    "goToPayment": MessageLookupByLibrary.simpleMessage("Перейти к оплате"),
    "gosOrganizations": MessageLookupByLibrary.simpleMessage(
      "Государственные организации",
    ),
    "greeting": m4,
    "hasExpired": MessageLookupByLibrary.simpleMessage("Срок действия истек"),
    "help": MessageLookupByLibrary.simpleMessage("Помощь"),
    "inFillingProcess": MessageLookupByLibrary.simpleMessage(
      "В процессе заполнения",
    ),
    "inFillingProcessStep": m5,
    "invoiceNumber": MessageLookupByLibrary.simpleMessage("Номер инвойса"),
    "languageSettings": MessageLookupByLibrary.simpleMessage("Настройки языка"),
    "licenseeName": MessageLookupByLibrary.simpleMessage(
      "Наименование лицензиата",
    ),
    "licenseeTin": MessageLookupByLibrary.simpleMessage("ИНН лицензиата"),
    "linkToDocument": MessageLookupByLibrary.simpleMessage(
      "Ссылка на подтверждающий документ",
    ),
    "loadingError": m6,
    "main": MessageLookupByLibrary.simpleMessage("Главная"),
    "maxLength": m7,
    "minLength": m8,
    "monthlyFee": MessageLookupByLibrary.simpleMessage("Ежемесячный сбор"),
    "myApplications": MessageLookupByLibrary.simpleMessage("Мои заявки"),
    "myDocuments": MessageLookupByLibrary.simpleMessage("Мои документы"),
    "naRasmotrenii": MessageLookupByLibrary.simpleMessage("На рассмотрении"),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "ne_udayotsa_voyti": MessageLookupByLibrary.simpleMessage(
      "Не удается войти?",
    ),
    "no": MessageLookupByLibrary.simpleMessage("Нет"),
    "noApplication": MessageLookupByLibrary.simpleMessage("Нет заявлений"),
    "noDocuments": MessageLookupByLibrary.simpleMessage("Нет документов"),
    "noFile": MessageLookupByLibrary.simpleMessage("Нет файла"),
    "noServices": MessageLookupByLibrary.simpleMessage("Нет услуг"),
    "noSpecialization": MessageLookupByLibrary.simpleMessage(
      "Нет специализаций",
    ),
    "notAssigned": MessageLookupByLibrary.simpleMessage("Не подписанный"),
    "notFoundOrgs": MessageLookupByLibrary.simpleMessage(
      "Организации не найдены",
    ),
    "notInstalledMap": MessageLookupByLibrary.simpleMessage(
      "На устройстве нет установленных карт",
    ),
    "notPaid": MessageLookupByLibrary.simpleMessage("Не оплачено"),
    "nothingFound": MessageLookupByLibrary.simpleMessage("Ничего не найдено"),
    "numberInReestr": MessageLookupByLibrary.simpleMessage("Register number"),
    "open": MessageLookupByLibrary.simpleMessage("Открыт"),
    "operatorCall": MessageLookupByLibrary.simpleMessage("Позвонить оператору"),
    "orgdocumentscount": m9,
    "osnovniye_voprosi": MessageLookupByLibrary.simpleMessage(
      "Основные вопросы",
    ),
    "oznakomtesIpotverditeVseTrebovaniya": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, ознакомьтесь и подтвердите все требования",
    ),
    "paid": MessageLookupByLibrary.simpleMessage("Оплачен"),
    "paymentAmount": MessageLookupByLibrary.simpleMessage("Сумма платежа"),
    "paymentDate": MessageLookupByLibrary.simpleMessage("Дата оплаты"),
    "payments": MessageLookupByLibrary.simpleMessage("Платежи"),
    "pickFile": MessageLookupByLibrary.simpleMessage("Выберите файл"),
    "podrobnee": MessageLookupByLibrary.simpleMessage("Подробнее"),
    "poisk_uslug": MessageLookupByLibrary.simpleMessage("Поиск услуг"),
    "poluchay_uslugi_ne_vikhodya_iz_doma": MessageLookupByLibrary.simpleMessage(
      "Получай услуги не выходя из дома",
    ),
    "poluchitUslugu": MessageLookupByLibrary.simpleMessage("Получить услугу"),
    "price": MessageLookupByLibrary.simpleMessage("Стоимость:"),
    "privatePolicy": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "proizvesti_vkhod": MessageLookupByLibrary.simpleMessage(
      "Произвести вход в приложение",
    ),
    "registrationDate": MessageLookupByLibrary.simpleMessage("Дата выдачи"),
    "regulatingDocument": MessageLookupByLibrary.simpleMessage(
      "Регулирующий документ услуги",
    ),
    "rejected": MessageLookupByLibrary.simpleMessage("Отказано"),
    "repeat": MessageLookupByLibrary.simpleMessage("Повторить"),
    "requiredField": MessageLookupByLibrary.simpleMessage(
      "Поле обязательно для заполнения",
    ),
    "requirements": MessageLookupByLibrary.simpleMessage("Требования"),
    "reviewPeriodExpired": MessageLookupByLibrary.simpleMessage(
      "Срок рассмотрения истек",
    ),
    "ru": MessageLookupByLibrary.simpleMessage("RU"),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
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
    "shagNomer": m10,
    "signature": MessageLookupByLibrary.simpleMessage("Подпись"),
    "specialization": MessageLookupByLibrary.simpleMessage("Специализации"),
    "srokPolucheniyaDays": m11,
    "srokPolucheniyaOnline": MessageLookupByLibrary.simpleMessage(
      "Срок получения: Онлайн (мгновенно)",
    ),
    "srokRassmotreniyeIPredostavleniyeUslugi":
        MessageLookupByLibrary.simpleMessage(
          "Срок рассмотрения и предоставления услуги: ",
        ),
    "startSearching": MessageLookupByLibrary.simpleMessage("Начните поиск!"),
    "status": MessageLookupByLibrary.simpleMessage("Статус"),
    "support": MessageLookupByLibrary.simpleMessage("Поддержка"),
    "surname": MessageLookupByLibrary.simpleMessage("Фамилия"),
    "svernut": MessageLookupByLibrary.simpleMessage("Свернуть"),
    "validUntill": MessageLookupByLibrary.simpleMessage("Действует до"),
    "verifiedProfile": MessageLookupByLibrary.simpleMessage(
      "Подтвержденный профиль",
    ),
    "voyti_cherez_imzo": MessageLookupByLibrary.simpleMessage(
      "Войти с помощью ИМЗО",
    ),
    "whereAreWe": MessageLookupByLibrary.simpleMessage("Где мы находимся ?"),
    "writeInTelegramm": MessageLookupByLibrary.simpleMessage(
      "Написать в телеграм",
    ),
    "yes": MessageLookupByLibrary.simpleMessage("Да"),
  };
}
