import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    print('Could not launch $url: $e');
  }
}

void openFile(PlatformFile file) {
  OpenFile.open(file.path);
}

void makePhoneCall(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  final parsed = Uri.parse(url);
  // final url='sms:$phoneNumber';
  try {
    if (await canLaunchUrl(parsed)) {
      await launchUrl(parsed);
    }
  } catch (e) {
    throw Exception(e);
  }
}

/// Открывает Telegram по username, ID, боту или каналу
Future<void> openTelegram(String telegramIdentifier) async {
  // Убираем лишние символы: @, пробелы и т.д.
  final cleaned = telegramIdentifier.trim().replaceAll('@', '');

  if (cleaned.isEmpty) {
    throw Exception("Telegram username не может быть пустым");
  }

  // Список возможных ссылок (пробуем по очереди — что сработает, то и откроет)
  final urls = [
    'tg://resolve?domain=$cleaned', // Основной способ (открывает в приложении)
    'https://t.me/$cleaned', // Открывает в браузере → перекидывает в приложение
    'https://telegram.me/$cleaned', // Альтернатива
  ];

  for (final urlString in urls) {
    final uri = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return; // Успешно открыли — выходим
      }
    } catch (e) {
      continue; // Пробуем следующий вариант
    }
  }

  // Если ничего не сработало
  throw Exception("Не удалось открыть Telegram. Установлено ли приложение?");
}

String? validateCertificateOwner(
  String? value, {
  bool isIndividualEntrepreneur = false,
}) {
  if (value == null || value.trim().isEmpty) {
    return 'Поле обязательно для заполнения';
  }

  final parts = value.trim().split(' ');

  if (!isIndividualEntrepreneur) {
    if (parts.length < 3) {
      return 'Введите полное ФИО (Фамилия Имя Отчество)';
    }
  } else {
    if (parts.length < 4) {
      return 'Введите ФИО и статус ИП полностью';
    }
  }

  return null;
}
